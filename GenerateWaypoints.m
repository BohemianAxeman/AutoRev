%%  
% In order to generate waypoints, we need to know: 
% 1) where are the satellites currently?
% 2) How do we want to get there? --> Impulsive, Hohmann, min time/fuel, # of revs?
% 
%
%

%%

function GenerateWaypoints()
    

    switch Mnvr_Type

        case 'Hohmann'
        case 'Inc'
        case 'MinTime'
        case 'MinFuel'
        otherwise
    end
    
end