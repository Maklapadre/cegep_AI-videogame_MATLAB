
% Modify your threshold function so it work with a RBG threshold. 
% Format of the function:
% [binIm] = M04_P5_threshold(imMat, Rval,Gval, Bval, colErr)
% % % Rval, Gval, Bval are the pixel values of the specific color that you try to identify
% % % colErr is range of colors accepted around Rval, Gval, Bval. 
% % % Ex. The red color range will be [Rval-colErr , Rval+colErr]
% % % colErr is optional and is set to 40 (for a 255 image) by default

% You should use varargin and adapt the function to the initial one you built. 
% % % If the function receives 2 arguments, it works as M04P3_thresholdGS.
% % % If it receives 4 arguments, the threshold is in true color
% % % If it receives 5 arguments, the last one sets the value of the error range 

% Then, read the tennis image from the moodle pack. 
% Using the figure viewer, estimate the color of the tennis ball.
% Use your new function to isolate the ball


function [binIm, varargout] = M04_P5_threshold_AndreKolstad(imMatrix, varargin)
     
        %I'm letting the user input the name of the image instead 
        %of the "imread" of the image.    
        imMatrix = imread(imMatrix);
        
        %I now want to know if the matrix of the image is in 0-1 or 0-255 
        % --> if it's 0-1, I'm transforming it to 0-255
        if isfloat(imMatrix)
            imMatrix = uint8(round(imMatrix*255));
        end

        %If the values of the varargin given are between 0 and 1, I will
        %send the user an error message telling them to put it in integer
        %values.
        for i = 1:length(varargin)
            if varargin{i} < 1
                error('Your values should be integers between 1 and 255.')
            end
        end
        
    if length(varargin) == 1
            value = varargin{1};
            %I first want to know if it's a grayscale or true color image
            if size(imMatrix, 3) == 1
                %then there is only one layer, meaning it's grayscale
            elseif size(imMatrix, 3) == 3
                %then there are three layers, meaning it's true color
                %so, I transform it into grayscale
                imMatrix = rgb2gray(imMatrix);
            else
                %then there is the wrong amount of layers...
                error('The matrix inserted has the wrong dimensions...')
            end
            
            %this boolean question does the thresholding.
            %For every value of imMatrix, if the value of the matrix is
            %bigger than the inserted value, it will become a boolean 1.
            imMatrix = imMatrix > value;

            imshow(imMatrix)
      elseif length(varargin) == 3 || length(varargin) == 4
          %if the length of varargin is 3, then it means that the user gave
          %us a value for the Red, Green and Blue layers.  If the varargin 
          %is 4, the user enters a color error, which will overrule the default one. 
          
          %if the matrix doesn't have 3 layers (often, it would be 1 layer, 
          %because it would be a grayscale image), the program tells the
          %user to put a true color image.
          if size(imMatrix, 3) ~= 3
              error('Your image should be in true color.')
          end
          
          %If the user only puts 3 varargins, the default color error will
          %automatically be 40. If they add a fourth value though, that
          %value will replace the default and become the new color error.
          colErr = 40;
          if length(varargin) == 4
              colErr = varargin{4};
          end
          
%steps: 1. associer valeurs à chaque layer (value red, value green,
%value blue). 2. comparer valeurs de chaque layer à chaque matrice de l'image. 3. 

          Rvalue = varargin{1};
          Gvalue = varargin{2};
          Bvalue = varargin{3};

%I defined the conditions (I defined separately instead of at the same time, since it works better like this)    
%I'm basically creating a bunch of logical matrices that are defined by my
%conditions, transforming the 0-255 values into 0s and 1s. I am defining
%minimal and maximal conditions, which are basically the maximum and
%minimum of the desired range of each color.
        cond_Rmax = imMatrix(:,:,1) < Rvalue+colErr;
        cond_Rmin = imMatrix(:,:,1) > Rvalue-colErr;
        cond_Gmax = imMatrix(:,:,2) < Gvalue+colErr;
        cond_Gmin = imMatrix(:,:,2) > Gvalue-colErr;
        cond_Bmax = imMatrix(:,:,3) < Bvalue+colErr;
        cond_Bmin = imMatrix(:,:,3) > Bvalue-colErr;
        
%I found this '&' function on the internet, which acts similarly to && but 
%mixes two matrices together without having the 'Operands to
%the || and && operators must be convertible to logical scalar values'
%problem. For each position in the matrices that are compared, it checks if 
%there is a 0. If there aren't any 0s, that position in the new matrix
%becomes 1. If there is one 0 or if both are 0s, it becomes 0 in the new
%matrix.
%So, I'm creating three logical matrices where both the minimal and 
%maximum conditions are true.
        RbinIm = cond_Rmax & cond_Rmin;
        GbinIm = cond_Gmax & cond_Gmin;
        BbinIm = cond_Bmax & cond_Bmin;
        
%Here, I'm comparing the color layers. So, for a certain position in the
%matrix, if all Red, Green and Blue values are true, then a new matrix is
%created where that value at that position is true. If only one, two or none 
%is true, the new matrix will have a false value at that position.  
%This new matrix is the final binary image.
        binIm = RbinIm & GbinIm & BbinIm;
     
        %SEUL CHANGEMENT!!! ENLEVER IMSHOW!!!
        %imshow(binIm)
        
    else
        error('Check your amount of inputs.')
    end
     
clc
end





