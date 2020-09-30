function [topFeatures] = Lucas_Kanade(I, J, topFeatures, window);
% Lucas Kanade Function 
% the goal of this function is to track the features that are selected and
% see how they behave throughout the image sequence
%   Variable Exlanation----



sigma = .6;

[gxy, iangle, Gx, Gy] = MagnitudeGradient(I, sigma);

for i=1: size(topFeatures)
    
    featurepointX = topFeatures(i,1);
    featurepointY = topFeatures(i,2);
    u = [0 0];%displacement vector initialized to zero 
    deltau = 0;%incremental displacement vector initialized to zero
    [Z]=Compute2x2GradientMatrix(Gx,Gy,featurepointX,featurepointY, window); 
    iter = 0;
    while(1)%iterations to update deltau
        [err]=Compute2x1ErrorVector(I,J,Gx,Gy, featurepointX, featurepointY, window,u);
        [deltau]=Solve2x1LinearSystem(Z,err);
        %update u
        u(1)=u(1)+deltau(1); %Horizontal 
        u(2)=u(2)+deltau(2); %Vertical 
        %break while if udelta is small or iter exceeds threshold 
        if(iter+1 > 10) %typically 10 iters
            break;
        end
        if(deltau <=0.2)
            break;
        end
        iter = iter + 1;
    end
   
         %Update featurepoint in topfeatures
         topFeatures(i,1)=topFeatures(i,1) + u(2); % add the correct displacement to correct u
         topFeatures(i,2)=topFeatures(i,2) + u(1);
        
end




end

