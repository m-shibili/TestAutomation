SysvarHeader = """<?xml version="1.0" encoding="utf-8"?>
<systemvariables version="4">
<namespace name="" comment="" interface="">\n   <namespace name="HIL_Interface" comment="" interface="">\n      <namespace name="CAN_OverRide" comment="" interface="">
"""
SysvarFooter = "      </namespace>\n  </namespace>\n</namespace>\n</systemvariables>"

mheader = """
function autoCreateModel
fname = 'autoCreatedModel';
if exist(fname,'file') == 4
    if bdIsLoaded(fname)
        close_system(fname,0)
    end

    delete([fname,'.mdl']);
end
new_system(fname);
"""
mfooter = """ 
set_param(gcs,...
'Solver','FixedStepDiscrete',...
'FixedStep','0.1');
save_system(fname);"""
BusCreator = "add_block('simulink/Signal Routing/Bus Creator', [gcs,'/$MESSAGE$_$BUS$']);"
ValueOVblock =         """
add_block('simulink/Ports & Subsystems/Out1', [gcs '/$NODE$_EnabledSubsystem/$OV$_port']);
SubsysPortHandles = get_param( [gcs '/$NODE$_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/$NODE$_EnabledSubsystem/$OV$'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::$NODE$::$MESSAGE$::$SIGNAL$::$OV$','editSampleTime','0.001','Position', [$X$ $Y$ $W$ $H$]);
add_line([gcs '/$NODE$_EnabledSubsystem'], '$OV$/1', '$OV$_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion$N$']);
CovertPortHandles = get_param( [gcs '/SignalConvertion$N$'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport($N$), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/$MESSAGE$_$BUS$'], 'Inputs', '$PORT$');
lineHandle = add_line(gcs,'SignalConvertion$N$/1','$MESSAGE$_$BUS$/$PORT$','autorouting','on');
set_param(lineHandle, 'Name', '$OV$');

"""
EnableOVblock =         """
add_block('simulink/Ports & Subsystems/Out1', [gcs '/$NODE$_EnabledSubsystem/$OV$_port']);
SubsysPortHandles = get_param( [gcs '/$NODE$_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/$NODE$_EnabledSubsystem/$OV$'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::$NODE$::$MESSAGE$::$SIGNAL$::$OV$','editSampleTime','0.001','Position', [$X$ $Y$ $W$ $H$]);
add_line([gcs '/$NODE$_EnabledSubsystem'], '$OV$/1', '$OV$_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion$N$']);
CovertPortHandles = get_param( [gcs '/SignalConvertion$N$'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport($N$), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_$OV$']);
AndPortHandles = get_param( [gcs '/AND_$OV$'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_$OV$/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/$MESSAGE$_$BUS$'], 'Inputs', '$PORT$');
$OV$Handle = add_line(gcs,'AND_$OV$/1','$MESSAGE$_$BUS$/$PORT$','autorouting','on');
set_param($OV$Handle, 'Name', '$OV$');
"""

Nodeblock = "add_block('simulink/Signal Routing/Bus Creator', [gcs,'/$NODE$']);"
GlobalOV = "add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/GLOBAL_OV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::GlobalOverride::En_Global_OverRide','editSampleTime','0.001','Position', [0 0 50 30]);"
SysvarSubsytem = """
add_block('simulink/Ports & Subsystems/Enabled Subsystem', [gcs '/$NODE$_EnabledSubsystem']);
delete_block([gcs '/$NODE$_EnabledSubsystem/In1']);
delete_block([gcs '/$NODE$_EnabledSubsystem/Out1']);"""

NodeBusCreator = """
set_param([gcs,'/$NODE$'], 'Inputs', '$NODEBUS_PORT$')
lineHandle = add_line(gcs,'$MESSAGE$_$BUS$/1','$NODE$/$NODEBUS_PORT$','autorouting','on')
set_param(lineHandle, 'Name', '$MESSAGE$');
"""