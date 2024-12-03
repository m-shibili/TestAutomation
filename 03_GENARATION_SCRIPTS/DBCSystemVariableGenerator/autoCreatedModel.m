
function autoCreatedModel
fname = 'autoCreatedModel';

if exist(fname,'file') == 4
    if bdIsLoaded(fname)
        close_system(fname,0)
    end
    disp("Delete")
    delete([fname,'.slx']);
    delete([fname,'.mdl']);
end
new_system(fname);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %








add_block('simulink/Commonly Used Blocks/Subsystem', [gcs,'/$NODE$'])
delete_block([gcs '/$NODE$/In1']);
delete_block([gcs '/$NODE$/Out1']);

add_block( 'simulink/Signal Routing/Bus Selector', [gcs,'$NODE$/BusSelector']);
add_block('simulink/Commonly Used Blocks/Switch', [gcs, '$NODE$/Switch'])
set_param(gcb,'OutputSignals','signal1')
set_param(gcb,'OutputSignals','signal2')








% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
 
set_param(gcs,...
'Solver','FixedStepDiscrete',...
'FixedStep','0.1');
save_system(fname);
open_system(fname);