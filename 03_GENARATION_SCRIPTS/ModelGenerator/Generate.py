from ast import literal_eval
from lxml import etree
import csv
import sys

from codeStrings.codestring import SysvarHeader,SysvarFooter,mheader,mfooter,BusCreator,ValueOVblock,EnableOVblock,Nodeblock,GlobalOV,SysvarSubsytem,NodeBusCreator

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


csv_file = 'Databases/BMS.csv'
NODE = "BMS"

MsgDict= {}
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

            
    with open(f"GeneratedFiles/{NODE}.vsysvar", "w") as f:
        xml_str = etree.tostring(root, pretty_print=True, encoding="UTF-8").decode("UTF-8")
        f.write(SysvarHeader)
        f.write(xml_str)
        f.write(SysvarFooter)
        #print(xml_str)




    with open(f"GeneratedFiles/{NODE}.m","w") as f:

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
