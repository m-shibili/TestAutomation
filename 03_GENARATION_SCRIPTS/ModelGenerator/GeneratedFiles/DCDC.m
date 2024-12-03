
function autoCreateModel
fname = 'autoCreatedModel';
if exist(fname,'file') == 4
    if bdIsLoaded(fname)
        close_system(fname,0)
    end

    delete([fname,'.mdl']);
end
new_system(fname);
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/GLOBAL_OV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::GlobalOverride::En_Global_OverRide','editSampleTime','0.001','Position', [0 0 50 30]);
add_block('simulink/Signal Routing/Bus Creator', [gcs,'/DCDC']);

add_block('simulink/Ports & Subsystems/Enabled Subsystem', [gcs '/DCDC_EnabledSubsystem']);
delete_block([gcs '/DCDC_EnabledSubsystem/In1']);
delete_block([gcs '/DCDC_EnabledSubsystem/Out1']);
add_block('simulink/Signal Routing/Bus Creator', [gcs,'/x392_NDCDCStatus_1']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCAuxIsoEnabled_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCAuxIsoEnabled'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCAuxIsoEnabled::En_OverRide_BDCDCAuxIsoEnabled','editSampleTime','0.001','Position', [20 65 70 95]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCAuxIsoEnabled/1', 'En_OverRide_BDCDCAuxIsoEnabled_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion1']);
CovertPortHandles = get_param( [gcs '/SignalConvertion1'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(1), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCAuxIsoEnabled']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCAuxIsoEnabled'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCAuxIsoEnabled/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '1');
En_OverRide_BDCDCAuxIsoEnabledHandle = add_line(gcs,'AND_En_OverRide_BDCDCAuxIsoEnabled/1','x392_NDCDCStatus_1/1','autorouting','on');
set_param(En_OverRide_BDCDCAuxIsoEnabledHandle, 'Name', 'En_OverRide_BDCDCAuxIsoEnabled');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCAuxIsoEnabled_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCAuxIsoEnabled'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCAuxIsoEnabled::Val_OverRide_BDCDCAuxIsoEnabled','editSampleTime','0.001','Position', [20 125 70 155]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCAuxIsoEnabled/1', 'Val_OverRide_BDCDCAuxIsoEnabled_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion2']);
CovertPortHandles = get_param( [gcs '/SignalConvertion2'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(2), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion2/1','x392_NDCDCStatus_1/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCAuxIsoEnabled');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCBB1OtpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCBB1OtpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCBB1OtpError::En_OverRide_BDCDCBB1OtpError','editSampleTime','0.001','Position', [20 185 70 215]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCBB1OtpError/1', 'En_OverRide_BDCDCBB1OtpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion3']);
CovertPortHandles = get_param( [gcs '/SignalConvertion3'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(3), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCBB1OtpError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCBB1OtpError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCBB1OtpError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '3');
En_OverRide_BDCDCBB1OtpErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCBB1OtpError/1','x392_NDCDCStatus_1/3','autorouting','on');
set_param(En_OverRide_BDCDCBB1OtpErrorHandle, 'Name', 'En_OverRide_BDCDCBB1OtpError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCBB1OtpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCBB1OtpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCBB1OtpError::Val_OverRide_BDCDCBB1OtpError','editSampleTime','0.001','Position', [20 245 70 275]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCBB1OtpError/1', 'Val_OverRide_BDCDCBB1OtpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion4']);
CovertPortHandles = get_param( [gcs '/SignalConvertion4'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(4), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion4/1','x392_NDCDCStatus_1/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCBB1OtpError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCBB2OtpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCBB2OtpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCBB2OtpError::En_OverRide_BDCDCBB2OtpError','editSampleTime','0.001','Position', [20 305 70 335]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCBB2OtpError/1', 'En_OverRide_BDCDCBB2OtpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion5']);
CovertPortHandles = get_param( [gcs '/SignalConvertion5'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(5), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCBB2OtpError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCBB2OtpError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCBB2OtpError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '5');
En_OverRide_BDCDCBB2OtpErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCBB2OtpError/1','x392_NDCDCStatus_1/5','autorouting','on');
set_param(En_OverRide_BDCDCBB2OtpErrorHandle, 'Name', 'En_OverRide_BDCDCBB2OtpError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCBB2OtpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCBB2OtpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCBB2OtpError::Val_OverRide_BDCDCBB2OtpError','editSampleTime','0.001','Position', [20 365 70 395]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCBB2OtpError/1', 'Val_OverRide_BDCDCBB2OtpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion6']);
CovertPortHandles = get_param( [gcs '/SignalConvertion6'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(6), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion6/1','x392_NDCDCStatus_1/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCBB2OtpError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCBB3OtpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCBB3OtpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCBB3OtpError::En_OverRide_BDCDCBB3OtpError','editSampleTime','0.001','Position', [20 425 70 455]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCBB3OtpError/1', 'En_OverRide_BDCDCBB3OtpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion7']);
CovertPortHandles = get_param( [gcs '/SignalConvertion7'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(7), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCBB3OtpError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCBB3OtpError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCBB3OtpError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '7');
En_OverRide_BDCDCBB3OtpErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCBB3OtpError/1','x392_NDCDCStatus_1/7','autorouting','on');
set_param(En_OverRide_BDCDCBB3OtpErrorHandle, 'Name', 'En_OverRide_BDCDCBB3OtpError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCBB3OtpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCBB3OtpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCBB3OtpError::Val_OverRide_BDCDCBB3OtpError','editSampleTime','0.001','Position', [20 485 70 515]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCBB3OtpError/1', 'Val_OverRide_BDCDCBB3OtpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion8']);
CovertPortHandles = get_param( [gcs '/SignalConvertion8'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(8), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion8/1','x392_NDCDCStatus_1/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCBB3OtpError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCBB4OtpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCBB4OtpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCBB4OtpError::En_OverRide_BDCDCBB4OtpError','editSampleTime','0.001','Position', [20 545 70 575]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCBB4OtpError/1', 'En_OverRide_BDCDCBB4OtpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion9']);
CovertPortHandles = get_param( [gcs '/SignalConvertion9'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(9), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCBB4OtpError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCBB4OtpError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCBB4OtpError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '9');
En_OverRide_BDCDCBB4OtpErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCBB4OtpError/1','x392_NDCDCStatus_1/9','autorouting','on');
set_param(En_OverRide_BDCDCBB4OtpErrorHandle, 'Name', 'En_OverRide_BDCDCBB4OtpError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCBB4OtpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCBB4OtpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCBB4OtpError::Val_OverRide_BDCDCBB4OtpError','editSampleTime','0.001','Position', [20 605 70 635]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCBB4OtpError/1', 'Val_OverRide_BDCDCBB4OtpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion10']);
CovertPortHandles = get_param( [gcs '/SignalConvertion10'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(10), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '10');
lineHandle = add_line(gcs,'SignalConvertion10/1','x392_NDCDCStatus_1/10','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCBB4OtpError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCCANError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCCANError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCCANError::En_OverRide_BDCDCCANError','editSampleTime','0.001','Position', [20 665 70 695]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCCANError/1', 'En_OverRide_BDCDCCANError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion11']);
CovertPortHandles = get_param( [gcs '/SignalConvertion11'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(11), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCCANError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCCANError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCCANError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '11');
En_OverRide_BDCDCCANErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCCANError/1','x392_NDCDCStatus_1/11','autorouting','on');
set_param(En_OverRide_BDCDCCANErrorHandle, 'Name', 'En_OverRide_BDCDCCANError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCCANError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCCANError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCCANError::Val_OverRide_BDCDCCANError','editSampleTime','0.001','Position', [20 725 70 755]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCCANError/1', 'Val_OverRide_BDCDCCANError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion12']);
CovertPortHandles = get_param( [gcs '/SignalConvertion12'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(12), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '12');
lineHandle = add_line(gcs,'SignalConvertion12/1','x392_NDCDCStatus_1/12','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCCANError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCHVError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCHVError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCHVError::En_OverRide_BDCDCHVError','editSampleTime','0.001','Position', [20 785 70 815]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCHVError/1', 'En_OverRide_BDCDCHVError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion13']);
CovertPortHandles = get_param( [gcs '/SignalConvertion13'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(13), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCHVError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCHVError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCHVError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '13');
En_OverRide_BDCDCHVErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCHVError/1','x392_NDCDCStatus_1/13','autorouting','on');
set_param(En_OverRide_BDCDCHVErrorHandle, 'Name', 'En_OverRide_BDCDCHVError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCHVError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCHVError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCHVError::Val_OverRide_BDCDCHVError','editSampleTime','0.001','Position', [20 845 70 875]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCHVError/1', 'Val_OverRide_BDCDCHVError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion14']);
CovertPortHandles = get_param( [gcs '/SignalConvertion14'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(14), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '14');
lineHandle = add_line(gcs,'SignalConvertion14/1','x392_NDCDCStatus_1/14','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCHVError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCHVOcpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCHVOcpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCHVOcpError::En_OverRide_BDCDCHVOcpError','editSampleTime','0.001','Position', [20 905 70 935]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCHVOcpError/1', 'En_OverRide_BDCDCHVOcpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion15']);
CovertPortHandles = get_param( [gcs '/SignalConvertion15'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(15), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCHVOcpError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCHVOcpError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCHVOcpError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '15');
En_OverRide_BDCDCHVOcpErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCHVOcpError/1','x392_NDCDCStatus_1/15','autorouting','on');
set_param(En_OverRide_BDCDCHVOcpErrorHandle, 'Name', 'En_OverRide_BDCDCHVOcpError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCHVOcpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCHVOcpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCHVOcpError::Val_OverRide_BDCDCHVOcpError','editSampleTime','0.001','Position', [20 965 70 995]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCHVOcpError/1', 'Val_OverRide_BDCDCHVOcpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion16']);
CovertPortHandles = get_param( [gcs '/SignalConvertion16'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(16), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '16');
lineHandle = add_line(gcs,'SignalConvertion16/1','x392_NDCDCStatus_1/16','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCHVOcpError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCLVOvpInError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCLVOvpInError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCLVOvpInError::En_OverRide_BDCDCLVOvpInError','editSampleTime','0.001','Position', [20 1025 70 1055]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCLVOvpInError/1', 'En_OverRide_BDCDCLVOvpInError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion17']);
CovertPortHandles = get_param( [gcs '/SignalConvertion17'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(17), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCLVOvpInError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCLVOvpInError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCLVOvpInError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '17');
En_OverRide_BDCDCLVOvpInErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCLVOvpInError/1','x392_NDCDCStatus_1/17','autorouting','on');
set_param(En_OverRide_BDCDCLVOvpInErrorHandle, 'Name', 'En_OverRide_BDCDCLVOvpInError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCLVOvpInError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCLVOvpInError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCLVOvpInError::Val_OverRide_BDCDCLVOvpInError','editSampleTime','0.001','Position', [20 1085 70 1115]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCLVOvpInError/1', 'Val_OverRide_BDCDCLVOvpInError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion18']);
CovertPortHandles = get_param( [gcs '/SignalConvertion18'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(18), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '18');
lineHandle = add_line(gcs,'SignalConvertion18/1','x392_NDCDCStatus_1/18','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCLVOvpInError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCLVUvpAlimAuxError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCLVUvpAlimAuxError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCLVUvpAlimAuxError::En_OverRide_BDCDCLVUvpAlimAuxError','editSampleTime','0.001','Position', [20 1145 70 1175]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCLVUvpAlimAuxError/1', 'En_OverRide_BDCDCLVUvpAlimAuxError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion19']);
CovertPortHandles = get_param( [gcs '/SignalConvertion19'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(19), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCLVUvpAlimAuxError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCLVUvpAlimAuxError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCLVUvpAlimAuxError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '19');
En_OverRide_BDCDCLVUvpAlimAuxErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCLVUvpAlimAuxError/1','x392_NDCDCStatus_1/19','autorouting','on');
set_param(En_OverRide_BDCDCLVUvpAlimAuxErrorHandle, 'Name', 'En_OverRide_BDCDCLVUvpAlimAuxError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCLVUvpAlimAuxError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCLVUvpAlimAuxError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCLVUvpAlimAuxError::Val_OverRide_BDCDCLVUvpAlimAuxError','editSampleTime','0.001','Position', [20 1205 70 1235]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCLVUvpAlimAuxError/1', 'Val_OverRide_BDCDCLVUvpAlimAuxError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion20']);
CovertPortHandles = get_param( [gcs '/SignalConvertion20'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(20), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '20');
lineHandle = add_line(gcs,'SignalConvertion20/1','x392_NDCDCStatus_1/20','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCLVUvpAlimAuxError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCLVUvpInError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCLVUvpInError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCLVUvpInError::En_OverRide_BDCDCLVUvpInError','editSampleTime','0.001','Position', [20 1265 70 1295]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCLVUvpInError/1', 'En_OverRide_BDCDCLVUvpInError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion21']);
CovertPortHandles = get_param( [gcs '/SignalConvertion21'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(21), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCLVUvpInError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCLVUvpInError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCLVUvpInError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '21');
En_OverRide_BDCDCLVUvpInErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCLVUvpInError/1','x392_NDCDCStatus_1/21','autorouting','on');
set_param(En_OverRide_BDCDCLVUvpInErrorHandle, 'Name', 'En_OverRide_BDCDCLVUvpInError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCLVUvpInError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCLVUvpInError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCLVUvpInError::Val_OverRide_BDCDCLVUvpInError','editSampleTime','0.001','Position', [20 1325 70 1355]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCLVUvpInError/1', 'Val_OverRide_BDCDCLVUvpInError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion22']);
CovertPortHandles = get_param( [gcs '/SignalConvertion22'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(22), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '22');
lineHandle = add_line(gcs,'SignalConvertion22/1','x392_NDCDCStatus_1/22','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCLVUvpInError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCOutput1Demanded_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCOutput1Demanded'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCOutput1Demanded::En_OverRide_BDCDCOutput1Demanded','editSampleTime','0.001','Position', [20 1385 70 1415]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCOutput1Demanded/1', 'En_OverRide_BDCDCOutput1Demanded_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion23']);
CovertPortHandles = get_param( [gcs '/SignalConvertion23'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(23), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCOutput1Demanded']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCOutput1Demanded'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCOutput1Demanded/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '23');
En_OverRide_BDCDCOutput1DemandedHandle = add_line(gcs,'AND_En_OverRide_BDCDCOutput1Demanded/1','x392_NDCDCStatus_1/23','autorouting','on');
set_param(En_OverRide_BDCDCOutput1DemandedHandle, 'Name', 'En_OverRide_BDCDCOutput1Demanded');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCOutput1Demanded_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCOutput1Demanded'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCOutput1Demanded::Val_OverRide_BDCDCOutput1Demanded','editSampleTime','0.001','Position', [20 1445 70 1475]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCOutput1Demanded/1', 'Val_OverRide_BDCDCOutput1Demanded_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion24']);
CovertPortHandles = get_param( [gcs '/SignalConvertion24'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(24), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '24');
lineHandle = add_line(gcs,'SignalConvertion24/1','x392_NDCDCStatus_1/24','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCOutput1Demanded');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCOutput1OvpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCOutput1OvpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCOutput1OvpError::En_OverRide_BDCDCOutput1OvpError','editSampleTime','0.001','Position', [20 1505 70 1535]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCOutput1OvpError/1', 'En_OverRide_BDCDCOutput1OvpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion25']);
CovertPortHandles = get_param( [gcs '/SignalConvertion25'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(25), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCOutput1OvpError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCOutput1OvpError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCOutput1OvpError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '25');
En_OverRide_BDCDCOutput1OvpErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCOutput1OvpError/1','x392_NDCDCStatus_1/25','autorouting','on');
set_param(En_OverRide_BDCDCOutput1OvpErrorHandle, 'Name', 'En_OverRide_BDCDCOutput1OvpError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCOutput1OvpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCOutput1OvpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCOutput1OvpError::Val_OverRide_BDCDCOutput1OvpError','editSampleTime','0.001','Position', [20 1565 70 1595]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCOutput1OvpError/1', 'Val_OverRide_BDCDCOutput1OvpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion26']);
CovertPortHandles = get_param( [gcs '/SignalConvertion26'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(26), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '26');
lineHandle = add_line(gcs,'SignalConvertion26/1','x392_NDCDCStatus_1/26','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCOutput1OvpError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCOutput1Warning_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCOutput1Warning'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCOutput1Warning::En_OverRide_BDCDCOutput1Warning','editSampleTime','0.001','Position', [20 1625 70 1655]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCOutput1Warning/1', 'En_OverRide_BDCDCOutput1Warning_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion27']);
CovertPortHandles = get_param( [gcs '/SignalConvertion27'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(27), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCOutput1Warning']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCOutput1Warning'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCOutput1Warning/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '27');
En_OverRide_BDCDCOutput1WarningHandle = add_line(gcs,'AND_En_OverRide_BDCDCOutput1Warning/1','x392_NDCDCStatus_1/27','autorouting','on');
set_param(En_OverRide_BDCDCOutput1WarningHandle, 'Name', 'En_OverRide_BDCDCOutput1Warning');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCOutput1Warning_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCOutput1Warning'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCOutput1Warning::Val_OverRide_BDCDCOutput1Warning','editSampleTime','0.001','Position', [20 1685 70 1715]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCOutput1Warning/1', 'Val_OverRide_BDCDCOutput1Warning_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion28']);
CovertPortHandles = get_param( [gcs '/SignalConvertion28'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(28), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '28');
lineHandle = add_line(gcs,'SignalConvertion28/1','x392_NDCDCStatus_1/28','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCOutput1Warning');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCOutput2Demanded_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCOutput2Demanded'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCOutput2Demanded::En_OverRide_BDCDCOutput2Demanded','editSampleTime','0.001','Position', [20 1745 70 1775]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCOutput2Demanded/1', 'En_OverRide_BDCDCOutput2Demanded_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion29']);
CovertPortHandles = get_param( [gcs '/SignalConvertion29'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(29), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCOutput2Demanded']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCOutput2Demanded'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCOutput2Demanded/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '29');
En_OverRide_BDCDCOutput2DemandedHandle = add_line(gcs,'AND_En_OverRide_BDCDCOutput2Demanded/1','x392_NDCDCStatus_1/29','autorouting','on');
set_param(En_OverRide_BDCDCOutput2DemandedHandle, 'Name', 'En_OverRide_BDCDCOutput2Demanded');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCOutput2Demanded_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCOutput2Demanded'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCOutput2Demanded::Val_OverRide_BDCDCOutput2Demanded','editSampleTime','0.001','Position', [20 1805 70 1835]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCOutput2Demanded/1', 'Val_OverRide_BDCDCOutput2Demanded_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion30']);
CovertPortHandles = get_param( [gcs '/SignalConvertion30'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(30), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '30');
lineHandle = add_line(gcs,'SignalConvertion30/1','x392_NDCDCStatus_1/30','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCOutput2Demanded');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCOutput2OvpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCOutput2OvpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCOutput2OvpError::En_OverRide_BDCDCOutput2OvpError','editSampleTime','0.001','Position', [20 1865 70 1895]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCOutput2OvpError/1', 'En_OverRide_BDCDCOutput2OvpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion31']);
CovertPortHandles = get_param( [gcs '/SignalConvertion31'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(31), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCOutput2OvpError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCOutput2OvpError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCOutput2OvpError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '31');
En_OverRide_BDCDCOutput2OvpErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCOutput2OvpError/1','x392_NDCDCStatus_1/31','autorouting','on');
set_param(En_OverRide_BDCDCOutput2OvpErrorHandle, 'Name', 'En_OverRide_BDCDCOutput2OvpError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCOutput2OvpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCOutput2OvpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCOutput2OvpError::Val_OverRide_BDCDCOutput2OvpError','editSampleTime','0.001','Position', [20 1925 70 1955]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCOutput2OvpError/1', 'Val_OverRide_BDCDCOutput2OvpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion32']);
CovertPortHandles = get_param( [gcs '/SignalConvertion32'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(32), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '32');
lineHandle = add_line(gcs,'SignalConvertion32/1','x392_NDCDCStatus_1/32','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCOutput2OvpError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCOutput2Warning_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCOutput2Warning'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCOutput2Warning::En_OverRide_BDCDCOutput2Warning','editSampleTime','0.001','Position', [20 1985 70 2015]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCOutput2Warning/1', 'En_OverRide_BDCDCOutput2Warning_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion33']);
CovertPortHandles = get_param( [gcs '/SignalConvertion33'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(33), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCOutput2Warning']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCOutput2Warning'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCOutput2Warning/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '33');
En_OverRide_BDCDCOutput2WarningHandle = add_line(gcs,'AND_En_OverRide_BDCDCOutput2Warning/1','x392_NDCDCStatus_1/33','autorouting','on');
set_param(En_OverRide_BDCDCOutput2WarningHandle, 'Name', 'En_OverRide_BDCDCOutput2Warning');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCOutput2Warning_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCOutput2Warning'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCOutput2Warning::Val_OverRide_BDCDCOutput2Warning','editSampleTime','0.001','Position', [20 2045 70 2075]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCOutput2Warning/1', 'Val_OverRide_BDCDCOutput2Warning_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion34']);
CovertPortHandles = get_param( [gcs '/SignalConvertion34'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(34), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '34');
lineHandle = add_line(gcs,'SignalConvertion34/1','x392_NDCDCStatus_1/34','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCOutput2Warning');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCRegenerationDemanded_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCRegenerationDemanded'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCRegenerationDemanded::En_OverRide_BDCDCRegenerationDemanded','editSampleTime','0.001','Position', [20 2105 70 2135]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCRegenerationDemanded/1', 'En_OverRide_BDCDCRegenerationDemanded_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion35']);
CovertPortHandles = get_param( [gcs '/SignalConvertion35'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(35), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCRegenerationDemanded']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCRegenerationDemanded'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCRegenerationDemanded/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '35');
En_OverRide_BDCDCRegenerationDemandedHandle = add_line(gcs,'AND_En_OverRide_BDCDCRegenerationDemanded/1','x392_NDCDCStatus_1/35','autorouting','on');
set_param(En_OverRide_BDCDCRegenerationDemandedHandle, 'Name', 'En_OverRide_BDCDCRegenerationDemanded');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCRegenerationDemanded_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCRegenerationDemanded'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCRegenerationDemanded::Val_OverRide_BDCDCRegenerationDemanded','editSampleTime','0.001','Position', [20 2165 70 2195]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCRegenerationDemanded/1', 'Val_OverRide_BDCDCRegenerationDemanded_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion36']);
CovertPortHandles = get_param( [gcs '/SignalConvertion36'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(36), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '36');
lineHandle = add_line(gcs,'SignalConvertion36/1','x392_NDCDCStatus_1/36','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCRegenerationDemanded');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCSR1OtpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCSR1OtpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCSR1OtpError::En_OverRide_BDCDCSR1OtpError','editSampleTime','0.001','Position', [20 2225 70 2255]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCSR1OtpError/1', 'En_OverRide_BDCDCSR1OtpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion37']);
CovertPortHandles = get_param( [gcs '/SignalConvertion37'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(37), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCSR1OtpError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCSR1OtpError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCSR1OtpError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '37');
En_OverRide_BDCDCSR1OtpErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCSR1OtpError/1','x392_NDCDCStatus_1/37','autorouting','on');
set_param(En_OverRide_BDCDCSR1OtpErrorHandle, 'Name', 'En_OverRide_BDCDCSR1OtpError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCSR1OtpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCSR1OtpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCSR1OtpError::Val_OverRide_BDCDCSR1OtpError','editSampleTime','0.001','Position', [20 2285 70 2315]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCSR1OtpError/1', 'Val_OverRide_BDCDCSR1OtpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion38']);
CovertPortHandles = get_param( [gcs '/SignalConvertion38'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(38), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '38');
lineHandle = add_line(gcs,'SignalConvertion38/1','x392_NDCDCStatus_1/38','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCSR1OtpError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCSR2OtpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCSR2OtpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCSR2OtpError::En_OverRide_BDCDCSR2OtpError','editSampleTime','0.001','Position', [20 2345 70 2375]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCSR2OtpError/1', 'En_OverRide_BDCDCSR2OtpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion39']);
CovertPortHandles = get_param( [gcs '/SignalConvertion39'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(39), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCSR2OtpError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCSR2OtpError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCSR2OtpError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '39');
En_OverRide_BDCDCSR2OtpErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCSR2OtpError/1','x392_NDCDCStatus_1/39','autorouting','on');
set_param(En_OverRide_BDCDCSR2OtpErrorHandle, 'Name', 'En_OverRide_BDCDCSR2OtpError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCSR2OtpError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCSR2OtpError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCSR2OtpError::Val_OverRide_BDCDCSR2OtpError','editSampleTime','0.001','Position', [20 2405 70 2435]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCSR2OtpError/1', 'Val_OverRide_BDCDCSR2OtpError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion40']);
CovertPortHandles = get_param( [gcs '/SignalConvertion40'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(40), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '40');
lineHandle = add_line(gcs,'SignalConvertion40/1','x392_NDCDCStatus_1/40','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCSR2OtpError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCUmbilicalDemanded_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCUmbilicalDemanded'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCUmbilicalDemanded::En_OverRide_BDCDCUmbilicalDemanded','editSampleTime','0.001','Position', [20 2465 70 2495]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCUmbilicalDemanded/1', 'En_OverRide_BDCDCUmbilicalDemanded_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion41']);
CovertPortHandles = get_param( [gcs '/SignalConvertion41'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(41), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCUmbilicalDemanded']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCUmbilicalDemanded'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCUmbilicalDemanded/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '41');
En_OverRide_BDCDCUmbilicalDemandedHandle = add_line(gcs,'AND_En_OverRide_BDCDCUmbilicalDemanded/1','x392_NDCDCStatus_1/41','autorouting','on');
set_param(En_OverRide_BDCDCUmbilicalDemandedHandle, 'Name', 'En_OverRide_BDCDCUmbilicalDemanded');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCUmbilicalDemanded_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCUmbilicalDemanded'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCUmbilicalDemanded::Val_OverRide_BDCDCUmbilicalDemanded','editSampleTime','0.001','Position', [20 2525 70 2555]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCUmbilicalDemanded/1', 'Val_OverRide_BDCDCUmbilicalDemanded_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion42']);
CovertPortHandles = get_param( [gcs '/SignalConvertion42'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(42), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '42');
lineHandle = add_line(gcs,'SignalConvertion42/1','x392_NDCDCStatus_1/42','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCUmbilicalDemanded');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCWakeUp_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCWakeUp'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCWakeUp::En_OverRide_BDCDCWakeUp','editSampleTime','0.001','Position', [20 2585 70 2615]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCWakeUp/1', 'En_OverRide_BDCDCWakeUp_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion43']);
CovertPortHandles = get_param( [gcs '/SignalConvertion43'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(43), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCWakeUp']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCWakeUp'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCWakeUp/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '43');
En_OverRide_BDCDCWakeUpHandle = add_line(gcs,'AND_En_OverRide_BDCDCWakeUp/1','x392_NDCDCStatus_1/43','autorouting','on');
set_param(En_OverRide_BDCDCWakeUpHandle, 'Name', 'En_OverRide_BDCDCWakeUp');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCWakeUp_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCWakeUp'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::BDCDCWakeUp::Val_OverRide_BDCDCWakeUp','editSampleTime','0.001','Position', [20 2645 70 2675]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCWakeUp/1', 'Val_OverRide_BDCDCWakeUp_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion44']);
CovertPortHandles = get_param( [gcs '/SignalConvertion44'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(44), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '44');
lineHandle = add_line(gcs,'SignalConvertion44/1','x392_NDCDCStatus_1/44','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCWakeUp');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_NDCDCState_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_NDCDCState'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::NDCDCState::En_OverRide_NDCDCState','editSampleTime','0.001','Position', [20 2705 70 2735]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_NDCDCState/1', 'En_OverRide_NDCDCState_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion45']);
CovertPortHandles = get_param( [gcs '/SignalConvertion45'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(45), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_NDCDCState']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_NDCDCState'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_NDCDCState/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '45');
En_OverRide_NDCDCStateHandle = add_line(gcs,'AND_En_OverRide_NDCDCState/1','x392_NDCDCStatus_1/45','autorouting','on');
set_param(En_OverRide_NDCDCStateHandle, 'Name', 'En_OverRide_NDCDCState');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_NDCDCState_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_NDCDCState'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x392_NDCDCStatus::NDCDCState::Val_OverRide_NDCDCState','editSampleTime','0.001','Position', [20 2765 70 2795]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_NDCDCState/1', 'Val_OverRide_NDCDCState_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion46']);
CovertPortHandles = get_param( [gcs '/SignalConvertion46'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(46), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x392_NDCDCStatus_1'], 'Inputs', '46');
lineHandle = add_line(gcs,'SignalConvertion46/1','x392_NDCDCStatus_1/46','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_NDCDCState');



set_param([gcs,'/DCDC'], 'Inputs', '1')
lineHandle = add_line(gcs,'x392_NDCDCStatus_1/1','DCDC/1','autorouting','on')
set_param(lineHandle, 'Name', 'x392_NDCDCStatus');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/x393_NDCDCValue_2']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCLVInAverage_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCLVInAverage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCLVInAverage::En_OverRide_VDCDCLVInAverage','editSampleTime','0.001','Position', [20 2825 70 2855]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCLVInAverage/1', 'En_OverRide_VDCDCLVInAverage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion47']);
CovertPortHandles = get_param( [gcs '/SignalConvertion47'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(47), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCLVInAverage']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCLVInAverage'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCLVInAverage/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '1');
En_OverRide_VDCDCLVInAverageHandle = add_line(gcs,'AND_En_OverRide_VDCDCLVInAverage/1','x393_NDCDCValue_2/1','autorouting','on');
set_param(En_OverRide_VDCDCLVInAverageHandle, 'Name', 'En_OverRide_VDCDCLVInAverage');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCLVInAverage_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCLVInAverage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCLVInAverage::Val_OverRide_VDCDCLVInAverage','editSampleTime','0.001','Position', [20 2885 70 2915]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCLVInAverage/1', 'Val_OverRide_VDCDCLVInAverage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion48']);
CovertPortHandles = get_param( [gcs '/SignalConvertion48'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(48), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion48/1','x393_NDCDCValue_2/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCLVInAverage');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCLVInMax_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCLVInMax'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCLVInMax::En_OverRide_VDCDCLVInMax','editSampleTime','0.001','Position', [20 2945 70 2975]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCLVInMax/1', 'En_OverRide_VDCDCLVInMax_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion49']);
CovertPortHandles = get_param( [gcs '/SignalConvertion49'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(49), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCLVInMax']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCLVInMax'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCLVInMax/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '3');
En_OverRide_VDCDCLVInMaxHandle = add_line(gcs,'AND_En_OverRide_VDCDCLVInMax/1','x393_NDCDCValue_2/3','autorouting','on');
set_param(En_OverRide_VDCDCLVInMaxHandle, 'Name', 'En_OverRide_VDCDCLVInMax');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCLVInMax_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCLVInMax'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCLVInMax::Val_OverRide_VDCDCLVInMax','editSampleTime','0.001','Position', [20 3005 70 3035]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCLVInMax/1', 'Val_OverRide_VDCDCLVInMax_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion50']);
CovertPortHandles = get_param( [gcs '/SignalConvertion50'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(50), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion50/1','x393_NDCDCValue_2/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCLVInMax');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCLVInMin_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCLVInMin'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCLVInMin::En_OverRide_VDCDCLVInMin','editSampleTime','0.001','Position', [20 3065 70 3095]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCLVInMin/1', 'En_OverRide_VDCDCLVInMin_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion51']);
CovertPortHandles = get_param( [gcs '/SignalConvertion51'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(51), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCLVInMin']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCLVInMin'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCLVInMin/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '5');
En_OverRide_VDCDCLVInMinHandle = add_line(gcs,'AND_En_OverRide_VDCDCLVInMin/1','x393_NDCDCValue_2/5','autorouting','on');
set_param(En_OverRide_VDCDCLVInMinHandle, 'Name', 'En_OverRide_VDCDCLVInMin');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCLVInMin_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCLVInMin'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCLVInMin::Val_OverRide_VDCDCLVInMin','editSampleTime','0.001','Position', [20 3125 70 3155]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCLVInMin/1', 'Val_OverRide_VDCDCLVInMin_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion52']);
CovertPortHandles = get_param( [gcs '/SignalConvertion52'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(52), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion52/1','x393_NDCDCValue_2/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCLVInMin');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_BDCDCFlashSubzoneError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_BDCDCFlashSubzoneError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::BDCDCFlashSubzoneError::En_OverRide_BDCDCFlashSubzoneError','editSampleTime','0.001','Position', [20 3185 70 3215]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_BDCDCFlashSubzoneError/1', 'En_OverRide_BDCDCFlashSubzoneError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion53']);
CovertPortHandles = get_param( [gcs '/SignalConvertion53'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(53), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BDCDCFlashSubzoneError']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BDCDCFlashSubzoneError'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BDCDCFlashSubzoneError/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '7');
En_OverRide_BDCDCFlashSubzoneErrorHandle = add_line(gcs,'AND_En_OverRide_BDCDCFlashSubzoneError/1','x393_NDCDCValue_2/7','autorouting','on');
set_param(En_OverRide_BDCDCFlashSubzoneErrorHandle, 'Name', 'En_OverRide_BDCDCFlashSubzoneError');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_BDCDCFlashSubzoneError_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_BDCDCFlashSubzoneError'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::BDCDCFlashSubzoneError::Val_OverRide_BDCDCFlashSubzoneError','editSampleTime','0.001','Position', [20 3245 70 3275]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_BDCDCFlashSubzoneError/1', 'Val_OverRide_BDCDCFlashSubzoneError_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion54']);
CovertPortHandles = get_param( [gcs '/SignalConvertion54'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(54), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion54/1','x393_NDCDCValue_2/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BDCDCFlashSubzoneError');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_IDCDCHVInAverage_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_IDCDCHVInAverage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::IDCDCHVInAverage::En_OverRide_IDCDCHVInAverage','editSampleTime','0.001','Position', [20 3305 70 3335]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_IDCDCHVInAverage/1', 'En_OverRide_IDCDCHVInAverage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion55']);
CovertPortHandles = get_param( [gcs '/SignalConvertion55'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(55), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_IDCDCHVInAverage']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_IDCDCHVInAverage'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_IDCDCHVInAverage/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '9');
En_OverRide_IDCDCHVInAverageHandle = add_line(gcs,'AND_En_OverRide_IDCDCHVInAverage/1','x393_NDCDCValue_2/9','autorouting','on');
set_param(En_OverRide_IDCDCHVInAverageHandle, 'Name', 'En_OverRide_IDCDCHVInAverage');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_IDCDCHVInAverage_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_IDCDCHVInAverage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::IDCDCHVInAverage::Val_OverRide_IDCDCHVInAverage','editSampleTime','0.001','Position', [20 3365 70 3395]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_IDCDCHVInAverage/1', 'Val_OverRide_IDCDCHVInAverage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion56']);
CovertPortHandles = get_param( [gcs '/SignalConvertion56'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(56), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '10');
lineHandle = add_line(gcs,'SignalConvertion56/1','x393_NDCDCValue_2/10','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_IDCDCHVInAverage');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_IDCDCOutput1UnBalance_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_IDCDCOutput1UnBalance'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::IDCDCOutput1UnBalance::En_OverRide_IDCDCOutput1UnBalance','editSampleTime','0.001','Position', [20 3425 70 3455]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_IDCDCOutput1UnBalance/1', 'En_OverRide_IDCDCOutput1UnBalance_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion57']);
CovertPortHandles = get_param( [gcs '/SignalConvertion57'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(57), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_IDCDCOutput1UnBalance']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_IDCDCOutput1UnBalance'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_IDCDCOutput1UnBalance/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '11');
En_OverRide_IDCDCOutput1UnBalanceHandle = add_line(gcs,'AND_En_OverRide_IDCDCOutput1UnBalance/1','x393_NDCDCValue_2/11','autorouting','on');
set_param(En_OverRide_IDCDCOutput1UnBalanceHandle, 'Name', 'En_OverRide_IDCDCOutput1UnBalance');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_IDCDCOutput1UnBalance_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_IDCDCOutput1UnBalance'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::IDCDCOutput1UnBalance::Val_OverRide_IDCDCOutput1UnBalance','editSampleTime','0.001','Position', [20 3485 70 3515]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_IDCDCOutput1UnBalance/1', 'Val_OverRide_IDCDCOutput1UnBalance_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion58']);
CovertPortHandles = get_param( [gcs '/SignalConvertion58'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(58), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '12');
lineHandle = add_line(gcs,'SignalConvertion58/1','x393_NDCDCValue_2/12','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_IDCDCOutput1UnBalance');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_IDCDCOutput2UnBalance_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_IDCDCOutput2UnBalance'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::IDCDCOutput2UnBalance::En_OverRide_IDCDCOutput2UnBalance','editSampleTime','0.001','Position', [20 3545 70 3575]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_IDCDCOutput2UnBalance/1', 'En_OverRide_IDCDCOutput2UnBalance_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion59']);
CovertPortHandles = get_param( [gcs '/SignalConvertion59'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(59), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_IDCDCOutput2UnBalance']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_IDCDCOutput2UnBalance'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_IDCDCOutput2UnBalance/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '13');
En_OverRide_IDCDCOutput2UnBalanceHandle = add_line(gcs,'AND_En_OverRide_IDCDCOutput2UnBalance/1','x393_NDCDCValue_2/13','autorouting','on');
set_param(En_OverRide_IDCDCOutput2UnBalanceHandle, 'Name', 'En_OverRide_IDCDCOutput2UnBalance');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_IDCDCOutput2UnBalance_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_IDCDCOutput2UnBalance'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::IDCDCOutput2UnBalance::Val_OverRide_IDCDCOutput2UnBalance','editSampleTime','0.001','Position', [20 3605 70 3635]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_IDCDCOutput2UnBalance/1', 'Val_OverRide_IDCDCOutput2UnBalance_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion60']);
CovertPortHandles = get_param( [gcs '/SignalConvertion60'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(60), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '14');
lineHandle = add_line(gcs,'SignalConvertion60/1','x393_NDCDCValue_2/14','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_IDCDCOutput2UnBalance');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_NDCDCApplicationId_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_NDCDCApplicationId'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCApplicationId::En_OverRide_NDCDCApplicationId','editSampleTime','0.001','Position', [20 3665 70 3695]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_NDCDCApplicationId/1', 'En_OverRide_NDCDCApplicationId_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion61']);
CovertPortHandles = get_param( [gcs '/SignalConvertion61'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(61), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_NDCDCApplicationId']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_NDCDCApplicationId'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_NDCDCApplicationId/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '15');
En_OverRide_NDCDCApplicationIdHandle = add_line(gcs,'AND_En_OverRide_NDCDCApplicationId/1','x393_NDCDCValue_2/15','autorouting','on');
set_param(En_OverRide_NDCDCApplicationIdHandle, 'Name', 'En_OverRide_NDCDCApplicationId');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_NDCDCApplicationId_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_NDCDCApplicationId'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCApplicationId::Val_OverRide_NDCDCApplicationId','editSampleTime','0.001','Position', [20 3725 70 3755]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_NDCDCApplicationId/1', 'Val_OverRide_NDCDCApplicationId_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion62']);
CovertPortHandles = get_param( [gcs '/SignalConvertion62'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(62), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '16');
lineHandle = add_line(gcs,'SignalConvertion62/1','x393_NDCDCValue_2/16','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_NDCDCApplicationId');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_NDCDCBootloaderId_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_NDCDCBootloaderId'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCBootloaderId::En_OverRide_NDCDCBootloaderId','editSampleTime','0.001','Position', [20 3785 70 3815]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_NDCDCBootloaderId/1', 'En_OverRide_NDCDCBootloaderId_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion63']);
CovertPortHandles = get_param( [gcs '/SignalConvertion63'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(63), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_NDCDCBootloaderId']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_NDCDCBootloaderId'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_NDCDCBootloaderId/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '17');
En_OverRide_NDCDCBootloaderIdHandle = add_line(gcs,'AND_En_OverRide_NDCDCBootloaderId/1','x393_NDCDCValue_2/17','autorouting','on');
set_param(En_OverRide_NDCDCBootloaderIdHandle, 'Name', 'En_OverRide_NDCDCBootloaderId');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_NDCDCBootloaderId_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_NDCDCBootloaderId'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCBootloaderId::Val_OverRide_NDCDCBootloaderId','editSampleTime','0.001','Position', [20 3845 70 3875]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_NDCDCBootloaderId/1', 'Val_OverRide_NDCDCBootloaderId_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion64']);
CovertPortHandles = get_param( [gcs '/SignalConvertion64'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(64), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '18');
lineHandle = add_line(gcs,'SignalConvertion64/1','x393_NDCDCValue_2/18','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_NDCDCBootloaderId');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_NDCDCChecksum_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_NDCDCChecksum'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCChecksum::En_OverRide_NDCDCChecksum','editSampleTime','0.001','Position', [20 3905 70 3935]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_NDCDCChecksum/1', 'En_OverRide_NDCDCChecksum_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion65']);
CovertPortHandles = get_param( [gcs '/SignalConvertion65'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(65), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_NDCDCChecksum']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_NDCDCChecksum'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_NDCDCChecksum/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '19');
En_OverRide_NDCDCChecksumHandle = add_line(gcs,'AND_En_OverRide_NDCDCChecksum/1','x393_NDCDCValue_2/19','autorouting','on');
set_param(En_OverRide_NDCDCChecksumHandle, 'Name', 'En_OverRide_NDCDCChecksum');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_NDCDCChecksum_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_NDCDCChecksum'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCChecksum::Val_OverRide_NDCDCChecksum','editSampleTime','0.001','Position', [20 3965 70 3995]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_NDCDCChecksum/1', 'Val_OverRide_NDCDCChecksum_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion66']);
CovertPortHandles = get_param( [gcs '/SignalConvertion66'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(66), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '20');
lineHandle = add_line(gcs,'SignalConvertion66/1','x393_NDCDCValue_2/20','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_NDCDCChecksum');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_NDCDCOutputOverload1Count_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_NDCDCOutputOverload1Count'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCOutputOverload1Count::En_OverRide_NDCDCOutputOverload1Count','editSampleTime','0.001','Position', [20 4025 70 4055]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_NDCDCOutputOverload1Count/1', 'En_OverRide_NDCDCOutputOverload1Count_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion67']);
CovertPortHandles = get_param( [gcs '/SignalConvertion67'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(67), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_NDCDCOutputOverload1Count']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_NDCDCOutputOverload1Count'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_NDCDCOutputOverload1Count/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '21');
En_OverRide_NDCDCOutputOverload1CountHandle = add_line(gcs,'AND_En_OverRide_NDCDCOutputOverload1Count/1','x393_NDCDCValue_2/21','autorouting','on');
set_param(En_OverRide_NDCDCOutputOverload1CountHandle, 'Name', 'En_OverRide_NDCDCOutputOverload1Count');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_NDCDCOutputOverload1Count_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_NDCDCOutputOverload1Count'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCOutputOverload1Count::Val_OverRide_NDCDCOutputOverload1Count','editSampleTime','0.001','Position', [20 4085 70 4115]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_NDCDCOutputOverload1Count/1', 'Val_OverRide_NDCDCOutputOverload1Count_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion68']);
CovertPortHandles = get_param( [gcs '/SignalConvertion68'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(68), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '22');
lineHandle = add_line(gcs,'SignalConvertion68/1','x393_NDCDCValue_2/22','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_NDCDCOutputOverload1Count');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_NDCDCOutputOverload2Count_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_NDCDCOutputOverload2Count'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCOutputOverload2Count::En_OverRide_NDCDCOutputOverload2Count','editSampleTime','0.001','Position', [20 4145 70 4175]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_NDCDCOutputOverload2Count/1', 'En_OverRide_NDCDCOutputOverload2Count_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion69']);
CovertPortHandles = get_param( [gcs '/SignalConvertion69'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(69), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_NDCDCOutputOverload2Count']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_NDCDCOutputOverload2Count'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_NDCDCOutputOverload2Count/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '23');
En_OverRide_NDCDCOutputOverload2CountHandle = add_line(gcs,'AND_En_OverRide_NDCDCOutputOverload2Count/1','x393_NDCDCValue_2/23','autorouting','on');
set_param(En_OverRide_NDCDCOutputOverload2CountHandle, 'Name', 'En_OverRide_NDCDCOutputOverload2Count');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_NDCDCOutputOverload2Count_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_NDCDCOutputOverload2Count'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCOutputOverload2Count::Val_OverRide_NDCDCOutputOverload2Count','editSampleTime','0.001','Position', [20 4205 70 4235]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_NDCDCOutputOverload2Count/1', 'Val_OverRide_NDCDCOutputOverload2Count_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion70']);
CovertPortHandles = get_param( [gcs '/SignalConvertion70'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(70), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '24');
lineHandle = add_line(gcs,'SignalConvertion70/1','x393_NDCDCValue_2/24','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_NDCDCOutputOverload2Count');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_NDCDCRcpWarning_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_NDCDCRcpWarning'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCRcpWarning::En_OverRide_NDCDCRcpWarning','editSampleTime','0.001','Position', [20 4265 70 4295]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_NDCDCRcpWarning/1', 'En_OverRide_NDCDCRcpWarning_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion71']);
CovertPortHandles = get_param( [gcs '/SignalConvertion71'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(71), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_NDCDCRcpWarning']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_NDCDCRcpWarning'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_NDCDCRcpWarning/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '25');
En_OverRide_NDCDCRcpWarningHandle = add_line(gcs,'AND_En_OverRide_NDCDCRcpWarning/1','x393_NDCDCValue_2/25','autorouting','on');
set_param(En_OverRide_NDCDCRcpWarningHandle, 'Name', 'En_OverRide_NDCDCRcpWarning');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_NDCDCRcpWarning_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_NDCDCRcpWarning'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCRcpWarning::Val_OverRide_NDCDCRcpWarning','editSampleTime','0.001','Position', [20 4325 70 4355]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_NDCDCRcpWarning/1', 'Val_OverRide_NDCDCRcpWarning_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion72']);
CovertPortHandles = get_param( [gcs '/SignalConvertion72'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(72), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '26');
lineHandle = add_line(gcs,'SignalConvertion72/1','x393_NDCDCValue_2/26','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_NDCDCRcpWarning');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_NDCDCSerial_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_NDCDCSerial'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCSerial::En_OverRide_NDCDCSerial','editSampleTime','0.001','Position', [20 4385 70 4415]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_NDCDCSerial/1', 'En_OverRide_NDCDCSerial_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion73']);
CovertPortHandles = get_param( [gcs '/SignalConvertion73'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(73), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_NDCDCSerial']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_NDCDCSerial'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_NDCDCSerial/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '27');
En_OverRide_NDCDCSerialHandle = add_line(gcs,'AND_En_OverRide_NDCDCSerial/1','x393_NDCDCValue_2/27','autorouting','on');
set_param(En_OverRide_NDCDCSerialHandle, 'Name', 'En_OverRide_NDCDCSerial');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_NDCDCSerial_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_NDCDCSerial'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCSerial::Val_OverRide_NDCDCSerial','editSampleTime','0.001','Position', [20 4445 70 4475]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_NDCDCSerial/1', 'Val_OverRide_NDCDCSerial_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion74']);
CovertPortHandles = get_param( [gcs '/SignalConvertion74'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(74), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '28');
lineHandle = add_line(gcs,'SignalConvertion74/1','x393_NDCDCValue_2/28','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_NDCDCSerial');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_NDCDCXcpFaults_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_NDCDCXcpFaults'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCXcpFaults::En_OverRide_NDCDCXcpFaults','editSampleTime','0.001','Position', [20 4505 70 4535]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_NDCDCXcpFaults/1', 'En_OverRide_NDCDCXcpFaults_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion75']);
CovertPortHandles = get_param( [gcs '/SignalConvertion75'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(75), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_NDCDCXcpFaults']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_NDCDCXcpFaults'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_NDCDCXcpFaults/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '29');
En_OverRide_NDCDCXcpFaultsHandle = add_line(gcs,'AND_En_OverRide_NDCDCXcpFaults/1','x393_NDCDCValue_2/29','autorouting','on');
set_param(En_OverRide_NDCDCXcpFaultsHandle, 'Name', 'En_OverRide_NDCDCXcpFaults');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_NDCDCXcpFaults_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_NDCDCXcpFaults'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::NDCDCXcpFaults::Val_OverRide_NDCDCXcpFaults','editSampleTime','0.001','Position', [20 4565 70 4595]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_NDCDCXcpFaults/1', 'Val_OverRide_NDCDCXcpFaults_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion76']);
CovertPortHandles = get_param( [gcs '/SignalConvertion76'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(76), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '30');
lineHandle = add_line(gcs,'SignalConvertion76/1','x393_NDCDCValue_2/30','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_NDCDCXcpFaults');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_TDCDCBB1Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_TDCDCBB1Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::TDCDCBB1Measured::En_OverRide_TDCDCBB1Measured','editSampleTime','0.001','Position', [20 4625 70 4655]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_TDCDCBB1Measured/1', 'En_OverRide_TDCDCBB1Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion77']);
CovertPortHandles = get_param( [gcs '/SignalConvertion77'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(77), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_TDCDCBB1Measured']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_TDCDCBB1Measured'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_TDCDCBB1Measured/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '31');
En_OverRide_TDCDCBB1MeasuredHandle = add_line(gcs,'AND_En_OverRide_TDCDCBB1Measured/1','x393_NDCDCValue_2/31','autorouting','on');
set_param(En_OverRide_TDCDCBB1MeasuredHandle, 'Name', 'En_OverRide_TDCDCBB1Measured');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_TDCDCBB1Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_TDCDCBB1Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::TDCDCBB1Measured::Val_OverRide_TDCDCBB1Measured','editSampleTime','0.001','Position', [20 4685 70 4715]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_TDCDCBB1Measured/1', 'Val_OverRide_TDCDCBB1Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion78']);
CovertPortHandles = get_param( [gcs '/SignalConvertion78'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(78), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '32');
lineHandle = add_line(gcs,'SignalConvertion78/1','x393_NDCDCValue_2/32','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_TDCDCBB1Measured');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_TDCDCBB2Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_TDCDCBB2Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::TDCDCBB2Measured::En_OverRide_TDCDCBB2Measured','editSampleTime','0.001','Position', [20 4745 70 4775]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_TDCDCBB2Measured/1', 'En_OverRide_TDCDCBB2Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion79']);
CovertPortHandles = get_param( [gcs '/SignalConvertion79'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(79), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_TDCDCBB2Measured']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_TDCDCBB2Measured'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_TDCDCBB2Measured/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '33');
En_OverRide_TDCDCBB2MeasuredHandle = add_line(gcs,'AND_En_OverRide_TDCDCBB2Measured/1','x393_NDCDCValue_2/33','autorouting','on');
set_param(En_OverRide_TDCDCBB2MeasuredHandle, 'Name', 'En_OverRide_TDCDCBB2Measured');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_TDCDCBB2Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_TDCDCBB2Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::TDCDCBB2Measured::Val_OverRide_TDCDCBB2Measured','editSampleTime','0.001','Position', [20 4805 70 4835]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_TDCDCBB2Measured/1', 'Val_OverRide_TDCDCBB2Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion80']);
CovertPortHandles = get_param( [gcs '/SignalConvertion80'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(80), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '34');
lineHandle = add_line(gcs,'SignalConvertion80/1','x393_NDCDCValue_2/34','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_TDCDCBB2Measured');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_TDCDCBB3Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_TDCDCBB3Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::TDCDCBB3Measured::En_OverRide_TDCDCBB3Measured','editSampleTime','0.001','Position', [20 4865 70 4895]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_TDCDCBB3Measured/1', 'En_OverRide_TDCDCBB3Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion81']);
CovertPortHandles = get_param( [gcs '/SignalConvertion81'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(81), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_TDCDCBB3Measured']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_TDCDCBB3Measured'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_TDCDCBB3Measured/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '35');
En_OverRide_TDCDCBB3MeasuredHandle = add_line(gcs,'AND_En_OverRide_TDCDCBB3Measured/1','x393_NDCDCValue_2/35','autorouting','on');
set_param(En_OverRide_TDCDCBB3MeasuredHandle, 'Name', 'En_OverRide_TDCDCBB3Measured');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_TDCDCBB3Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_TDCDCBB3Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::TDCDCBB3Measured::Val_OverRide_TDCDCBB3Measured','editSampleTime','0.001','Position', [20 4925 70 4955]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_TDCDCBB3Measured/1', 'Val_OverRide_TDCDCBB3Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion82']);
CovertPortHandles = get_param( [gcs '/SignalConvertion82'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(82), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '36');
lineHandle = add_line(gcs,'SignalConvertion82/1','x393_NDCDCValue_2/36','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_TDCDCBB3Measured');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_TDCDCBB4Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_TDCDCBB4Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::TDCDCBB4Measured::En_OverRide_TDCDCBB4Measured','editSampleTime','0.001','Position', [20 4985 70 5015]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_TDCDCBB4Measured/1', 'En_OverRide_TDCDCBB4Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion83']);
CovertPortHandles = get_param( [gcs '/SignalConvertion83'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(83), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_TDCDCBB4Measured']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_TDCDCBB4Measured'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_TDCDCBB4Measured/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '37');
En_OverRide_TDCDCBB4MeasuredHandle = add_line(gcs,'AND_En_OverRide_TDCDCBB4Measured/1','x393_NDCDCValue_2/37','autorouting','on');
set_param(En_OverRide_TDCDCBB4MeasuredHandle, 'Name', 'En_OverRide_TDCDCBB4Measured');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_TDCDCBB4Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_TDCDCBB4Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::TDCDCBB4Measured::Val_OverRide_TDCDCBB4Measured','editSampleTime','0.001','Position', [20 5045 70 5075]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_TDCDCBB4Measured/1', 'Val_OverRide_TDCDCBB4Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion84']);
CovertPortHandles = get_param( [gcs '/SignalConvertion84'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(84), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '38');
lineHandle = add_line(gcs,'SignalConvertion84/1','x393_NDCDCValue_2/38','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_TDCDCBB4Measured');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_TDCDCSR1Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_TDCDCSR1Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::TDCDCSR1Measured::En_OverRide_TDCDCSR1Measured','editSampleTime','0.001','Position', [20 5105 70 5135]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_TDCDCSR1Measured/1', 'En_OverRide_TDCDCSR1Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion85']);
CovertPortHandles = get_param( [gcs '/SignalConvertion85'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(85), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_TDCDCSR1Measured']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_TDCDCSR1Measured'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_TDCDCSR1Measured/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '39');
En_OverRide_TDCDCSR1MeasuredHandle = add_line(gcs,'AND_En_OverRide_TDCDCSR1Measured/1','x393_NDCDCValue_2/39','autorouting','on');
set_param(En_OverRide_TDCDCSR1MeasuredHandle, 'Name', 'En_OverRide_TDCDCSR1Measured');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_TDCDCSR1Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_TDCDCSR1Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::TDCDCSR1Measured::Val_OverRide_TDCDCSR1Measured','editSampleTime','0.001','Position', [20 5165 70 5195]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_TDCDCSR1Measured/1', 'Val_OverRide_TDCDCSR1Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion86']);
CovertPortHandles = get_param( [gcs '/SignalConvertion86'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(86), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '40');
lineHandle = add_line(gcs,'SignalConvertion86/1','x393_NDCDCValue_2/40','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_TDCDCSR1Measured');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_TDCDCSR2Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_TDCDCSR2Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::TDCDCSR2Measured::En_OverRide_TDCDCSR2Measured','editSampleTime','0.001','Position', [20 5225 70 5255]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_TDCDCSR2Measured/1', 'En_OverRide_TDCDCSR2Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion87']);
CovertPortHandles = get_param( [gcs '/SignalConvertion87'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(87), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_TDCDCSR2Measured']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_TDCDCSR2Measured'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_TDCDCSR2Measured/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '41');
En_OverRide_TDCDCSR2MeasuredHandle = add_line(gcs,'AND_En_OverRide_TDCDCSR2Measured/1','x393_NDCDCValue_2/41','autorouting','on');
set_param(En_OverRide_TDCDCSR2MeasuredHandle, 'Name', 'En_OverRide_TDCDCSR2Measured');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_TDCDCSR2Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_TDCDCSR2Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::TDCDCSR2Measured::Val_OverRide_TDCDCSR2Measured','editSampleTime','0.001','Position', [20 5285 70 5315]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_TDCDCSR2Measured/1', 'Val_OverRide_TDCDCSR2Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion88']);
CovertPortHandles = get_param( [gcs '/SignalConvertion88'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(88), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '42');
lineHandle = add_line(gcs,'SignalConvertion88/1','x393_NDCDCValue_2/42','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_TDCDCSR2Measured');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCAux1Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCAux1Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCAux1Measured::En_OverRide_VDCDCAux1Measured','editSampleTime','0.001','Position', [20 5345 70 5375]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCAux1Measured/1', 'En_OverRide_VDCDCAux1Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion89']);
CovertPortHandles = get_param( [gcs '/SignalConvertion89'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(89), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCAux1Measured']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCAux1Measured'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCAux1Measured/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '43');
En_OverRide_VDCDCAux1MeasuredHandle = add_line(gcs,'AND_En_OverRide_VDCDCAux1Measured/1','x393_NDCDCValue_2/43','autorouting','on');
set_param(En_OverRide_VDCDCAux1MeasuredHandle, 'Name', 'En_OverRide_VDCDCAux1Measured');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCAux1Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCAux1Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCAux1Measured::Val_OverRide_VDCDCAux1Measured','editSampleTime','0.001','Position', [20 5405 70 5435]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCAux1Measured/1', 'Val_OverRide_VDCDCAux1Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion90']);
CovertPortHandles = get_param( [gcs '/SignalConvertion90'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(90), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '44');
lineHandle = add_line(gcs,'SignalConvertion90/1','x393_NDCDCValue_2/44','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCAux1Measured');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCAux2Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCAux2Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCAux2Measured::En_OverRide_VDCDCAux2Measured','editSampleTime','0.001','Position', [20 5465 70 5495]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCAux2Measured/1', 'En_OverRide_VDCDCAux2Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion91']);
CovertPortHandles = get_param( [gcs '/SignalConvertion91'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(91), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCAux2Measured']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCAux2Measured'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCAux2Measured/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '45');
En_OverRide_VDCDCAux2MeasuredHandle = add_line(gcs,'AND_En_OverRide_VDCDCAux2Measured/1','x393_NDCDCValue_2/45','autorouting','on');
set_param(En_OverRide_VDCDCAux2MeasuredHandle, 'Name', 'En_OverRide_VDCDCAux2Measured');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCAux2Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCAux2Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCAux2Measured::Val_OverRide_VDCDCAux2Measured','editSampleTime','0.001','Position', [20 5525 70 5555]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCAux2Measured/1', 'Val_OverRide_VDCDCAux2Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion92']);
CovertPortHandles = get_param( [gcs '/SignalConvertion92'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(92), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '46');
lineHandle = add_line(gcs,'SignalConvertion92/1','x393_NDCDCValue_2/46','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCAux2Measured');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCAux3Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCAux3Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCAux3Measured::En_OverRide_VDCDCAux3Measured','editSampleTime','0.001','Position', [20 5585 70 5615]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCAux3Measured/1', 'En_OverRide_VDCDCAux3Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion93']);
CovertPortHandles = get_param( [gcs '/SignalConvertion93'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(93), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCAux3Measured']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCAux3Measured'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCAux3Measured/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '47');
En_OverRide_VDCDCAux3MeasuredHandle = add_line(gcs,'AND_En_OverRide_VDCDCAux3Measured/1','x393_NDCDCValue_2/47','autorouting','on');
set_param(En_OverRide_VDCDCAux3MeasuredHandle, 'Name', 'En_OverRide_VDCDCAux3Measured');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCAux3Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCAux3Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCAux3Measured::Val_OverRide_VDCDCAux3Measured','editSampleTime','0.001','Position', [20 5645 70 5675]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCAux3Measured/1', 'Val_OverRide_VDCDCAux3Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion94']);
CovertPortHandles = get_param( [gcs '/SignalConvertion94'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(94), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '48');
lineHandle = add_line(gcs,'SignalConvertion94/1','x393_NDCDCValue_2/48','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCAux3Measured');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCAux4Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCAux4Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCAux4Measured::En_OverRide_VDCDCAux4Measured','editSampleTime','0.001','Position', [20 5705 70 5735]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCAux4Measured/1', 'En_OverRide_VDCDCAux4Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion95']);
CovertPortHandles = get_param( [gcs '/SignalConvertion95'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(95), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCAux4Measured']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCAux4Measured'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCAux4Measured/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '49');
En_OverRide_VDCDCAux4MeasuredHandle = add_line(gcs,'AND_En_OverRide_VDCDCAux4Measured/1','x393_NDCDCValue_2/49','autorouting','on');
set_param(En_OverRide_VDCDCAux4MeasuredHandle, 'Name', 'En_OverRide_VDCDCAux4Measured');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCAux4Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCAux4Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCAux4Measured::Val_OverRide_VDCDCAux4Measured','editSampleTime','0.001','Position', [20 5765 70 5795]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCAux4Measured/1', 'Val_OverRide_VDCDCAux4Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion96']);
CovertPortHandles = get_param( [gcs '/SignalConvertion96'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(96), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '50');
lineHandle = add_line(gcs,'SignalConvertion96/1','x393_NDCDCValue_2/50','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCAux4Measured');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCAux5Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCAux5Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCAux5Measured::En_OverRide_VDCDCAux5Measured','editSampleTime','0.001','Position', [20 5825 70 5855]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCAux5Measured/1', 'En_OverRide_VDCDCAux5Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion97']);
CovertPortHandles = get_param( [gcs '/SignalConvertion97'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(97), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCAux5Measured']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCAux5Measured'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCAux5Measured/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '51');
En_OverRide_VDCDCAux5MeasuredHandle = add_line(gcs,'AND_En_OverRide_VDCDCAux5Measured/1','x393_NDCDCValue_2/51','autorouting','on');
set_param(En_OverRide_VDCDCAux5MeasuredHandle, 'Name', 'En_OverRide_VDCDCAux5Measured');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCAux5Measured_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCAux5Measured'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCAux5Measured::Val_OverRide_VDCDCAux5Measured','editSampleTime','0.001','Position', [20 5885 70 5915]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCAux5Measured/1', 'Val_OverRide_VDCDCAux5Measured_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion98']);
CovertPortHandles = get_param( [gcs '/SignalConvertion98'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(98), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '52');
lineHandle = add_line(gcs,'SignalConvertion98/1','x393_NDCDCValue_2/52','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCAux5Measured');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCHVInAverage_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCHVInAverage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCHVInAverage::En_OverRide_VDCDCHVInAverage','editSampleTime','0.001','Position', [20 5945 70 5975]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCHVInAverage/1', 'En_OverRide_VDCDCHVInAverage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion99']);
CovertPortHandles = get_param( [gcs '/SignalConvertion99'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(99), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCHVInAverage']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCHVInAverage'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCHVInAverage/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '53');
En_OverRide_VDCDCHVInAverageHandle = add_line(gcs,'AND_En_OverRide_VDCDCHVInAverage/1','x393_NDCDCValue_2/53','autorouting','on');
set_param(En_OverRide_VDCDCHVInAverageHandle, 'Name', 'En_OverRide_VDCDCHVInAverage');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCHVInAverage_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCHVInAverage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x393_NDCDCValue::VDCDCHVInAverage::Val_OverRide_VDCDCHVInAverage','editSampleTime','0.001','Position', [20 6005 70 6035]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCHVInAverage/1', 'Val_OverRide_VDCDCHVInAverage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion100']);
CovertPortHandles = get_param( [gcs '/SignalConvertion100'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(100), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x393_NDCDCValue_2'], 'Inputs', '54');
lineHandle = add_line(gcs,'SignalConvertion100/1','x393_NDCDCValue_2/54','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCHVInAverage');



set_param([gcs,'/DCDC'], 'Inputs', '2')
lineHandle = add_line(gcs,'x393_NDCDCValue_2/1','DCDC/2','autorouting','on')
set_param(lineHandle, 'Name', 'x393_NDCDCValue');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/x394_NDCDCValueOutput1_3']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_IDCDCOutput1Average_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_IDCDCOutput1Average'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x394_NDCDCValueOutput1::IDCDCOutput1Average::En_OverRide_IDCDCOutput1Average','editSampleTime','0.001','Position', [20 6065 70 6095]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_IDCDCOutput1Average/1', 'En_OverRide_IDCDCOutput1Average_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion101']);
CovertPortHandles = get_param( [gcs '/SignalConvertion101'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(101), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_IDCDCOutput1Average']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_IDCDCOutput1Average'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_IDCDCOutput1Average/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x394_NDCDCValueOutput1_3'], 'Inputs', '1');
En_OverRide_IDCDCOutput1AverageHandle = add_line(gcs,'AND_En_OverRide_IDCDCOutput1Average/1','x394_NDCDCValueOutput1_3/1','autorouting','on');
set_param(En_OverRide_IDCDCOutput1AverageHandle, 'Name', 'En_OverRide_IDCDCOutput1Average');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_IDCDCOutput1Average_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_IDCDCOutput1Average'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x394_NDCDCValueOutput1::IDCDCOutput1Average::Val_OverRide_IDCDCOutput1Average','editSampleTime','0.001','Position', [20 6125 70 6155]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_IDCDCOutput1Average/1', 'Val_OverRide_IDCDCOutput1Average_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion102']);
CovertPortHandles = get_param( [gcs '/SignalConvertion102'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(102), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x394_NDCDCValueOutput1_3'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion102/1','x394_NDCDCValueOutput1_3/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_IDCDCOutput1Average');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCOutput1Average_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCOutput1Average'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x394_NDCDCValueOutput1::VDCDCOutput1Average::En_OverRide_VDCDCOutput1Average','editSampleTime','0.001','Position', [20 6185 70 6215]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCOutput1Average/1', 'En_OverRide_VDCDCOutput1Average_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion103']);
CovertPortHandles = get_param( [gcs '/SignalConvertion103'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(103), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCOutput1Average']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCOutput1Average'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCOutput1Average/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x394_NDCDCValueOutput1_3'], 'Inputs', '3');
En_OverRide_VDCDCOutput1AverageHandle = add_line(gcs,'AND_En_OverRide_VDCDCOutput1Average/1','x394_NDCDCValueOutput1_3/3','autorouting','on');
set_param(En_OverRide_VDCDCOutput1AverageHandle, 'Name', 'En_OverRide_VDCDCOutput1Average');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCOutput1Average_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCOutput1Average'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x394_NDCDCValueOutput1::VDCDCOutput1Average::Val_OverRide_VDCDCOutput1Average','editSampleTime','0.001','Position', [20 6245 70 6275]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCOutput1Average/1', 'Val_OverRide_VDCDCOutput1Average_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion104']);
CovertPortHandles = get_param( [gcs '/SignalConvertion104'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(104), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x394_NDCDCValueOutput1_3'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion104/1','x394_NDCDCValueOutput1_3/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCOutput1Average');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCOutput1Max_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCOutput1Max'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x394_NDCDCValueOutput1::VDCDCOutput1Max::En_OverRide_VDCDCOutput1Max','editSampleTime','0.001','Position', [20 6305 70 6335]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCOutput1Max/1', 'En_OverRide_VDCDCOutput1Max_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion105']);
CovertPortHandles = get_param( [gcs '/SignalConvertion105'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(105), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCOutput1Max']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCOutput1Max'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCOutput1Max/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x394_NDCDCValueOutput1_3'], 'Inputs', '5');
En_OverRide_VDCDCOutput1MaxHandle = add_line(gcs,'AND_En_OverRide_VDCDCOutput1Max/1','x394_NDCDCValueOutput1_3/5','autorouting','on');
set_param(En_OverRide_VDCDCOutput1MaxHandle, 'Name', 'En_OverRide_VDCDCOutput1Max');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCOutput1Max_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCOutput1Max'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x394_NDCDCValueOutput1::VDCDCOutput1Max::Val_OverRide_VDCDCOutput1Max','editSampleTime','0.001','Position', [20 6365 70 6395]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCOutput1Max/1', 'Val_OverRide_VDCDCOutput1Max_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion106']);
CovertPortHandles = get_param( [gcs '/SignalConvertion106'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(106), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x394_NDCDCValueOutput1_3'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion106/1','x394_NDCDCValueOutput1_3/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCOutput1Max');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCOutput1Min_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCOutput1Min'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x394_NDCDCValueOutput1::VDCDCOutput1Min::En_OverRide_VDCDCOutput1Min','editSampleTime','0.001','Position', [20 6425 70 6455]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCOutput1Min/1', 'En_OverRide_VDCDCOutput1Min_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion107']);
CovertPortHandles = get_param( [gcs '/SignalConvertion107'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(107), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCOutput1Min']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCOutput1Min'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCOutput1Min/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x394_NDCDCValueOutput1_3'], 'Inputs', '7');
En_OverRide_VDCDCOutput1MinHandle = add_line(gcs,'AND_En_OverRide_VDCDCOutput1Min/1','x394_NDCDCValueOutput1_3/7','autorouting','on');
set_param(En_OverRide_VDCDCOutput1MinHandle, 'Name', 'En_OverRide_VDCDCOutput1Min');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCOutput1Min_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCOutput1Min'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x394_NDCDCValueOutput1::VDCDCOutput1Min::Val_OverRide_VDCDCOutput1Min','editSampleTime','0.001','Position', [20 6485 70 6515]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCOutput1Min/1', 'Val_OverRide_VDCDCOutput1Min_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion108']);
CovertPortHandles = get_param( [gcs '/SignalConvertion108'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(108), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x394_NDCDCValueOutput1_3'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion108/1','x394_NDCDCValueOutput1_3/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCOutput1Min');



set_param([gcs,'/DCDC'], 'Inputs', '3')
lineHandle = add_line(gcs,'x394_NDCDCValueOutput1_3/1','DCDC/3','autorouting','on')
set_param(lineHandle, 'Name', 'x394_NDCDCValueOutput1');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/x395_NDCDCValueOutput2_4']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_IDCDCOutput2Average_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_IDCDCOutput2Average'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x395_NDCDCValueOutput2::IDCDCOutput2Average::En_OverRide_IDCDCOutput2Average','editSampleTime','0.001','Position', [20 6545 70 6575]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_IDCDCOutput2Average/1', 'En_OverRide_IDCDCOutput2Average_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion109']);
CovertPortHandles = get_param( [gcs '/SignalConvertion109'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(109), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_IDCDCOutput2Average']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_IDCDCOutput2Average'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_IDCDCOutput2Average/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x395_NDCDCValueOutput2_4'], 'Inputs', '1');
En_OverRide_IDCDCOutput2AverageHandle = add_line(gcs,'AND_En_OverRide_IDCDCOutput2Average/1','x395_NDCDCValueOutput2_4/1','autorouting','on');
set_param(En_OverRide_IDCDCOutput2AverageHandle, 'Name', 'En_OverRide_IDCDCOutput2Average');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_IDCDCOutput2Average_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_IDCDCOutput2Average'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x395_NDCDCValueOutput2::IDCDCOutput2Average::Val_OverRide_IDCDCOutput2Average','editSampleTime','0.001','Position', [20 6605 70 6635]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_IDCDCOutput2Average/1', 'Val_OverRide_IDCDCOutput2Average_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion110']);
CovertPortHandles = get_param( [gcs '/SignalConvertion110'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(110), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x395_NDCDCValueOutput2_4'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion110/1','x395_NDCDCValueOutput2_4/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_IDCDCOutput2Average');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCOutput2Average_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCOutput2Average'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x395_NDCDCValueOutput2::VDCDCOutput2Average::En_OverRide_VDCDCOutput2Average','editSampleTime','0.001','Position', [20 6665 70 6695]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCOutput2Average/1', 'En_OverRide_VDCDCOutput2Average_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion111']);
CovertPortHandles = get_param( [gcs '/SignalConvertion111'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(111), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCOutput2Average']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCOutput2Average'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCOutput2Average/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x395_NDCDCValueOutput2_4'], 'Inputs', '3');
En_OverRide_VDCDCOutput2AverageHandle = add_line(gcs,'AND_En_OverRide_VDCDCOutput2Average/1','x395_NDCDCValueOutput2_4/3','autorouting','on');
set_param(En_OverRide_VDCDCOutput2AverageHandle, 'Name', 'En_OverRide_VDCDCOutput2Average');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCOutput2Average_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCOutput2Average'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x395_NDCDCValueOutput2::VDCDCOutput2Average::Val_OverRide_VDCDCOutput2Average','editSampleTime','0.001','Position', [20 6725 70 6755]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCOutput2Average/1', 'Val_OverRide_VDCDCOutput2Average_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion112']);
CovertPortHandles = get_param( [gcs '/SignalConvertion112'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(112), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x395_NDCDCValueOutput2_4'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion112/1','x395_NDCDCValueOutput2_4/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCOutput2Average');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCOutput2Max_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCOutput2Max'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x395_NDCDCValueOutput2::VDCDCOutput2Max::En_OverRide_VDCDCOutput2Max','editSampleTime','0.001','Position', [20 6785 70 6815]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCOutput2Max/1', 'En_OverRide_VDCDCOutput2Max_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion113']);
CovertPortHandles = get_param( [gcs '/SignalConvertion113'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(113), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCOutput2Max']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCOutput2Max'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCOutput2Max/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x395_NDCDCValueOutput2_4'], 'Inputs', '5');
En_OverRide_VDCDCOutput2MaxHandle = add_line(gcs,'AND_En_OverRide_VDCDCOutput2Max/1','x395_NDCDCValueOutput2_4/5','autorouting','on');
set_param(En_OverRide_VDCDCOutput2MaxHandle, 'Name', 'En_OverRide_VDCDCOutput2Max');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCOutput2Max_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCOutput2Max'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x395_NDCDCValueOutput2::VDCDCOutput2Max::Val_OverRide_VDCDCOutput2Max','editSampleTime','0.001','Position', [20 6845 70 6875]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCOutput2Max/1', 'Val_OverRide_VDCDCOutput2Max_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion114']);
CovertPortHandles = get_param( [gcs '/SignalConvertion114'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(114), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x395_NDCDCValueOutput2_4'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion114/1','x395_NDCDCValueOutput2_4/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCOutput2Max');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/En_OverRide_VDCDCOutput2Min_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/En_OverRide_VDCDCOutput2Min'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x395_NDCDCValueOutput2::VDCDCOutput2Min::En_OverRide_VDCDCOutput2Min','editSampleTime','0.001','Position', [20 6905 70 6935]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'En_OverRide_VDCDCOutput2Min/1', 'En_OverRide_VDCDCOutput2Min_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion115']);
CovertPortHandles = get_param( [gcs '/SignalConvertion115'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(115), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_VDCDCOutput2Min']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_VDCDCOutput2Min'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_VDCDCOutput2Min/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x395_NDCDCValueOutput2_4'], 'Inputs', '7');
En_OverRide_VDCDCOutput2MinHandle = add_line(gcs,'AND_En_OverRide_VDCDCOutput2Min/1','x395_NDCDCValueOutput2_4/7','autorouting','on');
set_param(En_OverRide_VDCDCOutput2MinHandle, 'Name', 'En_OverRide_VDCDCOutput2Min');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/DCDC_EnabledSubsystem/Val_OverRide_VDCDCOutput2Min_port']);
SubsysPortHandles = get_param( [gcs '/DCDC_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/DCDC_EnabledSubsystem/Val_OverRide_VDCDCOutput2Min'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::DCDC::x395_NDCDCValueOutput2::VDCDCOutput2Min::Val_OverRide_VDCDCOutput2Min','editSampleTime','0.001','Position', [20 6965 70 6995]);
add_line([gcs '/DCDC_EnabledSubsystem'], 'Val_OverRide_VDCDCOutput2Min/1', 'Val_OverRide_VDCDCOutput2Min_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion116']);
CovertPortHandles = get_param( [gcs '/SignalConvertion116'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(116), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x395_NDCDCValueOutput2_4'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion116/1','x395_NDCDCValueOutput2_4/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_VDCDCOutput2Min');



set_param([gcs,'/DCDC'], 'Inputs', '4')
lineHandle = add_line(gcs,'x395_NDCDCValueOutput2_4/1','DCDC/4','autorouting','on')
set_param(lineHandle, 'Name', 'x395_NDCDCValueOutput2');

 
set_param(gcs,...
'Solver','FixedStepDiscrete',...
'FixedStep','0.1');
save_system(fname);