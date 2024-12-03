from ast import literal_eval
from lxml import etree
import csv
header = """<?xml version="1.0" encoding="utf-8"?>
<systemvariables version="4">
<namespace name="" comment="" interface="">\n   <namespace name="HIL_Interface" comment="" interface="">\n      <namespace name="CAN_OverRide" comment="" interface="">
"""
footer = "      </namespace>\n  </namespace>\n</namespace>\n</systemvariables>"

class messsage():
    def __init__(self):
        self.id = None
        self.MsgName = None
        self.signalList = []
        self.hasMulti = {"Multi":None,"MultiplexorName":None}
        self.multiSignalList = []

class signal():
    def __init__(self):
        self.SigName = None
        self.Multiplexer = None
        self.initial_value = None
        self.factor = None
        self.min = None
        self.max = None
        self.comment = None




MsgDict= {}
# File path for the CSV
csv_file = 'DCDC.csv'
NODE = "DCDC"
root = etree.Element("namespace", name="NodeName", comment="", interface="")

with open(csv_file, mode='r', newline='\n') as file:
    reader = csv.reader(file, delimiter=';')
    print(reader)
#Name;Message;Multiplexing/Group;Startbit;Length [Bit];Byte Order;Value Type;Initial Value;Factor;Offset;Minimum;Maximum;Unit;Value Table;Comment;Message ID

    for sigLine in reader:
        #print(sigLine)
        MsgId = sigLine[15]
        #print(MsgId)
        if MsgId not in MsgDict:
            MsgObj = messsage()
            MsgObj.id = MsgId
            MsgObj.MsgName = sigLine[1]
            MsgDict[MsgId]=MsgObj
        else:
            MsgObj = MsgDict[MsgId]
        SglObj = signal()
        SglObj.SigName = sigLine[0]
        SglObj.Multiplexer = sigLine[2]
        SglObj.initial_value =sigLine[7]
        SglObj.factor = sigLine[8]
        SglObj.min = sigLine[10]
        SglObj.max = sigLine[11] 
        SglObj.comment = sigLine[14]

            #if(MsgObj.MsgName == "BMS_HV_12"):
        #print( SglObj.SigName + " has '"+SglObj.Multiplexer+"'")
        if(SglObj.Multiplexer not in ["-", "", None] ):
            print( SglObj.SigName + " has '"+SglObj.Multiplexer+"'")                
            if(SglObj.Multiplexer == "Multiplexor"):
                MsgObj.hasMulti["Multi"]=SglObj
                MsgObj.hasMulti["MultiplexorName"] = SglObj.SigName

            else:                   
                MsgObj.multiSignalList.append(SglObj)
        else:
            MsgObj.signalList.append(SglObj)


    
        # for i in (1,10):
        #     print(MsgObj.multiSignalDict[i])
  

    for Msg in MsgDict:
        MsgElem = etree.SubElement(root, "namespace", name= (MsgDict[Msg].id).replace("0","",1) + "_" + MsgDict[Msg].MsgName , comment="", interface="")
       
        for obj in MsgDict[Msg].signalList:
            #print(obj.SigName)
            SglElem = etree.SubElement(MsgElem, "namespace", name= obj.SigName , comment="", interface="")
            if (float(obj.factor) < 0.999 or float(obj.max) > 10000000.0   or ("." in obj.max or "." in obj.min or "." in obj.factor)):
                # print('fact : ' + obj.factor)
                # print('Max : ' + obj.max)
                sysvartype = "float"
      
            else:
                sysvartype = "int"
           
            etree.SubElement(SglElem, "variable", anlyzLocal="2", readOnly="false", valueSequence="false", unit="", name="En_OverRide_"+ obj.SigName, comment="", bitcount="32", isSigned="true", encoding="65001", type="int", startValue="0", minValue="0", minValuePhys="0", maxValue="1", maxValuePhys="1")
            etree.SubElement(SglElem, "variable", anlyzLocal="2", readOnly="false", valueSequence="false", unit="", name="Val_OverRide_"+ obj.SigName, comment="", bitcount="32", isSigned="true", encoding="65001", type=sysvartype, startValue=obj.initial_value, minValue=obj.min, minValuePhys=obj.min, maxValue=obj.max, maxValuePhys=obj.max)
        if MsgDict[Msg].hasMulti["Multi"] != None:
            parentControl = MsgDict[Msg].hasMulti["Multi"]
            mSignalList = MsgDict[Msg].multiSignalList
            #print(parentControl.SigName)
            MultiElem = etree.SubElement(MsgElem, "namespace", name= parentControl.SigName , comment="", interface="")
            etree.SubElement(MultiElem, "variable", anlyzLocal="2", readOnly="false", valueSequence="false", unit="", name="En_OverRide_"+ parentControl.SigName, comment="", bitcount="32", isSigned="true", encoding="65001", type="int", startValue="0", minValue="0", minValuePhys="0", maxValue="1", maxValuePhys="1")
            etree.SubElement(MultiElem, "variable", anlyzLocal="2", readOnly="false", valueSequence="false", unit="", name="Val_OverRide_"+ parentControl.SigName, comment="", bitcount="32", isSigned="true", encoding="65001", type=sysvartype, startValue=obj.initial_value, minValue=obj.min, minValuePhys=obj.min, maxValue=obj.max, maxValuePhys=obj.max)

            for obj in mSignalList:
                SigElem = etree.SubElement(MultiElem, "namespace", name= "M"+str(literal_eval(obj.Multiplexer.split("=")[1])) +"_" + obj.SigName , comment="", interface="")
                if (float(obj.factor) < 0.999 or float(obj.max) > 10000000.0   or ("." in obj.max or "." in obj.min or "." in obj.factor)):
                    sysvartype = "float"
      
                else:
                    sysvartype = "int"
                etree.SubElement(SigElem, "variable", anlyzLocal="2", readOnly="false", valueSequence="false", unit="", name="En_OverRide_"+ str(literal_eval(obj.Multiplexer.split("=")[1]))+"_" + obj.SigName , comment="", bitcount="32", isSigned="true", encoding="65001", type="int", startValue="0", minValue="0", minValuePhys="0", maxValue="1", maxValuePhys="1")
                etree.SubElement(SigElem, "variable", anlyzLocal="2", readOnly="false", valueSequence="false", unit="", name="Val_OverRide_"+ str(literal_eval(obj.Multiplexer.split("=")[1])) +"_" + obj.SigName , comment="", bitcount="32", isSigned="true", encoding="65001", type=sysvartype, startValue=obj.initial_value, minValue=obj.min, minValuePhys=obj.min, maxValue=obj.max, maxValuePhys=obj.max)

            
    with open("output.vsysvar", "w") as f:
        xml_str = etree.tostring(root, pretty_print=True, encoding="UTF-8").decode("UTF-8")
        f.write(header)
        f.write(xml_str)
        f.write(footer)
        #print(xml_str)




    with open("autoCreatedModel.m","w") as f:
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
        SysvarSubsytem = """add_block('simulink/Ports & Subsystems/Enabled Subsystem', [gcs '/$NODE$_EnabledSubsystem']);
        delete_block([gcs '/$NODE$_EnabledSubsystem/In1']);
        delete_block([gcs '/$NODE$_EnabledSubsystem/Out1']);"""
        f.write(mheader)
        f.write(GlobalOV)
        f.write("\n") 
        f.write(Nodeblock.replace("$NODE$", NODE))
        f.write("\n")
        f.write(SysvarSubsytem.replace("$NODE$", NODE))
        f.write("\n")
        # Hight=30
        # Width=50

        X = 20
        Y = 5
        W = 70
        H = 35
        N = 0
        BUS = 0
        PORT = 0
        NODEBUS_PORT = 0
        for Msg in MsgDict:
            BUS = BUS + 1
            MESSAGE = (MsgDict[Msg].id).replace("0","",1) + "_" + MsgDict[Msg].MsgName
            BusBlock = BusCreator.replace("$BUS$", str(BUS))
            BusBlock = BusBlock.replace("$MESSAGE$", str(MESSAGE))
            f.write(BusBlock)
            f.write("\n")
            
            for obj in MsgDict[Msg].signalList:
                Y= Y + 60
                H= H + 60
                N = N + 1
                PORT = PORT + 1
                EnableBlock = EnableOVblock.replace("$NODE$", NODE)
                EnableBlock = EnableBlock.replace("$N$", str(N))
                EnableBlock = EnableBlock.replace("$MESSAGE$", MESSAGE)
                EnableBlock = EnableBlock.replace("$SIGNAL$", obj.SigName )
                EnableBlock = EnableBlock.replace("$OV$", "En_OverRide_"+ obj.SigName)
                EnableBlock = EnableBlock.replace("$X$", str(X))
                EnableBlock = EnableBlock.replace("$Y$", str(Y))
                EnableBlock = EnableBlock.replace("$W$", str(W))
                EnableBlock = EnableBlock.replace("$H$", str(H))
                EnableBlock = EnableBlock.replace("$BUS$", str(BUS))
                EnableBlock = EnableBlock.replace("$PORT$", str(PORT))


                f.write(EnableBlock)
                f.write("\n")

                N = N + 1
                PORT = PORT + 1
                Y= Y + 60
                H= H + 60

                ValueBlock = ValueOVblock.replace("$NODE$", NODE)
                ValueBlock = ValueBlock.replace("$N$", str(N))
                ValueBlock = ValueBlock.replace("$MESSAGE$", MESSAGE)
                ValueBlock = ValueBlock.replace("$SIGNAL$", obj.SigName )
                ValueBlock = ValueBlock.replace("$OV$", "Val_OverRide_"+ obj.SigName)
                ValueBlock = ValueBlock.replace("$X$", str(X))
                ValueBlock = ValueBlock.replace("$Y$", str(Y))
                ValueBlock = ValueBlock.replace("$W$", str(W))
                ValueBlock = ValueBlock.replace("$H$", str(H))
                ValueBlock = ValueBlock.replace("$BUS$", str(BUS))
                ValueBlock = ValueBlock.replace("$PORT$", str(PORT))
                
                f.write(ValueBlock)
                f.write("\n")

            if  MsgDict[Msg].hasMulti["Multi"] != None:
                for obj in MsgDict[Msg].multiSignalList:
                    Y= Y + 60
                    H= H + 60
                    N = N + 1
                    PORT = PORT + 1
                    EnableBlock = EnableOVblock.replace("$NODE$", NODE)
                    EnableBlock = EnableBlock.replace("$N$", str(N))
                    EnableBlock = EnableBlock.replace("$MESSAGE$", MESSAGE)
                    EnableBlock = EnableBlock.replace("$SIGNAL$", obj.SigName )
                    EnableBlock = EnableBlock.replace("$OV$", "En_OverRide_"+ obj.SigName)
                    EnableBlock = EnableBlock.replace("$X$", str(X))
                    EnableBlock = EnableBlock.replace("$Y$", str(Y))
                    EnableBlock = EnableBlock.replace("$W$", str(W))
                    EnableBlock = EnableBlock.replace("$H$", str(H))
                    EnableBlock = EnableBlock.replace("$BUS$", str(BUS))
                    EnableBlock = EnableBlock.replace("$PORT$", str(PORT))


                    f.write(EnableBlock)
                    f.write("\n")

                    N = N + 1
                    PORT = PORT + 1
                    Y= Y + 60
                    H= H + 60

                    ValueBlock = ValueOVblock.replace("$NODE$", NODE)
                    ValueBlock = ValueBlock.replace("$N$", str(N))
                    ValueBlock = ValueBlock.replace("$MESSAGE$", MESSAGE)
                    ValueBlock = ValueBlock.replace("$SIGNAL$", obj.SigName )
                    ValueBlock = ValueBlock.replace("$OV$", "Val_OverRide_"+ obj.SigName)
                    ValueBlock = ValueBlock.replace("$X$", str(X))
                    ValueBlock = ValueBlock.replace("$Y$", str(Y))
                    ValueBlock = ValueBlock.replace("$W$", str(W))
                    ValueBlock = ValueBlock.replace("$H$", str(H))
                    ValueBlock = ValueBlock.replace("$BUS$", str(BUS))
                    ValueBlock = ValueBlock.replace("$PORT$", str(PORT))


                    
                    f.write(ValueBlock)
                    f.write("\n")


            PORT = 0
            NODEBUS_PORT = NODEBUS_PORT + 1
            NodeBusCreator = """
                            set_param([gcs,'/$NODE$'], 'Inputs', '$NODEBUS_PORT$')
                            lineHandle = add_line(gcs,'$MESSAGE$_$BUS$/1','$NODE$/$NODEBUS_PORT$','autorouting','on')
                            set_param(lineHandle, 'Name', '$MESSAGE$');
                            """
            NodeBUS = NodeBusCreator.replace("$NODE$", NODE)
            NodeBUS = NodeBUS.replace("$NODEBUS_PORT$", str(NODEBUS_PORT))
            NodeBUS = NodeBUS.replace("$BUS$", str(BUS))
            NodeBUS = NodeBUS.replace("$MESSAGE$", MESSAGE)
            f.write(NodeBUS)
            f.write("\n")
        f.write(mfooter)
        




# Create the root element


# # Add variables and namespaces to the root element
# etree.SubElement(root, "variable", anlyzLocal="2", readOnly="false", valueSequence="false", unit="", name="En_OverRIde_Global", comment="", bitcount="32", isSigned="true", encoding="65001", type="int", startValue="0", minValue="0", minValuePhys="0", maxValue="1", maxValuePhys="1")


# # Find the OilPump namespace and add a child
# oil_pump = root.xpath(".//namespace[@name='OilPump']")[0]  # Find OilPump namespace
# etree.SubElement(oil_pump, "variable", name="OilPressure", comment="Oil pressure sensor", bitcount="16", isSigned="false", encoding="65001", type="int", startValue="0", minValue="0", minValuePhys="0", maxValue="100", maxValuePhys="100")





























# print("\nName List:", name)
# print("\nMessage List:", message)
        #print(signal)
        # name.append(signal[0])
        # message.append(signal[1])
        # multiplexing_group.append(signal[2])
        # startbit.append(signal[3])
        # length_bit.append(signal[4])
        # byte_order.append(signal[5])
        # value_type.append(signal[6])
        # initial_value.append(signal[7])
        # factor.append(signal[8])
        # offset.append(signal[9])
        # minimum.append(signal[10])
        # maximum.append(signal[11])
        # unit.append(signal[12])
        # value_table.append(signal[13])
        # comment.append(signal[14])
        # message_id.append(signal[15])
# # Initialize lists for each column
# name = []
# message = []
# multiplexing_group = []
# startbit = []
# length_bit = []
# byte_order = []
# value_type = []
# initial_value = []
# factor = []
# offset = []
# minimum = []
# maximum = []
# unit = []
# value_table = []
# comment = []
# message_id = []
