
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
add_block('simulink/Signal Routing/Bus Creator', [gcs,'/BMS']);

add_block('simulink/Ports & Subsystems/Enabled Subsystem', [gcs '/BMS_EnabledSubsystem']);
delete_block([gcs '/BMS_EnabledSubsystem/In1']);
delete_block([gcs '/BMS_EnabledSubsystem/Out1']);
add_block('simulink/Signal Routing/Bus Creator', [gcs,'/xCC_BMS_HV_04_ContactorStatus_1']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_AncOutVoltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_AncOutVoltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCC_BMS_HV_04_ContactorStatus::Batt_AncOutVoltage::En_OverRide_Batt_AncOutVoltage','editSampleTime','0.001','Position', [20 65 70 95]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_AncOutVoltage/1', 'En_OverRide_Batt_AncOutVoltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion1']);
CovertPortHandles = get_param( [gcs '/SignalConvertion1'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(1), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_AncOutVoltage']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_AncOutVoltage'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_AncOutVoltage/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCC_BMS_HV_04_ContactorStatus_1'], 'Inputs', '1');
En_OverRide_Batt_AncOutVoltageHandle = add_line(gcs,'AND_En_OverRide_Batt_AncOutVoltage/1','xCC_BMS_HV_04_ContactorStatus_1/1','autorouting','on');
set_param(En_OverRide_Batt_AncOutVoltageHandle, 'Name', 'En_OverRide_Batt_AncOutVoltage');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_AncOutVoltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_AncOutVoltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCC_BMS_HV_04_ContactorStatus::Batt_AncOutVoltage::Val_OverRide_Batt_AncOutVoltage','editSampleTime','0.001','Position', [20 125 70 155]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_AncOutVoltage/1', 'Val_OverRide_Batt_AncOutVoltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion2']);
CovertPortHandles = get_param( [gcs '/SignalConvertion2'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(2), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCC_BMS_HV_04_ContactorStatus_1'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion2/1','xCC_BMS_HV_04_ContactorStatus_1/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_AncOutVoltage');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_ChargeContactorStatus_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_ChargeContactorStatus'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCC_BMS_HV_04_ContactorStatus::Batt_ChargeContactorStatus::En_OverRide_Batt_ChargeContactorStatus','editSampleTime','0.001','Position', [20 185 70 215]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_ChargeContactorStatus/1', 'En_OverRide_Batt_ChargeContactorStatus_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion3']);
CovertPortHandles = get_param( [gcs '/SignalConvertion3'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(3), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_ChargeContactorStatus']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_ChargeContactorStatus'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_ChargeContactorStatus/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCC_BMS_HV_04_ContactorStatus_1'], 'Inputs', '3');
En_OverRide_Batt_ChargeContactorStatusHandle = add_line(gcs,'AND_En_OverRide_Batt_ChargeContactorStatus/1','xCC_BMS_HV_04_ContactorStatus_1/3','autorouting','on');
set_param(En_OverRide_Batt_ChargeContactorStatusHandle, 'Name', 'En_OverRide_Batt_ChargeContactorStatus');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_ChargeContactorStatus_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_ChargeContactorStatus'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCC_BMS_HV_04_ContactorStatus::Batt_ChargeContactorStatus::Val_OverRide_Batt_ChargeContactorStatus','editSampleTime','0.001','Position', [20 245 70 275]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_ChargeContactorStatus/1', 'Val_OverRide_Batt_ChargeContactorStatus_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion4']);
CovertPortHandles = get_param( [gcs '/SignalConvertion4'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(4), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCC_BMS_HV_04_ContactorStatus_1'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion4/1','xCC_BMS_HV_04_ContactorStatus_1/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_ChargeContactorStatus');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_InvOutVoltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_InvOutVoltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCC_BMS_HV_04_ContactorStatus::Batt_InvOutVoltage::En_OverRide_Batt_InvOutVoltage','editSampleTime','0.001','Position', [20 305 70 335]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_InvOutVoltage/1', 'En_OverRide_Batt_InvOutVoltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion5']);
CovertPortHandles = get_param( [gcs '/SignalConvertion5'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(5), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_InvOutVoltage']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_InvOutVoltage'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_InvOutVoltage/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCC_BMS_HV_04_ContactorStatus_1'], 'Inputs', '5');
En_OverRide_Batt_InvOutVoltageHandle = add_line(gcs,'AND_En_OverRide_Batt_InvOutVoltage/1','xCC_BMS_HV_04_ContactorStatus_1/5','autorouting','on');
set_param(En_OverRide_Batt_InvOutVoltageHandle, 'Name', 'En_OverRide_Batt_InvOutVoltage');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_InvOutVoltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_InvOutVoltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCC_BMS_HV_04_ContactorStatus::Batt_InvOutVoltage::Val_OverRide_Batt_InvOutVoltage','editSampleTime','0.001','Position', [20 365 70 395]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_InvOutVoltage/1', 'Val_OverRide_Batt_InvOutVoltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion6']);
CovertPortHandles = get_param( [gcs '/SignalConvertion6'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(6), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCC_BMS_HV_04_ContactorStatus_1'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion6/1','xCC_BMS_HV_04_ContactorStatus_1/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_InvOutVoltage');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_MainContactorStatus_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_MainContactorStatus'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCC_BMS_HV_04_ContactorStatus::Batt_MainContactorStatus::En_OverRide_Batt_MainContactorStatus','editSampleTime','0.001','Position', [20 425 70 455]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_MainContactorStatus/1', 'En_OverRide_Batt_MainContactorStatus_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion7']);
CovertPortHandles = get_param( [gcs '/SignalConvertion7'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(7), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_MainContactorStatus']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_MainContactorStatus'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_MainContactorStatus/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCC_BMS_HV_04_ContactorStatus_1'], 'Inputs', '7');
En_OverRide_Batt_MainContactorStatusHandle = add_line(gcs,'AND_En_OverRide_Batt_MainContactorStatus/1','xCC_BMS_HV_04_ContactorStatus_1/7','autorouting','on');
set_param(En_OverRide_Batt_MainContactorStatusHandle, 'Name', 'En_OverRide_Batt_MainContactorStatus');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_MainContactorStatus_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_MainContactorStatus'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCC_BMS_HV_04_ContactorStatus::Batt_MainContactorStatus::Val_OverRide_Batt_MainContactorStatus','editSampleTime','0.001','Position', [20 485 70 515]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_MainContactorStatus/1', 'Val_OverRide_Batt_MainContactorStatus_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion8']);
CovertPortHandles = get_param( [gcs '/SignalConvertion8'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(8), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCC_BMS_HV_04_ContactorStatus_1'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion8/1','xCC_BMS_HV_04_ContactorStatus_1/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_MainContactorStatus');



set_param([gcs,'/BMS'], 'Inputs', '1')
lineHandle = add_line(gcs,'xCC_BMS_HV_04_ContactorStatus_1/1','BMS/1','autorouting','on')
set_param(lineHandle, 'Name', 'xCC_BMS_HV_04_ContactorStatus');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/xC9_BMS_HV_01_Status_2']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_BalancingRequired_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_BalancingRequired'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_BalancingRequired::En_OverRide_Batt_BalancingRequired','editSampleTime','0.001','Position', [20 545 70 575]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_BalancingRequired/1', 'En_OverRide_Batt_BalancingRequired_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion9']);
CovertPortHandles = get_param( [gcs '/SignalConvertion9'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(9), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_BalancingRequired']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_BalancingRequired'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_BalancingRequired/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '1');
En_OverRide_Batt_BalancingRequiredHandle = add_line(gcs,'AND_En_OverRide_Batt_BalancingRequired/1','xC9_BMS_HV_01_Status_2/1','autorouting','on');
set_param(En_OverRide_Batt_BalancingRequiredHandle, 'Name', 'En_OverRide_Batt_BalancingRequired');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_BalancingRequired_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_BalancingRequired'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_BalancingRequired::Val_OverRide_Batt_BalancingRequired','editSampleTime','0.001','Position', [20 605 70 635]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_BalancingRequired/1', 'Val_OverRide_Batt_BalancingRequired_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion10']);
CovertPortHandles = get_param( [gcs '/SignalConvertion10'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(10), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion10/1','xC9_BMS_HV_01_Status_2/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_BalancingRequired');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_BMSStatus_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_BMSStatus'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_BMSStatus::En_OverRide_Batt_BMSStatus','editSampleTime','0.001','Position', [20 665 70 695]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_BMSStatus/1', 'En_OverRide_Batt_BMSStatus_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion11']);
CovertPortHandles = get_param( [gcs '/SignalConvertion11'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(11), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_BMSStatus']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_BMSStatus'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_BMSStatus/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '3');
En_OverRide_Batt_BMSStatusHandle = add_line(gcs,'AND_En_OverRide_Batt_BMSStatus/1','xC9_BMS_HV_01_Status_2/3','autorouting','on');
set_param(En_OverRide_Batt_BMSStatusHandle, 'Name', 'En_OverRide_Batt_BMSStatus');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_BMSStatus_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_BMSStatus'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_BMSStatus::Val_OverRide_Batt_BMSStatus','editSampleTime','0.001','Position', [20 725 70 755]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_BMSStatus/1', 'Val_OverRide_Batt_BMSStatus_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion12']);
CovertPortHandles = get_param( [gcs '/SignalConvertion12'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(12), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion12/1','xC9_BMS_HV_01_Status_2/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_BMSStatus');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Equity_SoC_Displayed_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Equity_SoC_Displayed'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Equity_SoC_Displayed::En_OverRide_Batt_Equity_SoC_Displayed','editSampleTime','0.001','Position', [20 785 70 815]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Equity_SoC_Displayed/1', 'En_OverRide_Batt_Equity_SoC_Displayed_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion13']);
CovertPortHandles = get_param( [gcs '/SignalConvertion13'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(13), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Equity_SoC_Displayed']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Equity_SoC_Displayed'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Equity_SoC_Displayed/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '5');
En_OverRide_Batt_Equity_SoC_DisplayedHandle = add_line(gcs,'AND_En_OverRide_Batt_Equity_SoC_Displayed/1','xC9_BMS_HV_01_Status_2/5','autorouting','on');
set_param(En_OverRide_Batt_Equity_SoC_DisplayedHandle, 'Name', 'En_OverRide_Batt_Equity_SoC_Displayed');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Equity_SoC_Displayed_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Equity_SoC_Displayed'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Equity_SoC_Displayed::Val_OverRide_Batt_Equity_SoC_Displayed','editSampleTime','0.001','Position', [20 845 70 875]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Equity_SoC_Displayed/1', 'Val_OverRide_Batt_Equity_SoC_Displayed_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion14']);
CovertPortHandles = get_param( [gcs '/SignalConvertion14'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(14), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion14/1','xC9_BMS_HV_01_Status_2/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Equity_SoC_Displayed');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR0_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR0'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR0::En_OverRide_Batt_Fault_FR0','editSampleTime','0.001','Position', [20 905 70 935]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Fault_FR0/1', 'En_OverRide_Batt_Fault_FR0_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion15']);
CovertPortHandles = get_param( [gcs '/SignalConvertion15'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(15), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Fault_FR0']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Fault_FR0'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Fault_FR0/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '7');
En_OverRide_Batt_Fault_FR0Handle = add_line(gcs,'AND_En_OverRide_Batt_Fault_FR0/1','xC9_BMS_HV_01_Status_2/7','autorouting','on');
set_param(En_OverRide_Batt_Fault_FR0Handle, 'Name', 'En_OverRide_Batt_Fault_FR0');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR0_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR0'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR0::Val_OverRide_Batt_Fault_FR0','editSampleTime','0.001','Position', [20 965 70 995]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Fault_FR0/1', 'Val_OverRide_Batt_Fault_FR0_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion16']);
CovertPortHandles = get_param( [gcs '/SignalConvertion16'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(16), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion16/1','xC9_BMS_HV_01_Status_2/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Fault_FR0');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR1_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR1'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR1::En_OverRide_Batt_Fault_FR1','editSampleTime','0.001','Position', [20 1025 70 1055]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Fault_FR1/1', 'En_OverRide_Batt_Fault_FR1_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion17']);
CovertPortHandles = get_param( [gcs '/SignalConvertion17'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(17), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Fault_FR1']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Fault_FR1'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Fault_FR1/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '9');
En_OverRide_Batt_Fault_FR1Handle = add_line(gcs,'AND_En_OverRide_Batt_Fault_FR1/1','xC9_BMS_HV_01_Status_2/9','autorouting','on');
set_param(En_OverRide_Batt_Fault_FR1Handle, 'Name', 'En_OverRide_Batt_Fault_FR1');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR1_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR1'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR1::Val_OverRide_Batt_Fault_FR1','editSampleTime','0.001','Position', [20 1085 70 1115]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Fault_FR1/1', 'Val_OverRide_Batt_Fault_FR1_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion18']);
CovertPortHandles = get_param( [gcs '/SignalConvertion18'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(18), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '10');
lineHandle = add_line(gcs,'SignalConvertion18/1','xC9_BMS_HV_01_Status_2/10','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Fault_FR1');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR2_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR2'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR2::En_OverRide_Batt_Fault_FR2','editSampleTime','0.001','Position', [20 1145 70 1175]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Fault_FR2/1', 'En_OverRide_Batt_Fault_FR2_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion19']);
CovertPortHandles = get_param( [gcs '/SignalConvertion19'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(19), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Fault_FR2']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Fault_FR2'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Fault_FR2/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '11');
En_OverRide_Batt_Fault_FR2Handle = add_line(gcs,'AND_En_OverRide_Batt_Fault_FR2/1','xC9_BMS_HV_01_Status_2/11','autorouting','on');
set_param(En_OverRide_Batt_Fault_FR2Handle, 'Name', 'En_OverRide_Batt_Fault_FR2');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR2_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR2'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR2::Val_OverRide_Batt_Fault_FR2','editSampleTime','0.001','Position', [20 1205 70 1235]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Fault_FR2/1', 'Val_OverRide_Batt_Fault_FR2_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion20']);
CovertPortHandles = get_param( [gcs '/SignalConvertion20'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(20), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '12');
lineHandle = add_line(gcs,'SignalConvertion20/1','xC9_BMS_HV_01_Status_2/12','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Fault_FR2');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR3_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR3'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR3::En_OverRide_Batt_Fault_FR3','editSampleTime','0.001','Position', [20 1265 70 1295]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Fault_FR3/1', 'En_OverRide_Batt_Fault_FR3_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion21']);
CovertPortHandles = get_param( [gcs '/SignalConvertion21'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(21), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Fault_FR3']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Fault_FR3'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Fault_FR3/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '13');
En_OverRide_Batt_Fault_FR3Handle = add_line(gcs,'AND_En_OverRide_Batt_Fault_FR3/1','xC9_BMS_HV_01_Status_2/13','autorouting','on');
set_param(En_OverRide_Batt_Fault_FR3Handle, 'Name', 'En_OverRide_Batt_Fault_FR3');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR3_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR3'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR3::Val_OverRide_Batt_Fault_FR3','editSampleTime','0.001','Position', [20 1325 70 1355]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Fault_FR3/1', 'Val_OverRide_Batt_Fault_FR3_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion22']);
CovertPortHandles = get_param( [gcs '/SignalConvertion22'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(22), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '14');
lineHandle = add_line(gcs,'SignalConvertion22/1','xC9_BMS_HV_01_Status_2/14','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Fault_FR3');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR4_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR4'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR4::En_OverRide_Batt_Fault_FR4','editSampleTime','0.001','Position', [20 1385 70 1415]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Fault_FR4/1', 'En_OverRide_Batt_Fault_FR4_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion23']);
CovertPortHandles = get_param( [gcs '/SignalConvertion23'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(23), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Fault_FR4']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Fault_FR4'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Fault_FR4/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '15');
En_OverRide_Batt_Fault_FR4Handle = add_line(gcs,'AND_En_OverRide_Batt_Fault_FR4/1','xC9_BMS_HV_01_Status_2/15','autorouting','on');
set_param(En_OverRide_Batt_Fault_FR4Handle, 'Name', 'En_OverRide_Batt_Fault_FR4');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR4_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR4'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR4::Val_OverRide_Batt_Fault_FR4','editSampleTime','0.001','Position', [20 1445 70 1475]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Fault_FR4/1', 'Val_OverRide_Batt_Fault_FR4_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion24']);
CovertPortHandles = get_param( [gcs '/SignalConvertion24'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(24), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '16');
lineHandle = add_line(gcs,'SignalConvertion24/1','xC9_BMS_HV_01_Status_2/16','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Fault_FR4');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR5_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR5'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR5::En_OverRide_Batt_Fault_FR5','editSampleTime','0.001','Position', [20 1505 70 1535]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Fault_FR5/1', 'En_OverRide_Batt_Fault_FR5_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion25']);
CovertPortHandles = get_param( [gcs '/SignalConvertion25'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(25), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Fault_FR5']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Fault_FR5'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Fault_FR5/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '17');
En_OverRide_Batt_Fault_FR5Handle = add_line(gcs,'AND_En_OverRide_Batt_Fault_FR5/1','xC9_BMS_HV_01_Status_2/17','autorouting','on');
set_param(En_OverRide_Batt_Fault_FR5Handle, 'Name', 'En_OverRide_Batt_Fault_FR5');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR5_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR5'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR5::Val_OverRide_Batt_Fault_FR5','editSampleTime','0.001','Position', [20 1565 70 1595]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Fault_FR5/1', 'Val_OverRide_Batt_Fault_FR5_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion26']);
CovertPortHandles = get_param( [gcs '/SignalConvertion26'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(26), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '18');
lineHandle = add_line(gcs,'SignalConvertion26/1','xC9_BMS_HV_01_Status_2/18','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Fault_FR5');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR6_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR6'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR6::En_OverRide_Batt_Fault_FR6','editSampleTime','0.001','Position', [20 1625 70 1655]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Fault_FR6/1', 'En_OverRide_Batt_Fault_FR6_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion27']);
CovertPortHandles = get_param( [gcs '/SignalConvertion27'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(27), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Fault_FR6']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Fault_FR6'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Fault_FR6/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '19');
En_OverRide_Batt_Fault_FR6Handle = add_line(gcs,'AND_En_OverRide_Batt_Fault_FR6/1','xC9_BMS_HV_01_Status_2/19','autorouting','on');
set_param(En_OverRide_Batt_Fault_FR6Handle, 'Name', 'En_OverRide_Batt_Fault_FR6');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR6_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR6'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR6::Val_OverRide_Batt_Fault_FR6','editSampleTime','0.001','Position', [20 1685 70 1715]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Fault_FR6/1', 'Val_OverRide_Batt_Fault_FR6_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion28']);
CovertPortHandles = get_param( [gcs '/SignalConvertion28'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(28), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '20');
lineHandle = add_line(gcs,'SignalConvertion28/1','xC9_BMS_HV_01_Status_2/20','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Fault_FR6');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR7_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Fault_FR7'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR7::En_OverRide_Batt_Fault_FR7','editSampleTime','0.001','Position', [20 1745 70 1775]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Fault_FR7/1', 'En_OverRide_Batt_Fault_FR7_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion29']);
CovertPortHandles = get_param( [gcs '/SignalConvertion29'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(29), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Fault_FR7']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Fault_FR7'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Fault_FR7/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '21');
En_OverRide_Batt_Fault_FR7Handle = add_line(gcs,'AND_En_OverRide_Batt_Fault_FR7/1','xC9_BMS_HV_01_Status_2/21','autorouting','on');
set_param(En_OverRide_Batt_Fault_FR7Handle, 'Name', 'En_OverRide_Batt_Fault_FR7');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR7_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Fault_FR7'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Fault_FR7::Val_OverRide_Batt_Fault_FR7','editSampleTime','0.001','Position', [20 1805 70 1835]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Fault_FR7/1', 'Val_OverRide_Batt_Fault_FR7_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion30']);
CovertPortHandles = get_param( [gcs '/SignalConvertion30'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(30), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '22');
lineHandle = add_line(gcs,'SignalConvertion30/1','xC9_BMS_HV_01_Status_2/22','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Fault_FR7');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_HVILFault_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_HVILFault'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_HVILFault::En_OverRide_Batt_HVILFault','editSampleTime','0.001','Position', [20 1865 70 1895]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_HVILFault/1', 'En_OverRide_Batt_HVILFault_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion31']);
CovertPortHandles = get_param( [gcs '/SignalConvertion31'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(31), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_HVILFault']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_HVILFault'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_HVILFault/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '23');
En_OverRide_Batt_HVILFaultHandle = add_line(gcs,'AND_En_OverRide_Batt_HVILFault/1','xC9_BMS_HV_01_Status_2/23','autorouting','on');
set_param(En_OverRide_Batt_HVILFaultHandle, 'Name', 'En_OverRide_Batt_HVILFault');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_HVILFault_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_HVILFault'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_HVILFault::Val_OverRide_Batt_HVILFault','editSampleTime','0.001','Position', [20 1925 70 1955]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_HVILFault/1', 'Val_OverRide_Batt_HVILFault_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion32']);
CovertPortHandles = get_param( [gcs '/SignalConvertion32'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(32), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '24');
lineHandle = add_line(gcs,'SignalConvertion32/1','xC9_BMS_HV_01_Status_2/24','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_HVILFault');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Isolation1OnOffStatus_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Isolation1OnOffStatus'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Isolation1OnOffStatus::En_OverRide_Batt_Isolation1OnOffStatus','editSampleTime','0.001','Position', [20 1985 70 2015]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Isolation1OnOffStatus/1', 'En_OverRide_Batt_Isolation1OnOffStatus_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion33']);
CovertPortHandles = get_param( [gcs '/SignalConvertion33'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(33), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Isolation1OnOffStatus']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Isolation1OnOffStatus'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Isolation1OnOffStatus/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '25');
En_OverRide_Batt_Isolation1OnOffStatusHandle = add_line(gcs,'AND_En_OverRide_Batt_Isolation1OnOffStatus/1','xC9_BMS_HV_01_Status_2/25','autorouting','on');
set_param(En_OverRide_Batt_Isolation1OnOffStatusHandle, 'Name', 'En_OverRide_Batt_Isolation1OnOffStatus');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Isolation1OnOffStatus_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Isolation1OnOffStatus'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Isolation1OnOffStatus::Val_OverRide_Batt_Isolation1OnOffStatus','editSampleTime','0.001','Position', [20 2045 70 2075]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Isolation1OnOffStatus/1', 'Val_OverRide_Batt_Isolation1OnOffStatus_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion34']);
CovertPortHandles = get_param( [gcs '/SignalConvertion34'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(34), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '26');
lineHandle = add_line(gcs,'SignalConvertion34/1','xC9_BMS_HV_01_Status_2/26','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Isolation1OnOffStatus');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Isolation1Status_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Isolation1Status'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Isolation1Status::En_OverRide_Batt_Isolation1Status','editSampleTime','0.001','Position', [20 2105 70 2135]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Isolation1Status/1', 'En_OverRide_Batt_Isolation1Status_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion35']);
CovertPortHandles = get_param( [gcs '/SignalConvertion35'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(35), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Isolation1Status']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Isolation1Status'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Isolation1Status/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '27');
En_OverRide_Batt_Isolation1StatusHandle = add_line(gcs,'AND_En_OverRide_Batt_Isolation1Status/1','xC9_BMS_HV_01_Status_2/27','autorouting','on');
set_param(En_OverRide_Batt_Isolation1StatusHandle, 'Name', 'En_OverRide_Batt_Isolation1Status');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Isolation1Status_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Isolation1Status'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Isolation1Status::Val_OverRide_Batt_Isolation1Status','editSampleTime','0.001','Position', [20 2165 70 2195]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Isolation1Status/1', 'Val_OverRide_Batt_Isolation1Status_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion36']);
CovertPortHandles = get_param( [gcs '/SignalConvertion36'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(36), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '28');
lineHandle = add_line(gcs,'SignalConvertion36/1','xC9_BMS_HV_01_Status_2/28','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Isolation1Status');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Isolation2OnOffStatus_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Isolation2OnOffStatus'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Isolation2OnOffStatus::En_OverRide_Batt_Isolation2OnOffStatus','editSampleTime','0.001','Position', [20 2225 70 2255]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Isolation2OnOffStatus/1', 'En_OverRide_Batt_Isolation2OnOffStatus_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion37']);
CovertPortHandles = get_param( [gcs '/SignalConvertion37'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(37), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Isolation2OnOffStatus']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Isolation2OnOffStatus'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Isolation2OnOffStatus/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '29');
En_OverRide_Batt_Isolation2OnOffStatusHandle = add_line(gcs,'AND_En_OverRide_Batt_Isolation2OnOffStatus/1','xC9_BMS_HV_01_Status_2/29','autorouting','on');
set_param(En_OverRide_Batt_Isolation2OnOffStatusHandle, 'Name', 'En_OverRide_Batt_Isolation2OnOffStatus');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Isolation2OnOffStatus_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Isolation2OnOffStatus'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Isolation2OnOffStatus::Val_OverRide_Batt_Isolation2OnOffStatus','editSampleTime','0.001','Position', [20 2285 70 2315]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Isolation2OnOffStatus/1', 'Val_OverRide_Batt_Isolation2OnOffStatus_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion38']);
CovertPortHandles = get_param( [gcs '/SignalConvertion38'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(38), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '30');
lineHandle = add_line(gcs,'SignalConvertion38/1','xC9_BMS_HV_01_Status_2/30','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Isolation2OnOffStatus');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Isolation2Status_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Isolation2Status'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Isolation2Status::En_OverRide_Batt_Isolation2Status','editSampleTime','0.001','Position', [20 2345 70 2375]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Isolation2Status/1', 'En_OverRide_Batt_Isolation2Status_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion39']);
CovertPortHandles = get_param( [gcs '/SignalConvertion39'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(39), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Isolation2Status']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Isolation2Status'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Isolation2Status/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '31');
En_OverRide_Batt_Isolation2StatusHandle = add_line(gcs,'AND_En_OverRide_Batt_Isolation2Status/1','xC9_BMS_HV_01_Status_2/31','autorouting','on');
set_param(En_OverRide_Batt_Isolation2StatusHandle, 'Name', 'En_OverRide_Batt_Isolation2Status');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Isolation2Status_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Isolation2Status'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_Isolation2Status::Val_OverRide_Batt_Isolation2Status','editSampleTime','0.001','Position', [20 2405 70 2435]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Isolation2Status/1', 'Val_OverRide_Batt_Isolation2Status_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion40']);
CovertPortHandles = get_param( [gcs '/SignalConvertion40'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(40), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '32');
lineHandle = add_line(gcs,'SignalConvertion40/1','xC9_BMS_HV_01_Status_2/32','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Isolation2Status');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_MinSOC_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_MinSOC'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_MinSOC::En_OverRide_Batt_MinSOC','editSampleTime','0.001','Position', [20 2465 70 2495]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_MinSOC/1', 'En_OverRide_Batt_MinSOC_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion41']);
CovertPortHandles = get_param( [gcs '/SignalConvertion41'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(41), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_MinSOC']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_MinSOC'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_MinSOC/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '33');
En_OverRide_Batt_MinSOCHandle = add_line(gcs,'AND_En_OverRide_Batt_MinSOC/1','xC9_BMS_HV_01_Status_2/33','autorouting','on');
set_param(En_OverRide_Batt_MinSOCHandle, 'Name', 'En_OverRide_Batt_MinSOC');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_MinSOC_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_MinSOC'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_MinSOC::Val_OverRide_Batt_MinSOC','editSampleTime','0.001','Position', [20 2525 70 2555]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_MinSOC/1', 'Val_OverRide_Batt_MinSOC_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion42']);
CovertPortHandles = get_param( [gcs '/SignalConvertion42'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(42), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '34');
lineHandle = add_line(gcs,'SignalConvertion42/1','xC9_BMS_HV_01_Status_2/34','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_MinSOC');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_ReadytoTurnOnHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_ReadytoTurnOnHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_ReadytoTurnOnHV::En_OverRide_Batt_ReadytoTurnOnHV','editSampleTime','0.001','Position', [20 2585 70 2615]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_ReadytoTurnOnHV/1', 'En_OverRide_Batt_ReadytoTurnOnHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion43']);
CovertPortHandles = get_param( [gcs '/SignalConvertion43'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(43), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_ReadytoTurnOnHV']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_ReadytoTurnOnHV'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_ReadytoTurnOnHV/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '35');
En_OverRide_Batt_ReadytoTurnOnHVHandle = add_line(gcs,'AND_En_OverRide_Batt_ReadytoTurnOnHV/1','xC9_BMS_HV_01_Status_2/35','autorouting','on');
set_param(En_OverRide_Batt_ReadytoTurnOnHVHandle, 'Name', 'En_OverRide_Batt_ReadytoTurnOnHV');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_ReadytoTurnOnHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_ReadytoTurnOnHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_ReadytoTurnOnHV::Val_OverRide_Batt_ReadytoTurnOnHV','editSampleTime','0.001','Position', [20 2645 70 2675]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_ReadytoTurnOnHV/1', 'Val_OverRide_Batt_ReadytoTurnOnHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion44']);
CovertPortHandles = get_param( [gcs '/SignalConvertion44'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(44), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '36');
lineHandle = add_line(gcs,'SignalConvertion44/1','xC9_BMS_HV_01_Status_2/36','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_ReadytoTurnOnHV');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_UserSOC_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_UserSOC'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_UserSOC::En_OverRide_Batt_UserSOC','editSampleTime','0.001','Position', [20 2705 70 2735]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_UserSOC/1', 'En_OverRide_Batt_UserSOC_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion45']);
CovertPortHandles = get_param( [gcs '/SignalConvertion45'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(45), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_UserSOC']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_UserSOC'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_UserSOC/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '37');
En_OverRide_Batt_UserSOCHandle = add_line(gcs,'AND_En_OverRide_Batt_UserSOC/1','xC9_BMS_HV_01_Status_2/37','autorouting','on');
set_param(En_OverRide_Batt_UserSOCHandle, 'Name', 'En_OverRide_Batt_UserSOC');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_UserSOC_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_UserSOC'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::Batt_UserSOC::Val_OverRide_Batt_UserSOC','editSampleTime','0.001','Position', [20 2765 70 2795]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_UserSOC/1', 'Val_OverRide_Batt_UserSOC_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion46']);
CovertPortHandles = get_param( [gcs '/SignalConvertion46'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(46), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '38');
lineHandle = add_line(gcs,'SignalConvertion46/1','xC9_BMS_HV_01_Status_2/38','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_UserSOC');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_BMS_AliveCounter1_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_BMS_AliveCounter1'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::BMS_AliveCounter1::En_OverRide_BMS_AliveCounter1','editSampleTime','0.001','Position', [20 2825 70 2855]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_BMS_AliveCounter1/1', 'En_OverRide_BMS_AliveCounter1_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion47']);
CovertPortHandles = get_param( [gcs '/SignalConvertion47'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(47), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BMS_AliveCounter1']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BMS_AliveCounter1'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BMS_AliveCounter1/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '39');
En_OverRide_BMS_AliveCounter1Handle = add_line(gcs,'AND_En_OverRide_BMS_AliveCounter1/1','xC9_BMS_HV_01_Status_2/39','autorouting','on');
set_param(En_OverRide_BMS_AliveCounter1Handle, 'Name', 'En_OverRide_BMS_AliveCounter1');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_BMS_AliveCounter1_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_BMS_AliveCounter1'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xC9_BMS_HV_01_Status::BMS_AliveCounter1::Val_OverRide_BMS_AliveCounter1','editSampleTime','0.001','Position', [20 2885 70 2915]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_BMS_AliveCounter1/1', 'Val_OverRide_BMS_AliveCounter1_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion48']);
CovertPortHandles = get_param( [gcs '/SignalConvertion48'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(48), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xC9_BMS_HV_01_Status_2'], 'Inputs', '40');
lineHandle = add_line(gcs,'SignalConvertion48/1','xC9_BMS_HV_01_Status_2/40','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BMS_AliveCounter1');



set_param([gcs,'/BMS'], 'Inputs', '2')
lineHandle = add_line(gcs,'xC9_BMS_HV_01_Status_2/1','BMS/2','autorouting','on')
set_param(lineHandle, 'Name', 'xC9_BMS_HV_01_Status');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/xD2_BMS_HV_08_3']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_BoostChargeActive_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_BoostChargeActive'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xD2_BMS_HV_08::Batt_BoostChargeActive::En_OverRide_Batt_BoostChargeActive','editSampleTime','0.001','Position', [20 2945 70 2975]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_BoostChargeActive/1', 'En_OverRide_Batt_BoostChargeActive_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion49']);
CovertPortHandles = get_param( [gcs '/SignalConvertion49'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(49), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_BoostChargeActive']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_BoostChargeActive'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_BoostChargeActive/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xD2_BMS_HV_08_3'], 'Inputs', '1');
En_OverRide_Batt_BoostChargeActiveHandle = add_line(gcs,'AND_En_OverRide_Batt_BoostChargeActive/1','xD2_BMS_HV_08_3/1','autorouting','on');
set_param(En_OverRide_Batt_BoostChargeActiveHandle, 'Name', 'En_OverRide_Batt_BoostChargeActive');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_BoostChargeActive_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_BoostChargeActive'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xD2_BMS_HV_08::Batt_BoostChargeActive::Val_OverRide_Batt_BoostChargeActive','editSampleTime','0.001','Position', [20 3005 70 3035]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_BoostChargeActive/1', 'Val_OverRide_Batt_BoostChargeActive_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion50']);
CovertPortHandles = get_param( [gcs '/SignalConvertion50'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(50), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xD2_BMS_HV_08_3'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion50/1','xD2_BMS_HV_08_3/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_BoostChargeActive');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_DischEnergyThroughput_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_DischEnergyThroughput'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xD2_BMS_HV_08::Batt_DischEnergyThroughput::En_OverRide_Batt_DischEnergyThroughput','editSampleTime','0.001','Position', [20 3065 70 3095]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_DischEnergyThroughput/1', 'En_OverRide_Batt_DischEnergyThroughput_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion51']);
CovertPortHandles = get_param( [gcs '/SignalConvertion51'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(51), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_DischEnergyThroughput']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_DischEnergyThroughput'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_DischEnergyThroughput/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xD2_BMS_HV_08_3'], 'Inputs', '3');
En_OverRide_Batt_DischEnergyThroughputHandle = add_line(gcs,'AND_En_OverRide_Batt_DischEnergyThroughput/1','xD2_BMS_HV_08_3/3','autorouting','on');
set_param(En_OverRide_Batt_DischEnergyThroughputHandle, 'Name', 'En_OverRide_Batt_DischEnergyThroughput');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_DischEnergyThroughput_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_DischEnergyThroughput'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xD2_BMS_HV_08::Batt_DischEnergyThroughput::Val_OverRide_Batt_DischEnergyThroughput','editSampleTime','0.001','Position', [20 3125 70 3155]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_DischEnergyThroughput/1', 'Val_OverRide_Batt_DischEnergyThroughput_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion52']);
CovertPortHandles = get_param( [gcs '/SignalConvertion52'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(52), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xD2_BMS_HV_08_3'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion52/1','xD2_BMS_HV_08_3/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_DischEnergyThroughput');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_ReadyforBoostCharge_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_ReadyforBoostCharge'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xD2_BMS_HV_08::Batt_ReadyforBoostCharge::En_OverRide_Batt_ReadyforBoostCharge','editSampleTime','0.001','Position', [20 3185 70 3215]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_ReadyforBoostCharge/1', 'En_OverRide_Batt_ReadyforBoostCharge_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion53']);
CovertPortHandles = get_param( [gcs '/SignalConvertion53'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(53), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_ReadyforBoostCharge']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_ReadyforBoostCharge'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_ReadyforBoostCharge/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xD2_BMS_HV_08_3'], 'Inputs', '5');
En_OverRide_Batt_ReadyforBoostChargeHandle = add_line(gcs,'AND_En_OverRide_Batt_ReadyforBoostCharge/1','xD2_BMS_HV_08_3/5','autorouting','on');
set_param(En_OverRide_Batt_ReadyforBoostChargeHandle, 'Name', 'En_OverRide_Batt_ReadyforBoostCharge');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_ReadyforBoostCharge_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_ReadyforBoostCharge'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xD2_BMS_HV_08::Batt_ReadyforBoostCharge::Val_OverRide_Batt_ReadyforBoostCharge','editSampleTime','0.001','Position', [20 3245 70 3275]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_ReadyforBoostCharge/1', 'Val_OverRide_Batt_ReadyforBoostCharge_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion54']);
CovertPortHandles = get_param( [gcs '/SignalConvertion54'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(54), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xD2_BMS_HV_08_3'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion54/1','xD2_BMS_HV_08_3/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_ReadyforBoostCharge');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_SafetyLightStatGreenHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_SafetyLightStatGreenHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xD2_BMS_HV_08::Batt_SafetyLightStatGreenHV::En_OverRide_Batt_SafetyLightStatGreenHV','editSampleTime','0.001','Position', [20 3305 70 3335]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_SafetyLightStatGreenHV/1', 'En_OverRide_Batt_SafetyLightStatGreenHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion55']);
CovertPortHandles = get_param( [gcs '/SignalConvertion55'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(55), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_SafetyLightStatGreenHV']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_SafetyLightStatGreenHV'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_SafetyLightStatGreenHV/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xD2_BMS_HV_08_3'], 'Inputs', '7');
En_OverRide_Batt_SafetyLightStatGreenHVHandle = add_line(gcs,'AND_En_OverRide_Batt_SafetyLightStatGreenHV/1','xD2_BMS_HV_08_3/7','autorouting','on');
set_param(En_OverRide_Batt_SafetyLightStatGreenHVHandle, 'Name', 'En_OverRide_Batt_SafetyLightStatGreenHV');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_SafetyLightStatGreenHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_SafetyLightStatGreenHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xD2_BMS_HV_08::Batt_SafetyLightStatGreenHV::Val_OverRide_Batt_SafetyLightStatGreenHV','editSampleTime','0.001','Position', [20 3365 70 3395]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_SafetyLightStatGreenHV/1', 'Val_OverRide_Batt_SafetyLightStatGreenHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion56']);
CovertPortHandles = get_param( [gcs '/SignalConvertion56'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(56), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xD2_BMS_HV_08_3'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion56/1','xD2_BMS_HV_08_3/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_SafetyLightStatGreenHV');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_SafetyLightStatRedHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_SafetyLightStatRedHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xD2_BMS_HV_08::Batt_SafetyLightStatRedHV::En_OverRide_Batt_SafetyLightStatRedHV','editSampleTime','0.001','Position', [20 3425 70 3455]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_SafetyLightStatRedHV/1', 'En_OverRide_Batt_SafetyLightStatRedHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion57']);
CovertPortHandles = get_param( [gcs '/SignalConvertion57'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(57), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_SafetyLightStatRedHV']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_SafetyLightStatRedHV'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_SafetyLightStatRedHV/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xD2_BMS_HV_08_3'], 'Inputs', '9');
En_OverRide_Batt_SafetyLightStatRedHVHandle = add_line(gcs,'AND_En_OverRide_Batt_SafetyLightStatRedHV/1','xD2_BMS_HV_08_3/9','autorouting','on');
set_param(En_OverRide_Batt_SafetyLightStatRedHVHandle, 'Name', 'En_OverRide_Batt_SafetyLightStatRedHV');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_SafetyLightStatRedHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_SafetyLightStatRedHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xD2_BMS_HV_08::Batt_SafetyLightStatRedHV::Val_OverRide_Batt_SafetyLightStatRedHV','editSampleTime','0.001','Position', [20 3485 70 3515]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_SafetyLightStatRedHV/1', 'Val_OverRide_Batt_SafetyLightStatRedHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion58']);
CovertPortHandles = get_param( [gcs '/SignalConvertion58'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(58), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xD2_BMS_HV_08_3'], 'Inputs', '10');
lineHandle = add_line(gcs,'SignalConvertion58/1','xD2_BMS_HV_08_3/10','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_SafetyLightStatRedHV');



set_param([gcs,'/BMS'], 'Inputs', '3')
lineHandle = add_line(gcs,'xD2_BMS_HV_08_3/1','BMS/3','autorouting','on')
set_param(lineHandle, 'Name', 'xD2_BMS_HV_08');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/x110_BMS_HV_09_4']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_ClearFault_Code_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_ClearFault_Code'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x110_BMS_HV_09::Batt_ClearFault_Code::En_OverRide_Batt_ClearFault_Code','editSampleTime','0.001','Position', [20 3545 70 3575]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_ClearFault_Code/1', 'En_OverRide_Batt_ClearFault_Code_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion59']);
CovertPortHandles = get_param( [gcs '/SignalConvertion59'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(59), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_ClearFault_Code']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_ClearFault_Code'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_ClearFault_Code/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x110_BMS_HV_09_4'], 'Inputs', '1');
En_OverRide_Batt_ClearFault_CodeHandle = add_line(gcs,'AND_En_OverRide_Batt_ClearFault_Code/1','x110_BMS_HV_09_4/1','autorouting','on');
set_param(En_OverRide_Batt_ClearFault_CodeHandle, 'Name', 'En_OverRide_Batt_ClearFault_Code');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_ClearFault_Code_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_ClearFault_Code'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x110_BMS_HV_09::Batt_ClearFault_Code::Val_OverRide_Batt_ClearFault_Code','editSampleTime','0.001','Position', [20 3605 70 3635]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_ClearFault_Code/1', 'Val_OverRide_Batt_ClearFault_Code_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion60']);
CovertPortHandles = get_param( [gcs '/SignalConvertion60'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(60), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x110_BMS_HV_09_4'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion60/1','x110_BMS_HV_09_4/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_ClearFault_Code');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_ClearFault_KeyMatched_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_ClearFault_KeyMatched'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x110_BMS_HV_09::Batt_ClearFault_KeyMatched::En_OverRide_Batt_ClearFault_KeyMatched','editSampleTime','0.001','Position', [20 3665 70 3695]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_ClearFault_KeyMatched/1', 'En_OverRide_Batt_ClearFault_KeyMatched_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion61']);
CovertPortHandles = get_param( [gcs '/SignalConvertion61'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(61), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_ClearFault_KeyMatched']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_ClearFault_KeyMatched'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_ClearFault_KeyMatched/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x110_BMS_HV_09_4'], 'Inputs', '3');
En_OverRide_Batt_ClearFault_KeyMatchedHandle = add_line(gcs,'AND_En_OverRide_Batt_ClearFault_KeyMatched/1','x110_BMS_HV_09_4/3','autorouting','on');
set_param(En_OverRide_Batt_ClearFault_KeyMatchedHandle, 'Name', 'En_OverRide_Batt_ClearFault_KeyMatched');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_ClearFault_KeyMatched_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_ClearFault_KeyMatched'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x110_BMS_HV_09::Batt_ClearFault_KeyMatched::Val_OverRide_Batt_ClearFault_KeyMatched','editSampleTime','0.001','Position', [20 3725 70 3755]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_ClearFault_KeyMatched/1', 'Val_OverRide_Batt_ClearFault_KeyMatched_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion62']);
CovertPortHandles = get_param( [gcs '/SignalConvertion62'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(62), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x110_BMS_HV_09_4'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion62/1','x110_BMS_HV_09_4/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_ClearFault_KeyMatched');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_FaultActive_FR4_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_FaultActive_FR4'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x110_BMS_HV_09::Batt_FaultActive_FR4::En_OverRide_Batt_FaultActive_FR4','editSampleTime','0.001','Position', [20 3785 70 3815]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_FaultActive_FR4/1', 'En_OverRide_Batt_FaultActive_FR4_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion63']);
CovertPortHandles = get_param( [gcs '/SignalConvertion63'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(63), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_FaultActive_FR4']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_FaultActive_FR4'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_FaultActive_FR4/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x110_BMS_HV_09_4'], 'Inputs', '5');
En_OverRide_Batt_FaultActive_FR4Handle = add_line(gcs,'AND_En_OverRide_Batt_FaultActive_FR4/1','x110_BMS_HV_09_4/5','autorouting','on');
set_param(En_OverRide_Batt_FaultActive_FR4Handle, 'Name', 'En_OverRide_Batt_FaultActive_FR4');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_FaultActive_FR4_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_FaultActive_FR4'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x110_BMS_HV_09::Batt_FaultActive_FR4::Val_OverRide_Batt_FaultActive_FR4','editSampleTime','0.001','Position', [20 3845 70 3875]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_FaultActive_FR4/1', 'Val_OverRide_Batt_FaultActive_FR4_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion64']);
CovertPortHandles = get_param( [gcs '/SignalConvertion64'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(64), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x110_BMS_HV_09_4'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion64/1','x110_BMS_HV_09_4/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_FaultActive_FR4');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_LoggerPercent_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_LoggerPercent'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x110_BMS_HV_09::Batt_LoggerPercent::En_OverRide_Batt_LoggerPercent','editSampleTime','0.001','Position', [20 3905 70 3935]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_LoggerPercent/1', 'En_OverRide_Batt_LoggerPercent_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion65']);
CovertPortHandles = get_param( [gcs '/SignalConvertion65'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(65), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_LoggerPercent']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_LoggerPercent'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_LoggerPercent/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x110_BMS_HV_09_4'], 'Inputs', '7');
En_OverRide_Batt_LoggerPercentHandle = add_line(gcs,'AND_En_OverRide_Batt_LoggerPercent/1','x110_BMS_HV_09_4/7','autorouting','on');
set_param(En_OverRide_Batt_LoggerPercentHandle, 'Name', 'En_OverRide_Batt_LoggerPercent');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_LoggerPercent_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_LoggerPercent'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x110_BMS_HV_09::Batt_LoggerPercent::Val_OverRide_Batt_LoggerPercent','editSampleTime','0.001','Position', [20 3965 70 3995]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_LoggerPercent/1', 'Val_OverRide_Batt_LoggerPercent_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion66']);
CovertPortHandles = get_param( [gcs '/SignalConvertion66'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(66), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x110_BMS_HV_09_4'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion66/1','x110_BMS_HV_09_4/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_LoggerPercent');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_MaxSOC_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_MaxSOC'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x110_BMS_HV_09::Batt_MaxSOC::En_OverRide_Batt_MaxSOC','editSampleTime','0.001','Position', [20 4025 70 4055]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_MaxSOC/1', 'En_OverRide_Batt_MaxSOC_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion67']);
CovertPortHandles = get_param( [gcs '/SignalConvertion67'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(67), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_MaxSOC']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_MaxSOC'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_MaxSOC/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x110_BMS_HV_09_4'], 'Inputs', '9');
En_OverRide_Batt_MaxSOCHandle = add_line(gcs,'AND_En_OverRide_Batt_MaxSOC/1','x110_BMS_HV_09_4/9','autorouting','on');
set_param(En_OverRide_Batt_MaxSOCHandle, 'Name', 'En_OverRide_Batt_MaxSOC');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_MaxSOC_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_MaxSOC'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x110_BMS_HV_09::Batt_MaxSOC::Val_OverRide_Batt_MaxSOC','editSampleTime','0.001','Position', [20 4085 70 4115]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_MaxSOC/1', 'Val_OverRide_Batt_MaxSOC_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion68']);
CovertPortHandles = get_param( [gcs '/SignalConvertion68'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(68), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x110_BMS_HV_09_4'], 'Inputs', '10');
lineHandle = add_line(gcs,'SignalConvertion68/1','x110_BMS_HV_09_4/10','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_MaxSOC');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_BMS_LoggingFull_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_BMS_LoggingFull'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x110_BMS_HV_09::BMS_LoggingFull::En_OverRide_BMS_LoggingFull','editSampleTime','0.001','Position', [20 4145 70 4175]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_BMS_LoggingFull/1', 'En_OverRide_BMS_LoggingFull_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion69']);
CovertPortHandles = get_param( [gcs '/SignalConvertion69'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(69), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BMS_LoggingFull']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BMS_LoggingFull'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BMS_LoggingFull/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x110_BMS_HV_09_4'], 'Inputs', '11');
En_OverRide_BMS_LoggingFullHandle = add_line(gcs,'AND_En_OverRide_BMS_LoggingFull/1','x110_BMS_HV_09_4/11','autorouting','on');
set_param(En_OverRide_BMS_LoggingFullHandle, 'Name', 'En_OverRide_BMS_LoggingFull');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_BMS_LoggingFull_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_BMS_LoggingFull'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x110_BMS_HV_09::BMS_LoggingFull::Val_OverRide_BMS_LoggingFull','editSampleTime','0.001','Position', [20 4205 70 4235]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_BMS_LoggingFull/1', 'Val_OverRide_BMS_LoggingFull_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion70']);
CovertPortHandles = get_param( [gcs '/SignalConvertion70'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(70), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x110_BMS_HV_09_4'], 'Inputs', '12');
lineHandle = add_line(gcs,'SignalConvertion70/1','x110_BMS_HV_09_4/12','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BMS_LoggingFull');



set_param([gcs,'/BMS'], 'Inputs', '4')
lineHandle = add_line(gcs,'x110_BMS_HV_09_4/1','BMS/4','autorouting','on')
set_param(lineHandle, 'Name', 'x110_BMS_HV_09');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/xCF_BMS_HV_07_Thermal_5']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Coolant_IN_Pressure_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Coolant_IN_Pressure'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCF_BMS_HV_07_Thermal::Batt_Coolant_IN_Pressure::En_OverRide_Batt_Coolant_IN_Pressure','editSampleTime','0.001','Position', [20 4265 70 4295]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Coolant_IN_Pressure/1', 'En_OverRide_Batt_Coolant_IN_Pressure_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion71']);
CovertPortHandles = get_param( [gcs '/SignalConvertion71'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(71), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Coolant_IN_Pressure']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Coolant_IN_Pressure'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Coolant_IN_Pressure/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCF_BMS_HV_07_Thermal_5'], 'Inputs', '1');
En_OverRide_Batt_Coolant_IN_PressureHandle = add_line(gcs,'AND_En_OverRide_Batt_Coolant_IN_Pressure/1','xCF_BMS_HV_07_Thermal_5/1','autorouting','on');
set_param(En_OverRide_Batt_Coolant_IN_PressureHandle, 'Name', 'En_OverRide_Batt_Coolant_IN_Pressure');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Coolant_IN_Pressure_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Coolant_IN_Pressure'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCF_BMS_HV_07_Thermal::Batt_Coolant_IN_Pressure::Val_OverRide_Batt_Coolant_IN_Pressure','editSampleTime','0.001','Position', [20 4325 70 4355]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Coolant_IN_Pressure/1', 'Val_OverRide_Batt_Coolant_IN_Pressure_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion72']);
CovertPortHandles = get_param( [gcs '/SignalConvertion72'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(72), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCF_BMS_HV_07_Thermal_5'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion72/1','xCF_BMS_HV_07_Thermal_5/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Coolant_IN_Pressure');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Coolant_IN_Temp_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Coolant_IN_Temp'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCF_BMS_HV_07_Thermal::Batt_Coolant_IN_Temp::En_OverRide_Batt_Coolant_IN_Temp','editSampleTime','0.001','Position', [20 4385 70 4415]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Coolant_IN_Temp/1', 'En_OverRide_Batt_Coolant_IN_Temp_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion73']);
CovertPortHandles = get_param( [gcs '/SignalConvertion73'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(73), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Coolant_IN_Temp']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Coolant_IN_Temp'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Coolant_IN_Temp/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCF_BMS_HV_07_Thermal_5'], 'Inputs', '3');
En_OverRide_Batt_Coolant_IN_TempHandle = add_line(gcs,'AND_En_OverRide_Batt_Coolant_IN_Temp/1','xCF_BMS_HV_07_Thermal_5/3','autorouting','on');
set_param(En_OverRide_Batt_Coolant_IN_TempHandle, 'Name', 'En_OverRide_Batt_Coolant_IN_Temp');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Coolant_IN_Temp_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Coolant_IN_Temp'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCF_BMS_HV_07_Thermal::Batt_Coolant_IN_Temp::Val_OverRide_Batt_Coolant_IN_Temp','editSampleTime','0.001','Position', [20 4445 70 4475]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Coolant_IN_Temp/1', 'Val_OverRide_Batt_Coolant_IN_Temp_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion74']);
CovertPortHandles = get_param( [gcs '/SignalConvertion74'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(74), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCF_BMS_HV_07_Thermal_5'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion74/1','xCF_BMS_HV_07_Thermal_5/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Coolant_IN_Temp');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Coolant_OUT_Pressure_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Coolant_OUT_Pressure'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCF_BMS_HV_07_Thermal::Batt_Coolant_OUT_Pressure::En_OverRide_Batt_Coolant_OUT_Pressure','editSampleTime','0.001','Position', [20 4505 70 4535]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Coolant_OUT_Pressure/1', 'En_OverRide_Batt_Coolant_OUT_Pressure_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion75']);
CovertPortHandles = get_param( [gcs '/SignalConvertion75'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(75), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Coolant_OUT_Pressure']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Coolant_OUT_Pressure'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Coolant_OUT_Pressure/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCF_BMS_HV_07_Thermal_5'], 'Inputs', '5');
En_OverRide_Batt_Coolant_OUT_PressureHandle = add_line(gcs,'AND_En_OverRide_Batt_Coolant_OUT_Pressure/1','xCF_BMS_HV_07_Thermal_5/5','autorouting','on');
set_param(En_OverRide_Batt_Coolant_OUT_PressureHandle, 'Name', 'En_OverRide_Batt_Coolant_OUT_Pressure');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Coolant_OUT_Pressure_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Coolant_OUT_Pressure'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCF_BMS_HV_07_Thermal::Batt_Coolant_OUT_Pressure::Val_OverRide_Batt_Coolant_OUT_Pressure','editSampleTime','0.001','Position', [20 4565 70 4595]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Coolant_OUT_Pressure/1', 'Val_OverRide_Batt_Coolant_OUT_Pressure_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion76']);
CovertPortHandles = get_param( [gcs '/SignalConvertion76'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(76), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCF_BMS_HV_07_Thermal_5'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion76/1','xCF_BMS_HV_07_Thermal_5/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Coolant_OUT_Pressure');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Coolant_OUT_Temp_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Coolant_OUT_Temp'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCF_BMS_HV_07_Thermal::Batt_Coolant_OUT_Temp::En_OverRide_Batt_Coolant_OUT_Temp','editSampleTime','0.001','Position', [20 4625 70 4655]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Coolant_OUT_Temp/1', 'En_OverRide_Batt_Coolant_OUT_Temp_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion77']);
CovertPortHandles = get_param( [gcs '/SignalConvertion77'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(77), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Coolant_OUT_Temp']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Coolant_OUT_Temp'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Coolant_OUT_Temp/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCF_BMS_HV_07_Thermal_5'], 'Inputs', '7');
En_OverRide_Batt_Coolant_OUT_TempHandle = add_line(gcs,'AND_En_OverRide_Batt_Coolant_OUT_Temp/1','xCF_BMS_HV_07_Thermal_5/7','autorouting','on');
set_param(En_OverRide_Batt_Coolant_OUT_TempHandle, 'Name', 'En_OverRide_Batt_Coolant_OUT_Temp');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Coolant_OUT_Temp_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Coolant_OUT_Temp'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCF_BMS_HV_07_Thermal::Batt_Coolant_OUT_Temp::Val_OverRide_Batt_Coolant_OUT_Temp','editSampleTime','0.001','Position', [20 4685 70 4715]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Coolant_OUT_Temp/1', 'Val_OverRide_Batt_Coolant_OUT_Temp_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion78']);
CovertPortHandles = get_param( [gcs '/SignalConvertion78'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(78), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCF_BMS_HV_07_Thermal_5'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion78/1','xCF_BMS_HV_07_Thermal_5/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Coolant_OUT_Temp');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_LVBackupBattVoltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_LVBackupBattVoltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCF_BMS_HV_07_Thermal::Batt_LVBackupBattVoltage::En_OverRide_Batt_LVBackupBattVoltage','editSampleTime','0.001','Position', [20 4745 70 4775]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_LVBackupBattVoltage/1', 'En_OverRide_Batt_LVBackupBattVoltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion79']);
CovertPortHandles = get_param( [gcs '/SignalConvertion79'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(79), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_LVBackupBattVoltage']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_LVBackupBattVoltage'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_LVBackupBattVoltage/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCF_BMS_HV_07_Thermal_5'], 'Inputs', '9');
En_OverRide_Batt_LVBackupBattVoltageHandle = add_line(gcs,'AND_En_OverRide_Batt_LVBackupBattVoltage/1','xCF_BMS_HV_07_Thermal_5/9','autorouting','on');
set_param(En_OverRide_Batt_LVBackupBattVoltageHandle, 'Name', 'En_OverRide_Batt_LVBackupBattVoltage');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_LVBackupBattVoltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_LVBackupBattVoltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCF_BMS_HV_07_Thermal::Batt_LVBackupBattVoltage::Val_OverRide_Batt_LVBackupBattVoltage','editSampleTime','0.001','Position', [20 4805 70 4835]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_LVBackupBattVoltage/1', 'Val_OverRide_Batt_LVBackupBattVoltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion80']);
CovertPortHandles = get_param( [gcs '/SignalConvertion80'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(80), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCF_BMS_HV_07_Thermal_5'], 'Inputs', '10');
lineHandle = add_line(gcs,'SignalConvertion80/1','xCF_BMS_HV_07_Thermal_5/10','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_LVBackupBattVoltage');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_ThermalRequest_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_ThermalRequest'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCF_BMS_HV_07_Thermal::Batt_ThermalRequest::En_OverRide_Batt_ThermalRequest','editSampleTime','0.001','Position', [20 4865 70 4895]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_ThermalRequest/1', 'En_OverRide_Batt_ThermalRequest_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion81']);
CovertPortHandles = get_param( [gcs '/SignalConvertion81'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(81), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_ThermalRequest']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_ThermalRequest'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_ThermalRequest/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCF_BMS_HV_07_Thermal_5'], 'Inputs', '11');
En_OverRide_Batt_ThermalRequestHandle = add_line(gcs,'AND_En_OverRide_Batt_ThermalRequest/1','xCF_BMS_HV_07_Thermal_5/11','autorouting','on');
set_param(En_OverRide_Batt_ThermalRequestHandle, 'Name', 'En_OverRide_Batt_ThermalRequest');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_ThermalRequest_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_ThermalRequest'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCF_BMS_HV_07_Thermal::Batt_ThermalRequest::Val_OverRide_Batt_ThermalRequest','editSampleTime','0.001','Position', [20 4925 70 4955]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_ThermalRequest/1', 'Val_OverRide_Batt_ThermalRequest_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion82']);
CovertPortHandles = get_param( [gcs '/SignalConvertion82'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(82), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCF_BMS_HV_07_Thermal_5'], 'Inputs', '12');
lineHandle = add_line(gcs,'SignalConvertion82/1','xCF_BMS_HV_07_Thermal_5/12','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_ThermalRequest');



set_param([gcs,'/BMS'], 'Inputs', '5')
lineHandle = add_line(gcs,'xCF_BMS_HV_07_Thermal_5/1','BMS/5','autorouting','on')
set_param(lineHandle, 'Name', 'xCF_BMS_HV_07_Thermal');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/xCA_BMS_HV_02_HVParameter_6']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Current_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Current'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCA_BMS_HV_02_HVParameter::Batt_Current::En_OverRide_Batt_Current','editSampleTime','0.001','Position', [20 4985 70 5015]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Current/1', 'En_OverRide_Batt_Current_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion83']);
CovertPortHandles = get_param( [gcs '/SignalConvertion83'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(83), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Current']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Current'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Current/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCA_BMS_HV_02_HVParameter_6'], 'Inputs', '1');
En_OverRide_Batt_CurrentHandle = add_line(gcs,'AND_En_OverRide_Batt_Current/1','xCA_BMS_HV_02_HVParameter_6/1','autorouting','on');
set_param(En_OverRide_Batt_CurrentHandle, 'Name', 'En_OverRide_Batt_Current');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Current_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Current'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCA_BMS_HV_02_HVParameter::Batt_Current::Val_OverRide_Batt_Current','editSampleTime','0.001','Position', [20 5045 70 5075]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Current/1', 'Val_OverRide_Batt_Current_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion84']);
CovertPortHandles = get_param( [gcs '/SignalConvertion84'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(84), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCA_BMS_HV_02_HVParameter_6'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion84/1','xCA_BMS_HV_02_HVParameter_6/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Current');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Voltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Voltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCA_BMS_HV_02_HVParameter::Batt_Voltage::En_OverRide_Batt_Voltage','editSampleTime','0.001','Position', [20 5105 70 5135]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Voltage/1', 'En_OverRide_Batt_Voltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion85']);
CovertPortHandles = get_param( [gcs '/SignalConvertion85'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(85), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Voltage']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Voltage'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Voltage/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCA_BMS_HV_02_HVParameter_6'], 'Inputs', '3');
En_OverRide_Batt_VoltageHandle = add_line(gcs,'AND_En_OverRide_Batt_Voltage/1','xCA_BMS_HV_02_HVParameter_6/3','autorouting','on');
set_param(En_OverRide_Batt_VoltageHandle, 'Name', 'En_OverRide_Batt_Voltage');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Voltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Voltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCA_BMS_HV_02_HVParameter::Batt_Voltage::Val_OverRide_Batt_Voltage','editSampleTime','0.001','Position', [20 5165 70 5195]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Voltage/1', 'Val_OverRide_Batt_Voltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion86']);
CovertPortHandles = get_param( [gcs '/SignalConvertion86'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(86), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCA_BMS_HV_02_HVParameter_6'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion86/1','xCA_BMS_HV_02_HVParameter_6/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Voltage');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_BMS_AliveCounter2_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_BMS_AliveCounter2'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCA_BMS_HV_02_HVParameter::BMS_AliveCounter2::En_OverRide_BMS_AliveCounter2','editSampleTime','0.001','Position', [20 5225 70 5255]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_BMS_AliveCounter2/1', 'En_OverRide_BMS_AliveCounter2_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion87']);
CovertPortHandles = get_param( [gcs '/SignalConvertion87'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(87), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BMS_AliveCounter2']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BMS_AliveCounter2'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BMS_AliveCounter2/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCA_BMS_HV_02_HVParameter_6'], 'Inputs', '5');
En_OverRide_BMS_AliveCounter2Handle = add_line(gcs,'AND_En_OverRide_BMS_AliveCounter2/1','xCA_BMS_HV_02_HVParameter_6/5','autorouting','on');
set_param(En_OverRide_BMS_AliveCounter2Handle, 'Name', 'En_OverRide_BMS_AliveCounter2');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_BMS_AliveCounter2_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_BMS_AliveCounter2'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCA_BMS_HV_02_HVParameter::BMS_AliveCounter2::Val_OverRide_BMS_AliveCounter2','editSampleTime','0.001','Position', [20 5285 70 5315]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_BMS_AliveCounter2/1', 'Val_OverRide_BMS_AliveCounter2_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion88']);
CovertPortHandles = get_param( [gcs '/SignalConvertion88'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(88), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCA_BMS_HV_02_HVParameter_6'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion88/1','xCA_BMS_HV_02_HVParameter_6/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BMS_AliveCounter2');



set_param([gcs,'/BMS'], 'Inputs', '6')
lineHandle = add_line(gcs,'xCA_BMS_HV_02_HVParameter_6/1','BMS/6','autorouting','on')
set_param(lineHandle, 'Name', 'xCA_BMS_HV_02_HVParameter');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/xCB_BMS_HV_03_BatteryLimits_7']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_DischargePowerLim_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_DischargePowerLim'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCB_BMS_HV_03_BatteryLimits::Batt_DischargePowerLim::En_OverRide_Batt_DischargePowerLim','editSampleTime','0.001','Position', [20 5345 70 5375]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_DischargePowerLim/1', 'En_OverRide_Batt_DischargePowerLim_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion89']);
CovertPortHandles = get_param( [gcs '/SignalConvertion89'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(89), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_DischargePowerLim']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_DischargePowerLim'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_DischargePowerLim/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCB_BMS_HV_03_BatteryLimits_7'], 'Inputs', '1');
En_OverRide_Batt_DischargePowerLimHandle = add_line(gcs,'AND_En_OverRide_Batt_DischargePowerLim/1','xCB_BMS_HV_03_BatteryLimits_7/1','autorouting','on');
set_param(En_OverRide_Batt_DischargePowerLimHandle, 'Name', 'En_OverRide_Batt_DischargePowerLim');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_DischargePowerLim_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_DischargePowerLim'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCB_BMS_HV_03_BatteryLimits::Batt_DischargePowerLim::Val_OverRide_Batt_DischargePowerLim','editSampleTime','0.001','Position', [20 5405 70 5435]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_DischargePowerLim/1', 'Val_OverRide_Batt_DischargePowerLim_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion90']);
CovertPortHandles = get_param( [gcs '/SignalConvertion90'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(90), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCB_BMS_HV_03_BatteryLimits_7'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion90/1','xCB_BMS_HV_03_BatteryLimits_7/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_DischargePowerLim');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_RegenPowerLim_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_RegenPowerLim'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCB_BMS_HV_03_BatteryLimits::Batt_RegenPowerLim::En_OverRide_Batt_RegenPowerLim','editSampleTime','0.001','Position', [20 5465 70 5495]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_RegenPowerLim/1', 'En_OverRide_Batt_RegenPowerLim_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion91']);
CovertPortHandles = get_param( [gcs '/SignalConvertion91'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(91), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_RegenPowerLim']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_RegenPowerLim'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_RegenPowerLim/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCB_BMS_HV_03_BatteryLimits_7'], 'Inputs', '3');
En_OverRide_Batt_RegenPowerLimHandle = add_line(gcs,'AND_En_OverRide_Batt_RegenPowerLim/1','xCB_BMS_HV_03_BatteryLimits_7/3','autorouting','on');
set_param(En_OverRide_Batt_RegenPowerLimHandle, 'Name', 'En_OverRide_Batt_RegenPowerLim');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_RegenPowerLim_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_RegenPowerLim'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCB_BMS_HV_03_BatteryLimits::Batt_RegenPowerLim::Val_OverRide_Batt_RegenPowerLim','editSampleTime','0.001','Position', [20 5525 70 5555]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_RegenPowerLim/1', 'Val_OverRide_Batt_RegenPowerLim_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion92']);
CovertPortHandles = get_param( [gcs '/SignalConvertion92'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(92), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCB_BMS_HV_03_BatteryLimits_7'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion92/1','xCB_BMS_HV_03_BatteryLimits_7/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_RegenPowerLim');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_BMS_AliveCounter3_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_BMS_AliveCounter3'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCB_BMS_HV_03_BatteryLimits::BMS_AliveCounter3::En_OverRide_BMS_AliveCounter3','editSampleTime','0.001','Position', [20 5585 70 5615]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_BMS_AliveCounter3/1', 'En_OverRide_BMS_AliveCounter3_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion93']);
CovertPortHandles = get_param( [gcs '/SignalConvertion93'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(93), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BMS_AliveCounter3']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BMS_AliveCounter3'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BMS_AliveCounter3/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCB_BMS_HV_03_BatteryLimits_7'], 'Inputs', '5');
En_OverRide_BMS_AliveCounter3Handle = add_line(gcs,'AND_En_OverRide_BMS_AliveCounter3/1','xCB_BMS_HV_03_BatteryLimits_7/5','autorouting','on');
set_param(En_OverRide_BMS_AliveCounter3Handle, 'Name', 'En_OverRide_BMS_AliveCounter3');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_BMS_AliveCounter3_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_BMS_AliveCounter3'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCB_BMS_HV_03_BatteryLimits::BMS_AliveCounter3::Val_OverRide_BMS_AliveCounter3','editSampleTime','0.001','Position', [20 5645 70 5675]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_BMS_AliveCounter3/1', 'Val_OverRide_BMS_AliveCounter3_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion94']);
CovertPortHandles = get_param( [gcs '/SignalConvertion94'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(94), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCB_BMS_HV_03_BatteryLimits_7'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion94/1','xCB_BMS_HV_03_BatteryLimits_7/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BMS_AliveCounter3');



set_param([gcs,'/BMS'], 'Inputs', '7')
lineHandle = add_line(gcs,'xCB_BMS_HV_03_BatteryLimits_7/1','BMS/7','autorouting','on')
set_param(lineHandle, 'Name', 'xCB_BMS_HV_03_BatteryLimits');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/x109_BMS_HV_10_8']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_DischargePowerLim_2s_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_DischargePowerLim_2s'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x109_BMS_HV_10::Batt_DischargePowerLim_2s::En_OverRide_Batt_DischargePowerLim_2s','editSampleTime','0.001','Position', [20 5705 70 5735]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_DischargePowerLim_2s/1', 'En_OverRide_Batt_DischargePowerLim_2s_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion95']);
CovertPortHandles = get_param( [gcs '/SignalConvertion95'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(95), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_DischargePowerLim_2s']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_DischargePowerLim_2s'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_DischargePowerLim_2s/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x109_BMS_HV_10_8'], 'Inputs', '1');
En_OverRide_Batt_DischargePowerLim_2sHandle = add_line(gcs,'AND_En_OverRide_Batt_DischargePowerLim_2s/1','x109_BMS_HV_10_8/1','autorouting','on');
set_param(En_OverRide_Batt_DischargePowerLim_2sHandle, 'Name', 'En_OverRide_Batt_DischargePowerLim_2s');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_DischargePowerLim_2s_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_DischargePowerLim_2s'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x109_BMS_HV_10::Batt_DischargePowerLim_2s::Val_OverRide_Batt_DischargePowerLim_2s','editSampleTime','0.001','Position', [20 5765 70 5795]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_DischargePowerLim_2s/1', 'Val_OverRide_Batt_DischargePowerLim_2s_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion96']);
CovertPortHandles = get_param( [gcs '/SignalConvertion96'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(96), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x109_BMS_HV_10_8'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion96/1','x109_BMS_HV_10_8/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_DischargePowerLim_2s');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_DischargePowerLim_5s_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_DischargePowerLim_5s'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x109_BMS_HV_10::Batt_DischargePowerLim_5s::En_OverRide_Batt_DischargePowerLim_5s','editSampleTime','0.001','Position', [20 5825 70 5855]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_DischargePowerLim_5s/1', 'En_OverRide_Batt_DischargePowerLim_5s_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion97']);
CovertPortHandles = get_param( [gcs '/SignalConvertion97'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(97), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_DischargePowerLim_5s']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_DischargePowerLim_5s'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_DischargePowerLim_5s/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x109_BMS_HV_10_8'], 'Inputs', '3');
En_OverRide_Batt_DischargePowerLim_5sHandle = add_line(gcs,'AND_En_OverRide_Batt_DischargePowerLim_5s/1','x109_BMS_HV_10_8/3','autorouting','on');
set_param(En_OverRide_Batt_DischargePowerLim_5sHandle, 'Name', 'En_OverRide_Batt_DischargePowerLim_5s');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_DischargePowerLim_5s_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_DischargePowerLim_5s'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x109_BMS_HV_10::Batt_DischargePowerLim_5s::Val_OverRide_Batt_DischargePowerLim_5s','editSampleTime','0.001','Position', [20 5885 70 5915]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_DischargePowerLim_5s/1', 'Val_OverRide_Batt_DischargePowerLim_5s_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion98']);
CovertPortHandles = get_param( [gcs '/SignalConvertion98'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(98), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x109_BMS_HV_10_8'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion98/1','x109_BMS_HV_10_8/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_DischargePowerLim_5s');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_RegenPowerLim_2s_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_RegenPowerLim_2s'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x109_BMS_HV_10::Batt_RegenPowerLim_2s::En_OverRide_Batt_RegenPowerLim_2s','editSampleTime','0.001','Position', [20 5945 70 5975]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_RegenPowerLim_2s/1', 'En_OverRide_Batt_RegenPowerLim_2s_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion99']);
CovertPortHandles = get_param( [gcs '/SignalConvertion99'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(99), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_RegenPowerLim_2s']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_RegenPowerLim_2s'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_RegenPowerLim_2s/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x109_BMS_HV_10_8'], 'Inputs', '5');
En_OverRide_Batt_RegenPowerLim_2sHandle = add_line(gcs,'AND_En_OverRide_Batt_RegenPowerLim_2s/1','x109_BMS_HV_10_8/5','autorouting','on');
set_param(En_OverRide_Batt_RegenPowerLim_2sHandle, 'Name', 'En_OverRide_Batt_RegenPowerLim_2s');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_RegenPowerLim_2s_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_RegenPowerLim_2s'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x109_BMS_HV_10::Batt_RegenPowerLim_2s::Val_OverRide_Batt_RegenPowerLim_2s','editSampleTime','0.001','Position', [20 6005 70 6035]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_RegenPowerLim_2s/1', 'Val_OverRide_Batt_RegenPowerLim_2s_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion100']);
CovertPortHandles = get_param( [gcs '/SignalConvertion100'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(100), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x109_BMS_HV_10_8'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion100/1','x109_BMS_HV_10_8/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_RegenPowerLim_2s');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_RegenPowerLim_5s_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_RegenPowerLim_5s'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x109_BMS_HV_10::Batt_RegenPowerLim_5s::En_OverRide_Batt_RegenPowerLim_5s','editSampleTime','0.001','Position', [20 6065 70 6095]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_RegenPowerLim_5s/1', 'En_OverRide_Batt_RegenPowerLim_5s_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion101']);
CovertPortHandles = get_param( [gcs '/SignalConvertion101'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(101), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_RegenPowerLim_5s']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_RegenPowerLim_5s'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_RegenPowerLim_5s/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x109_BMS_HV_10_8'], 'Inputs', '7');
En_OverRide_Batt_RegenPowerLim_5sHandle = add_line(gcs,'AND_En_OverRide_Batt_RegenPowerLim_5s/1','x109_BMS_HV_10_8/7','autorouting','on');
set_param(En_OverRide_Batt_RegenPowerLim_5sHandle, 'Name', 'En_OverRide_Batt_RegenPowerLim_5s');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_RegenPowerLim_5s_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_RegenPowerLim_5s'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x109_BMS_HV_10::Batt_RegenPowerLim_5s::Val_OverRide_Batt_RegenPowerLim_5s','editSampleTime','0.001','Position', [20 6125 70 6155]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_RegenPowerLim_5s/1', 'Val_OverRide_Batt_RegenPowerLim_5s_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion102']);
CovertPortHandles = get_param( [gcs '/SignalConvertion102'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(102), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x109_BMS_HV_10_8'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion102/1','x109_BMS_HV_10_8/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_RegenPowerLim_5s');



set_param([gcs,'/BMS'], 'Inputs', '8')
lineHandle = add_line(gcs,'x109_BMS_HV_10_8/1','BMS/8','autorouting','on')
set_param(lineHandle, 'Name', 'x109_BMS_HV_10');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/xCE_BMS_HV_06_9']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_EnergyAvailable_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_EnergyAvailable'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCE_BMS_HV_06::Batt_EnergyAvailable::En_OverRide_Batt_EnergyAvailable','editSampleTime','0.001','Position', [20 6185 70 6215]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_EnergyAvailable/1', 'En_OverRide_Batt_EnergyAvailable_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion103']);
CovertPortHandles = get_param( [gcs '/SignalConvertion103'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(103), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_EnergyAvailable']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_EnergyAvailable'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_EnergyAvailable/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCE_BMS_HV_06_9'], 'Inputs', '1');
En_OverRide_Batt_EnergyAvailableHandle = add_line(gcs,'AND_En_OverRide_Batt_EnergyAvailable/1','xCE_BMS_HV_06_9/1','autorouting','on');
set_param(En_OverRide_Batt_EnergyAvailableHandle, 'Name', 'En_OverRide_Batt_EnergyAvailable');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_EnergyAvailable_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_EnergyAvailable'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCE_BMS_HV_06::Batt_EnergyAvailable::Val_OverRide_Batt_EnergyAvailable','editSampleTime','0.001','Position', [20 6245 70 6275]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_EnergyAvailable/1', 'Val_OverRide_Batt_EnergyAvailable_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion104']);
CovertPortHandles = get_param( [gcs '/SignalConvertion104'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(104), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCE_BMS_HV_06_9'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion104/1','xCE_BMS_HV_06_9/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_EnergyAvailable');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Isolation1Res_HighRange_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Isolation1Res_HighRange'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCE_BMS_HV_06::Batt_Isolation1Res_HighRange::En_OverRide_Batt_Isolation1Res_HighRange','editSampleTime','0.001','Position', [20 6305 70 6335]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Isolation1Res_HighRange/1', 'En_OverRide_Batt_Isolation1Res_HighRange_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion105']);
CovertPortHandles = get_param( [gcs '/SignalConvertion105'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(105), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Isolation1Res_HighRange']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Isolation1Res_HighRange'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Isolation1Res_HighRange/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCE_BMS_HV_06_9'], 'Inputs', '3');
En_OverRide_Batt_Isolation1Res_HighRangeHandle = add_line(gcs,'AND_En_OverRide_Batt_Isolation1Res_HighRange/1','xCE_BMS_HV_06_9/3','autorouting','on');
set_param(En_OverRide_Batt_Isolation1Res_HighRangeHandle, 'Name', 'En_OverRide_Batt_Isolation1Res_HighRange');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Isolation1Res_HighRange_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Isolation1Res_HighRange'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCE_BMS_HV_06::Batt_Isolation1Res_HighRange::Val_OverRide_Batt_Isolation1Res_HighRange','editSampleTime','0.001','Position', [20 6365 70 6395]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Isolation1Res_HighRange/1', 'Val_OverRide_Batt_Isolation1Res_HighRange_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion106']);
CovertPortHandles = get_param( [gcs '/SignalConvertion106'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(106), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCE_BMS_HV_06_9'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion106/1','xCE_BMS_HV_06_9/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Isolation1Res_HighRange');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_Isolation1Resistance_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_Isolation1Resistance'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCE_BMS_HV_06::Batt_Isolation1Resistance::En_OverRide_Batt_Isolation1Resistance','editSampleTime','0.001','Position', [20 6425 70 6455]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_Isolation1Resistance/1', 'En_OverRide_Batt_Isolation1Resistance_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion107']);
CovertPortHandles = get_param( [gcs '/SignalConvertion107'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(107), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_Isolation1Resistance']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_Isolation1Resistance'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_Isolation1Resistance/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCE_BMS_HV_06_9'], 'Inputs', '5');
En_OverRide_Batt_Isolation1ResistanceHandle = add_line(gcs,'AND_En_OverRide_Batt_Isolation1Resistance/1','xCE_BMS_HV_06_9/5','autorouting','on');
set_param(En_OverRide_Batt_Isolation1ResistanceHandle, 'Name', 'En_OverRide_Batt_Isolation1Resistance');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_Isolation1Resistance_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_Isolation1Resistance'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCE_BMS_HV_06::Batt_Isolation1Resistance::Val_OverRide_Batt_Isolation1Resistance','editSampleTime','0.001','Position', [20 6485 70 6515]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_Isolation1Resistance/1', 'Val_OverRide_Batt_Isolation1Resistance_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion108']);
CovertPortHandles = get_param( [gcs '/SignalConvertion108'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(108), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCE_BMS_HV_06_9'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion108/1','xCE_BMS_HV_06_9/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_Isolation1Resistance');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_LVVoltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_LVVoltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCE_BMS_HV_06::Batt_LVVoltage::En_OverRide_Batt_LVVoltage','editSampleTime','0.001','Position', [20 6545 70 6575]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_LVVoltage/1', 'En_OverRide_Batt_LVVoltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion109']);
CovertPortHandles = get_param( [gcs '/SignalConvertion109'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(109), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_LVVoltage']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_LVVoltage'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_LVVoltage/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCE_BMS_HV_06_9'], 'Inputs', '7');
En_OverRide_Batt_LVVoltageHandle = add_line(gcs,'AND_En_OverRide_Batt_LVVoltage/1','xCE_BMS_HV_06_9/7','autorouting','on');
set_param(En_OverRide_Batt_LVVoltageHandle, 'Name', 'En_OverRide_Batt_LVVoltage');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_LVVoltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_LVVoltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCE_BMS_HV_06::Batt_LVVoltage::Val_OverRide_Batt_LVVoltage','editSampleTime','0.001','Position', [20 6605 70 6635]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_LVVoltage/1', 'Val_OverRide_Batt_LVVoltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion110']);
CovertPortHandles = get_param( [gcs '/SignalConvertion110'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(110), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCE_BMS_HV_06_9'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion110/1','xCE_BMS_HV_06_9/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_LVVoltage');



set_param([gcs,'/BMS'], 'Inputs', '9')
lineHandle = add_line(gcs,'xCE_BMS_HV_06_9/1','BMS/9','autorouting','on')
set_param(lineHandle, 'Name', 'xCE_BMS_HV_06');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/xCD_BMS_HV_05_CellParam_10']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_MaxCellTemperature_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_MaxCellTemperature'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCD_BMS_HV_05_CellParam::Batt_MaxCellTemperature::En_OverRide_Batt_MaxCellTemperature','editSampleTime','0.001','Position', [20 6665 70 6695]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_MaxCellTemperature/1', 'En_OverRide_Batt_MaxCellTemperature_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion111']);
CovertPortHandles = get_param( [gcs '/SignalConvertion111'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(111), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_MaxCellTemperature']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_MaxCellTemperature'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_MaxCellTemperature/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCD_BMS_HV_05_CellParam_10'], 'Inputs', '1');
En_OverRide_Batt_MaxCellTemperatureHandle = add_line(gcs,'AND_En_OverRide_Batt_MaxCellTemperature/1','xCD_BMS_HV_05_CellParam_10/1','autorouting','on');
set_param(En_OverRide_Batt_MaxCellTemperatureHandle, 'Name', 'En_OverRide_Batt_MaxCellTemperature');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_MaxCellTemperature_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_MaxCellTemperature'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCD_BMS_HV_05_CellParam::Batt_MaxCellTemperature::Val_OverRide_Batt_MaxCellTemperature','editSampleTime','0.001','Position', [20 6725 70 6755]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_MaxCellTemperature/1', 'Val_OverRide_Batt_MaxCellTemperature_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion112']);
CovertPortHandles = get_param( [gcs '/SignalConvertion112'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(112), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCD_BMS_HV_05_CellParam_10'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion112/1','xCD_BMS_HV_05_CellParam_10/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_MaxCellTemperature');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_MaxCellVoltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_MaxCellVoltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCD_BMS_HV_05_CellParam::Batt_MaxCellVoltage::En_OverRide_Batt_MaxCellVoltage','editSampleTime','0.001','Position', [20 6785 70 6815]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_MaxCellVoltage/1', 'En_OverRide_Batt_MaxCellVoltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion113']);
CovertPortHandles = get_param( [gcs '/SignalConvertion113'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(113), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_MaxCellVoltage']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_MaxCellVoltage'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_MaxCellVoltage/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCD_BMS_HV_05_CellParam_10'], 'Inputs', '3');
En_OverRide_Batt_MaxCellVoltageHandle = add_line(gcs,'AND_En_OverRide_Batt_MaxCellVoltage/1','xCD_BMS_HV_05_CellParam_10/3','autorouting','on');
set_param(En_OverRide_Batt_MaxCellVoltageHandle, 'Name', 'En_OverRide_Batt_MaxCellVoltage');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_MaxCellVoltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_MaxCellVoltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCD_BMS_HV_05_CellParam::Batt_MaxCellVoltage::Val_OverRide_Batt_MaxCellVoltage','editSampleTime','0.001','Position', [20 6845 70 6875]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_MaxCellVoltage/1', 'Val_OverRide_Batt_MaxCellVoltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion114']);
CovertPortHandles = get_param( [gcs '/SignalConvertion114'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(114), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCD_BMS_HV_05_CellParam_10'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion114/1','xCD_BMS_HV_05_CellParam_10/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_MaxCellVoltage');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_MinCellTemperature_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_MinCellTemperature'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCD_BMS_HV_05_CellParam::Batt_MinCellTemperature::En_OverRide_Batt_MinCellTemperature','editSampleTime','0.001','Position', [20 6905 70 6935]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_MinCellTemperature/1', 'En_OverRide_Batt_MinCellTemperature_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion115']);
CovertPortHandles = get_param( [gcs '/SignalConvertion115'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(115), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_MinCellTemperature']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_MinCellTemperature'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_MinCellTemperature/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCD_BMS_HV_05_CellParam_10'], 'Inputs', '5');
En_OverRide_Batt_MinCellTemperatureHandle = add_line(gcs,'AND_En_OverRide_Batt_MinCellTemperature/1','xCD_BMS_HV_05_CellParam_10/5','autorouting','on');
set_param(En_OverRide_Batt_MinCellTemperatureHandle, 'Name', 'En_OverRide_Batt_MinCellTemperature');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_MinCellTemperature_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_MinCellTemperature'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCD_BMS_HV_05_CellParam::Batt_MinCellTemperature::Val_OverRide_Batt_MinCellTemperature','editSampleTime','0.001','Position', [20 6965 70 6995]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_MinCellTemperature/1', 'Val_OverRide_Batt_MinCellTemperature_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion116']);
CovertPortHandles = get_param( [gcs '/SignalConvertion116'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(116), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCD_BMS_HV_05_CellParam_10'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion116/1','xCD_BMS_HV_05_CellParam_10/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_MinCellTemperature');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_MinCellVoltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_MinCellVoltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCD_BMS_HV_05_CellParam::Batt_MinCellVoltage::En_OverRide_Batt_MinCellVoltage','editSampleTime','0.001','Position', [20 7025 70 7055]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_MinCellVoltage/1', 'En_OverRide_Batt_MinCellVoltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion117']);
CovertPortHandles = get_param( [gcs '/SignalConvertion117'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(117), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_MinCellVoltage']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_MinCellVoltage'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_MinCellVoltage/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/xCD_BMS_HV_05_CellParam_10'], 'Inputs', '7');
En_OverRide_Batt_MinCellVoltageHandle = add_line(gcs,'AND_En_OverRide_Batt_MinCellVoltage/1','xCD_BMS_HV_05_CellParam_10/7','autorouting','on');
set_param(En_OverRide_Batt_MinCellVoltageHandle, 'Name', 'En_OverRide_Batt_MinCellVoltage');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_MinCellVoltage_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_MinCellVoltage'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::xCD_BMS_HV_05_CellParam::Batt_MinCellVoltage::Val_OverRide_Batt_MinCellVoltage','editSampleTime','0.001','Position', [20 7085 70 7115]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_MinCellVoltage/1', 'Val_OverRide_Batt_MinCellVoltage_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion118']);
CovertPortHandles = get_param( [gcs '/SignalConvertion118'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(118), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/xCD_BMS_HV_05_CellParam_10'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion118/1','xCD_BMS_HV_05_CellParam_10/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_MinCellVoltage');



set_param([gcs,'/BMS'], 'Inputs', '10')
lineHandle = add_line(gcs,'xCD_BMS_HV_05_CellParam_10/1','BMS/10','autorouting','on')
set_param(lineHandle, 'Name', 'xCD_BMS_HV_05_CellParam');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/x112_BMS_HV_12_11']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_Batt_SerialNumber_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_Batt_SerialNumber'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x112_BMS_HV_12::Batt_SerialNumber::En_OverRide_Batt_SerialNumber','editSampleTime','0.001','Position', [20 7145 70 7175]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_Batt_SerialNumber/1', 'En_OverRide_Batt_SerialNumber_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion119']);
CovertPortHandles = get_param( [gcs '/SignalConvertion119'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(119), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_Batt_SerialNumber']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_Batt_SerialNumber'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_Batt_SerialNumber/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x112_BMS_HV_12_11'], 'Inputs', '1');
En_OverRide_Batt_SerialNumberHandle = add_line(gcs,'AND_En_OverRide_Batt_SerialNumber/1','x112_BMS_HV_12_11/1','autorouting','on');
set_param(En_OverRide_Batt_SerialNumberHandle, 'Name', 'En_OverRide_Batt_SerialNumber');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_Batt_SerialNumber_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_Batt_SerialNumber'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x112_BMS_HV_12::Batt_SerialNumber::Val_OverRide_Batt_SerialNumber','editSampleTime','0.001','Position', [20 7205 70 7235]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_Batt_SerialNumber/1', 'Val_OverRide_Batt_SerialNumber_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion120']);
CovertPortHandles = get_param( [gcs '/SignalConvertion120'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(120), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x112_BMS_HV_12_11'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion120/1','x112_BMS_HV_12_11/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_Batt_SerialNumber');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_BMS_Calibration_info_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_BMS_Calibration_info'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x112_BMS_HV_12::BMS_Calibration_info::En_OverRide_BMS_Calibration_info','editSampleTime','0.001','Position', [20 7265 70 7295]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_BMS_Calibration_info/1', 'En_OverRide_BMS_Calibration_info_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion121']);
CovertPortHandles = get_param( [gcs '/SignalConvertion121'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(121), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BMS_Calibration_info']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BMS_Calibration_info'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BMS_Calibration_info/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x112_BMS_HV_12_11'], 'Inputs', '3');
En_OverRide_BMS_Calibration_infoHandle = add_line(gcs,'AND_En_OverRide_BMS_Calibration_info/1','x112_BMS_HV_12_11/3','autorouting','on');
set_param(En_OverRide_BMS_Calibration_infoHandle, 'Name', 'En_OverRide_BMS_Calibration_info');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_BMS_Calibration_info_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_BMS_Calibration_info'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x112_BMS_HV_12::BMS_Calibration_info::Val_OverRide_BMS_Calibration_info','editSampleTime','0.001','Position', [20 7325 70 7355]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_BMS_Calibration_info/1', 'Val_OverRide_BMS_Calibration_info_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion122']);
CovertPortHandles = get_param( [gcs '/SignalConvertion122'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(122), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x112_BMS_HV_12_11'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion122/1','x112_BMS_HV_12_11/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BMS_Calibration_info');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_BMS_Software_info_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_BMS_Software_info'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x112_BMS_HV_12::BMS_Software_info::En_OverRide_BMS_Software_info','editSampleTime','0.001','Position', [20 7385 70 7415]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_BMS_Software_info/1', 'En_OverRide_BMS_Software_info_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion123']);
CovertPortHandles = get_param( [gcs '/SignalConvertion123'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(123), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_BMS_Software_info']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_BMS_Software_info'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_BMS_Software_info/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x112_BMS_HV_12_11'], 'Inputs', '5');
En_OverRide_BMS_Software_infoHandle = add_line(gcs,'AND_En_OverRide_BMS_Software_info/1','x112_BMS_HV_12_11/5','autorouting','on');
set_param(En_OverRide_BMS_Software_infoHandle, 'Name', 'En_OverRide_BMS_Software_info');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_BMS_Software_info_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_BMS_Software_info'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x112_BMS_HV_12::BMS_Software_info::Val_OverRide_BMS_Software_info','editSampleTime','0.001','Position', [20 7445 70 7475]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_BMS_Software_info/1', 'Val_OverRide_BMS_Software_info_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion124']);
CovertPortHandles = get_param( [gcs '/SignalConvertion124'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(124), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x112_BMS_HV_12_11'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion124/1','x112_BMS_HV_12_11/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_BMS_Software_info');



set_param([gcs,'/BMS'], 'Inputs', '11')
lineHandle = add_line(gcs,'x112_BMS_HV_12_11/1','BMS/11','autorouting','on')
set_param(lineHandle, 'Name', 'x112_BMS_HV_12');

add_block('simulink/Signal Routing/Bus Creator', [gcs,'/x12D_CIM_HV_01_12']);

add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_CIM_ChargePlugLockStatusHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_CIM_ChargePlugLockStatusHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x12D_CIM_HV_01::CIM_ChargePlugLockStatusHV::En_OverRide_CIM_ChargePlugLockStatusHV','editSampleTime','0.001','Position', [20 7505 70 7535]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_CIM_ChargePlugLockStatusHV/1', 'En_OverRide_CIM_ChargePlugLockStatusHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion125']);
CovertPortHandles = get_param( [gcs '/SignalConvertion125'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(125), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_CIM_ChargePlugLockStatusHV']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_CIM_ChargePlugLockStatusHV'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_CIM_ChargePlugLockStatusHV/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x12D_CIM_HV_01_12'], 'Inputs', '1');
En_OverRide_CIM_ChargePlugLockStatusHVHandle = add_line(gcs,'AND_En_OverRide_CIM_ChargePlugLockStatusHV/1','x12D_CIM_HV_01_12/1','autorouting','on');
set_param(En_OverRide_CIM_ChargePlugLockStatusHVHandle, 'Name', 'En_OverRide_CIM_ChargePlugLockStatusHV');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_CIM_ChargePlugLockStatusHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_CIM_ChargePlugLockStatusHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x12D_CIM_HV_01::CIM_ChargePlugLockStatusHV::Val_OverRide_CIM_ChargePlugLockStatusHV','editSampleTime','0.001','Position', [20 7565 70 7595]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_CIM_ChargePlugLockStatusHV/1', 'Val_OverRide_CIM_ChargePlugLockStatusHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion126']);
CovertPortHandles = get_param( [gcs '/SignalConvertion126'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(126), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x12D_CIM_HV_01_12'], 'Inputs', '2');
lineHandle = add_line(gcs,'SignalConvertion126/1','x12D_CIM_HV_01_12/2','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_CIM_ChargePlugLockStatusHV');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_CIM_ChargeStatusHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_CIM_ChargeStatusHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x12D_CIM_HV_01::CIM_ChargeStatusHV::En_OverRide_CIM_ChargeStatusHV','editSampleTime','0.001','Position', [20 7625 70 7655]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_CIM_ChargeStatusHV/1', 'En_OverRide_CIM_ChargeStatusHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion127']);
CovertPortHandles = get_param( [gcs '/SignalConvertion127'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(127), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_CIM_ChargeStatusHV']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_CIM_ChargeStatusHV'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_CIM_ChargeStatusHV/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x12D_CIM_HV_01_12'], 'Inputs', '3');
En_OverRide_CIM_ChargeStatusHVHandle = add_line(gcs,'AND_En_OverRide_CIM_ChargeStatusHV/1','x12D_CIM_HV_01_12/3','autorouting','on');
set_param(En_OverRide_CIM_ChargeStatusHVHandle, 'Name', 'En_OverRide_CIM_ChargeStatusHV');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_CIM_ChargeStatusHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_CIM_ChargeStatusHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x12D_CIM_HV_01::CIM_ChargeStatusHV::Val_OverRide_CIM_ChargeStatusHV','editSampleTime','0.001','Position', [20 7685 70 7715]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_CIM_ChargeStatusHV/1', 'Val_OverRide_CIM_ChargeStatusHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion128']);
CovertPortHandles = get_param( [gcs '/SignalConvertion128'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(128), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x12D_CIM_HV_01_12'], 'Inputs', '4');
lineHandle = add_line(gcs,'SignalConvertion128/1','x12D_CIM_HV_01_12/4','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_CIM_ChargeStatusHV');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_CIM_ChargingPlugTypeHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_CIM_ChargingPlugTypeHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x12D_CIM_HV_01::CIM_ChargingPlugTypeHV::En_OverRide_CIM_ChargingPlugTypeHV','editSampleTime','0.001','Position', [20 7745 70 7775]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_CIM_ChargingPlugTypeHV/1', 'En_OverRide_CIM_ChargingPlugTypeHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion129']);
CovertPortHandles = get_param( [gcs '/SignalConvertion129'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(129), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_CIM_ChargingPlugTypeHV']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_CIM_ChargingPlugTypeHV'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_CIM_ChargingPlugTypeHV/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x12D_CIM_HV_01_12'], 'Inputs', '5');
En_OverRide_CIM_ChargingPlugTypeHVHandle = add_line(gcs,'AND_En_OverRide_CIM_ChargingPlugTypeHV/1','x12D_CIM_HV_01_12/5','autorouting','on');
set_param(En_OverRide_CIM_ChargingPlugTypeHVHandle, 'Name', 'En_OverRide_CIM_ChargingPlugTypeHV');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_CIM_ChargingPlugTypeHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_CIM_ChargingPlugTypeHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x12D_CIM_HV_01::CIM_ChargingPlugTypeHV::Val_OverRide_CIM_ChargingPlugTypeHV','editSampleTime','0.001','Position', [20 7805 70 7835]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_CIM_ChargingPlugTypeHV/1', 'Val_OverRide_CIM_ChargingPlugTypeHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion130']);
CovertPortHandles = get_param( [gcs '/SignalConvertion130'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(130), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x12D_CIM_HV_01_12'], 'Inputs', '6');
lineHandle = add_line(gcs,'SignalConvertion130/1','x12D_CIM_HV_01_12/6','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_CIM_ChargingPlugTypeHV');



add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/En_OverRide_CIM_PlugPresentHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/En_OverRide_CIM_PlugPresentHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x12D_CIM_HV_01::CIM_PlugPresentHV::En_OverRide_CIM_PlugPresentHV','editSampleTime','0.001','Position', [20 7865 70 7895]);
add_line([gcs '/BMS_EnabledSubsystem'], 'En_OverRide_CIM_PlugPresentHV/1', 'En_OverRide_CIM_PlugPresentHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion131']);
CovertPortHandles = get_param( [gcs '/SignalConvertion131'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(131), CovertPortHandles.Inport(1), 'autorouting', 'on');

add_block('simulink/Quick Insert/Logic and Bit Operations/AND', [gcs,'/AND_En_OverRide_CIM_PlugPresentHV']);
AndPortHandles = get_param( [gcs '/AND_En_OverRide_CIM_PlugPresentHV'],'PortHandles');
lineHandleGlobal = add_line(gcs,'GLOBAL_OV/1','AND_En_OverRide_CIM_PlugPresentHV/1','autorouting','on');
lineHandle2 = add_line(gcs,CovertPortHandles.Outport(1),AndPortHandles.Inport(2),'autorouting','on');
set_param([gcs,'/x12D_CIM_HV_01_12'], 'Inputs', '7');
En_OverRide_CIM_PlugPresentHVHandle = add_line(gcs,'AND_En_OverRide_CIM_PlugPresentHV/1','x12D_CIM_HV_01_12/7','autorouting','on');
set_param(En_OverRide_CIM_PlugPresentHVHandle, 'Name', 'En_OverRide_CIM_PlugPresentHV');


add_block('simulink/Ports & Subsystems/Out1', [gcs '/BMS_EnabledSubsystem/Val_OverRide_CIM_PlugPresentHV_port']);
SubsysPortHandles = get_param( [gcs '/BMS_EnabledSubsystem'],'PortHandles');
add_block('canoelib/CANoe I//O/System Variable Input', [gcs,'/BMS_EnabledSubsystem/Val_OverRide_CIM_PlugPresentHV'], 'nsName', 'HIL_Interface', 'sysVarName', 'CAN_OverRide::BMS::x12D_CIM_HV_01::CIM_PlugPresentHV::Val_OverRide_CIM_PlugPresentHV','editSampleTime','0.001','Position', [20 7925 70 7955]);
add_line([gcs '/BMS_EnabledSubsystem'], 'Val_OverRide_CIM_PlugPresentHV/1', 'Val_OverRide_CIM_PlugPresentHV_port/1');
add_block('simulink/Quick Insert/Signal Attributes/Signal Copy', [gcs,'/SignalConvertion132']);
CovertPortHandles = get_param( [gcs '/SignalConvertion132'],'PortHandles'); 
add_line(gcs , SubsysPortHandles.Outport(132), CovertPortHandles.Inport(1), 'autorouting', 'on');

set_param([gcs,'/x12D_CIM_HV_01_12'], 'Inputs', '8');
lineHandle = add_line(gcs,'SignalConvertion132/1','x12D_CIM_HV_01_12/8','autorouting','on');
set_param(lineHandle, 'Name', 'Val_OverRide_CIM_PlugPresentHV');



set_param([gcs,'/BMS'], 'Inputs', '12')
lineHandle = add_line(gcs,'x12D_CIM_HV_01_12/1','BMS/12','autorouting','on')
set_param(lineHandle, 'Name', 'x12D_CIM_HV_01');

 
set_param(gcs,...
'Solver','FixedStepDiscrete',...
'FixedStep','0.1');
save_system(fname);