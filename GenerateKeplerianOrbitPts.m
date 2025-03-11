function [X, Y] = GenerateKeplerianOrbitPts(a, e, theta_range)

if nargin < 3  % if theta_range is not provided
    theta_range = [0 2*pi];
end

% Define angles (true anomaly)
theta = linspace(theta_range(1), theta_range(2), 100); 

% Compute orbit positions (r, theta)
r = a * (1 - e^2) ./ (1 + e * cos(theta)); % Keplerian equation

% Convert to Cartesian coordinates
X = r .* cos(theta);
Y = r .* sin(theta);

end