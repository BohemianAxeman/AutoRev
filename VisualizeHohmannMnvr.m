%%

%%
function VisualizeHohmannMnvr(burnSequence, results, configs)

arguments
    burnSequence mnvrSequence % restricts input to type mnvrSequence
    results struct
    configs ConfigurationSettings
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
    title('Hohmann Transfer')
    subtitle(sprintf('Transfer from %.1f to %.1f', results.r1, results.r2))

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
    plot(X_chs, Y_chs, 'g')
    plot(X_trg, Y_trg, 'r')

    % Generate points on Transfer Orbit and Plot
    if results.trans_kep_ele.TA == 0 % Transfer orbit starts at perigee and moves to apogee
        [X_trans, Y_trans] = GenerateKeplerianOrbitPts(results.trans_kep_ele.SMA, results.trans_kep_ele.ECC, [0, pi]);
    else % Transfer orbit starts at apogee and moves to perigee
        [X_trans, Y_trans] = GenerateKeplerianOrbitPts(results.trans_kep_ele.SMA, results.trans_kep_ele.ECC, [pi, 2*pi]);
    end

    plot(X_trans, Y_trans, 'b--')

    % Plot Mnvr text data
    plot(X_trans(1), Y_trans(1), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k')
    text(X_trans(1) + 500, Y_trans(1) + 500, sprintf('Burn %d\nΔV = %.1f km/s', 1, burnSequence(1).dv), ...
        'Color', 'k', 'FontSize', 12, 'FontWeight', 'bold');
    plot(X_trans(end), Y_trans(end), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k')
    text(X_trans(end) + 500, Y_trans(end) + 500, sprintf('Burn %d\nΔV = %.1f km/s', 2, burnSequence(2).dv), ...
        'Color', 'k', 'FontSize', 12, 'FontWeight', 'bold');


end

end