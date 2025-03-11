%% 
% Computes the delta-v required to follow a Hohmann Transfer maneuver for a Chaser obj to
% reach a Target obj

% A Homann transfer uses: 
% --> the lowest possible amount of impulse to accomplish the transfer
% ----] impulse is proporational to delta-v, thus propellant consumed
% --> requires relatively longer travel time compared to higher impulsve transfers

% We also want to make sure the target and chaser are properly aligned in their orbits
% initially, such that the chaser will arrive at the target's orbit right as the target reaches
% the same spot in its orbit

%%
function [burnSequence, results] = tx_Hohmann(chs_r_ECI_km, chs_v_ECI_kmps, trg_r_ECI_km, trg_v_ECI_kmps)

arguments
    chs_r_ECI_km (:,3) double
    chs_v_ECI_kmps (:,3) double
    trg_r_ECI_km (:,3) double
    trg_v_ECI_kmps (:,3) double
end

r1 = vecnorm(chs_r_ECI_km, 2, 2); r2 = vecnorm(trg_r_ECI_km, 2, 2);
v1 = vecnorm(chs_v_ECI_kmps, 2, 2); v2 = vecnorm(trg_v_ECI_kmps, 2, 2);
mu = CONST.mu_earth_km;

% Compute dv1
v1_ideal = sqrt(mu/r1);
v1_trans = sqrt(2*mu*r2/(r1*(r1+r2)));
dv1 = v1_trans - v1;

% Compute dv2
v2_ideal = sqrt(mu/r2);
v2_trans = sqrt(2*mu*r1/(r2*(r1+r2)));
dv2 = v2_trans - v2;

% Compute Time of Flight (TOF)
t_TOF = pi*sqrt((r1+r2)^3/(8*mu));

% Compute Angular Alignment
% Computes the angular arc (in radians) between the chaser and target at the time of the first
% impulsive mnvr such that the chaser arrives at the target's orbit right as the target is
% getting there
% d_theta = pi - w2 * t_TOF, where w2 = sqrt(mu/r2^3) [the angular velocity of the target in
% its orbit]
w2 = sqrt(mu/r2^3);
d_theta = pi - w2 * t_TOF;
% d_theta = pi*(1 - 1/(2*sqrt(2)) * sqrt((r1/r2 + 1)^3)) % perhaps a more efficient calculation

% Compute transfer orbit keplerian elements
SMA_trans = (r1 + r2)/2;
if (r2 > r1) % Going from lower orbit to higher orbit
    ECC_trans = (r2 - r1) / (r2 + r1);
    theta_trans = 0;
else % Going from higher orbit to lower orbit
    ECC_trans = (r1 - r2) / (r2 + r1);
    theta_trans = pi;
end

% Store results
results.r1 = r1; results.r2 = r2; results.mu = mu;
results.dv1 = dv1; results.v1 = v1; results.v1_trans = v1_trans; results.v1_ideal = v1_ideal;
results.dv2 = dv2; results.v2 = v2; results.v2_trans = v2_trans; results.v2_ideal = v2_ideal;
results.TOF = t_TOF;
results.d_theta = d_theta;
results.trans_kep_ele = KeplerianElements(SMA_trans, ECC_trans, 0, 0, 0, theta_trans);

% Maybe we should just return the results as a burn sequence, with extras contained in a
% separate struct?
burnSequence(1) = mnvrSequence('chaser', dv1, 'Impulsive', [1 0 0], 0, 0);
burnSequence(2) = mnvrSequence('chaser', dv2, 'Impulsive', [1,0,0], 0, t_TOF);


end