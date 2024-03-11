
clc;
clear all;
close all;

% Relationship between S and Z domain: z = exp(sT) for s = sigma + jw
% z = r * exp(jp)=r*(cosp + jsinp) 
% where r = exp(sigma) is magnitude and p = w * T is phase

T = 0.3; % Sampling time

sigma={-25:0.01:0, -25:0.01:0, -25, -35:0.01:-25}; %sigma values from the given figures
w={-sigma{1}, 5, -5:0.01:5, (-5:0.01:5)}; %jw values from the given figures

grapharray=[ "a" "b" "c" "d" ]; %namings array for the upcoming plottings


for i=1:length(sigma)
    
%plot S plane figures    
    figure (2); 
    subplot(2,2,i)
    
    if i==4 % if fourth graph(d) use meshgrid
        [Sigma, W] = meshgrid(sigma{i}, w{i}); %creating a meshgrid     
        Complex= Sigma + 1j*W;                
        plot(real(Complex(:)), imag(Complex(:)), '.')
    else
        complex= sigma{i} + 1j*w{i}; %complex s plane function for plotting
        plot(complex, 'Linewidth', 2); %plot s function
    end
    
    grid on;
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    xlabel('\bf \sigma');
    ylabel('\bf jw');
    graphname = "figure " + "(" + grapharray(i) + ")";
    title(graphname);
    axis padded
    sgtitle('S-plane equivalent');
    
    
 %plot Z plane figures   
    figure (1); 
    subplot(2,2,i)
    
    
    if i==4 %if fourth graph use meshgrid
        z=exp(Sigma*T); %calculating z-plane magnitude
        p = W * T; %calculating z-plane phase
        Z = z .* ( cos(p) + 1j* sin(p) ); %calculating z-plane function
        plot(real(Z(:)), imag(Z(:)), 'k' , 'LineWidth', 2); %plot z function
        
    else %for others plot regularly since they're just curves
        z=exp(sigma{i}*T); %calculating z-plane magnitude
        p = w{i} * T; %calculating z-plane phase
        Z = z .* ( cos(p) + 1j* sin(p) ); %calculating z-plane function
        plot(real(Z), imag(Z), 'k' , 'LineWidth', 2); %plot z function
        
            %if the Z function if large enough, display unit circle
            if abs(max(real(Z)))>0.5 || abs(max(imag(Z)))>0.5
            hold on
            theta = linspace(0, 2*pi, 100);
            unit_circle = exp(1j * theta);
            plot(real(unit_circle), imag(unit_circle), '.', 'LineWidth', 2);
            end
    end
    
    grid on;
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    xlabel('\bf R');
    ylabel('\bf IM');
    graphname = "figure " + "(" + grapharray(i) + ")";
    title(graphname);
    axis padded
    sgtitle('Z-plane equivalent');
    
end



