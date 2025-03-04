%%

%%
function PropagateState()


switch prop_method
    case 'TwoBody'
        prop_twoBody()
    case 'J2'
        prop_perts()
    case 'perts'
        prop_perts()
    otherwise

end