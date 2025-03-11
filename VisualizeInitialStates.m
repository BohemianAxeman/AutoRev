%%

%%
function VisualizeInitialStates(configs)

arguments
    configs ConfigurationSettings % restricts input to type ConfigurationSettings
end

chs = configs.sats.chs;
trg = configs.sats.trg;
xPlotMax = max(max(abs(chs.r_ECI_km), abs(trg.r_ECI_km)));

h = figure; hold on

if configs.Mnvr_Type == mnvrTypeEnum.Hohmann
    % Plot 2D
    chs_2D = [chs.r_ECI_km(1), chs.r_ECI_km(2)];
    trg_2D = [trg.r_ECI_km(1), trg.r_ECI_km(2)];

    % Define circle parameters to plot Earth
    r = xPlotMax/25; % Radius
    theta = linspace(0, 2*pi, 100); % Angle values
    x = r * cos(theta); % X coordinates
    y = r * sin(theta); % Y coordinates
    
    % Plot filled circle
    fill(x, y, 'b', 'EdgeColor', 'none'); % 'b' for blue, 'EdgeColor' set to none for a clean look
    
    % Adjust plot appearance
    axis equal; % Keep the aspect ratio square
    xlim([-xPlotMax xPlotMax]*1.1);
    ylim([-xPlotMax xPlotMax]*1.1);
    grid on;

    % Plot Chaser and Target positions
    plot(chs_2D(1), chs_2D(2), 'gs')
    plot(trg_2D(1), trg_2D(2), 'rs')

    % Plot Chaser and Target velocity vectors
    arrow_length = 10000;
    chs_vel_norm = chs.v_ECI_kmps / norm(chs.v_ECI_kmps) * arrow_length;
    trg_vel_norm = trg.v_ECI_kmps / norm(trg.v_ECI_kmps) * arrow_length;

    quiver(chs_2D(1), chs_2D(2), chs_vel_norm(1), chs_vel_norm(2), 0.5, 'g', 'LineWidth', 2, 'MaxHeadSize', 20)
    quiver(trg_2D(1), trg_2D(2), trg_vel_norm(1), trg_vel_norm(2), 0.5, 'r', 'LineWidth', 2, 'MaxHeadSize', 20)

    % Generate points on Keplerian Orbit
    [X_chs, Y_chs] = GenerateKeplerianOrbitPts(chs.kep_elements.SMA, chs.kep_elements.ECC);
    [X_trg, Y_trg] = GenerateKeplerianOrbitPts(trg.kep_elements.SMA, trg.kep_elements.ECC);

    % Plot Orbit Points
    plot(X_chs, Y_chs, 'g--')
    plot(X_trg, Y_trg, 'r--')



end

end