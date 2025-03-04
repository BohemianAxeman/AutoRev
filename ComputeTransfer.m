%%

%%
function ComputeTransfer()

    switch Mnvr_type
        case 'Hohmann'
            tx_Hohmann()
        case 'Inc'
            tx_Inc()
        case 'Lambert'
            tx_Lambert()
        otherwise
    end


end