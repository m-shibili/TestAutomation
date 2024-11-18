"""
This is an example of a user-defined tool to showcase the implementation of custom ports.

For a basic introduction to UserTools please see ``BasicExampleUserTool``.
"""

from __future__ import annotations

import hashlib
import json
import logging
import time
from threading import Event, Thread
from typing import TYPE_CHECKING, Literal, NotRequired, TypedDict



# <_____________Custom import___________>
import os
import subprocess
import psutil

import clr
dll_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '../../..', '02_SM_ADAPTER_API_SLN/SM_Adapter/bin/Debug/netstandard2.1/'))
print(dll_dir)
clr.AddReference(os.path.join(dll_dir,"SM_Adapter.dll"))
from SM_Adapter import SM_Adapter
SysMon = SM_Adapter()

# <_____________/Custom import__________>

from tts.lib.hooks.HookValidator import optional

if TYPE_CHECKING:
    from collections.abc import Callable

# Required so that ecu.test can discover this module and recognize it as a user tool.
MODULE_TYPE = 'USER_TOOL'

class ExampleUserTool:
    def __init__(self, properties: dict[str, str | bool]) -> None:
        self._properties = properties
        #Now we point to the TSysMonAPI class
        self._properties = properties
        self.pathToSMexe = r'C:\\Program Files (x86)\\McLaren Electronic Systems\\System Monitor 8\\SystemMonitorU.exe'

        self.launch_SM()
        self.Load_project()

        logging.getLogger('ecu.test').info(f'{self.GetToolName()} initialized')


    def launch_SM(self):
        """Check if a process with the given executable name is already running."""
        _running = 0
        for proc in psutil.process_iter(attrs=['name']):
            if proc.info['name'] == 'SystemMonitorU.exe':
                _running = 1
                logging.getLogger('ecu.test').info('Sytem monitor already running')
        if _running == 0:
            try:
                process = subprocess.Popen(self.pathToSMexe)
                logging.getLogger('ecu.test').info(f"Launched SM with PID: {process.pid}")
            except FileNotFoundError:
                logging.getLogger('ecu.test').info("Error: Executable not found.")
            except Exception as e:
                logging.getLogger('ecu.test').info(f"An error occurred: {e}")

    def Load_project(self):
        if (self._properties['Project Load method'] == 'Load SMX'):
            importPath = self._properties['System Monitor SMX into Customer Base']
            base = str("MAH_VCU500_S11")
            SysMon.ImportProject(str(importPath), base)
            logging.getLogger('ecu.test').info(f"SM loading SMX, path : {importPath}")

        elif (self._properties['Project Load method'] == 'Open Project'):
            importPath = self._properties['System Monitor project file']
            SysMon.OpenProject(str(importPath))
            logging.getLogger('ecu.test').info(f"SM opening Project, path : {importPath}")

        elif(self._properties['Project Load method'] == 'Keep the open project'):
            pass

    @classmethod
    def GetToolName(cls) -> str:
        return '01_McLaren_SM'

    @classmethod
    def IsInstalled(cls) -> bool:
        return True

    @classmethod
    def GetPorts(cls) -> list:
        return [ExampleUserModelPort]

    @classmethod
    def GetJobs(cls) -> list[Callable]:
        """
        Returns a list of methods that should be registered on this tool as jobs.
        """
        return [cls.Reprogram_App, cls.Jobnumbertwo]

    @classmethod
    def GetProperties(cls) -> dict[str, dict]:
        """
        Properties of the tool. These properties can be configured in the test bench configuration.
        The configured properties are passed to the `__init__` method when the configuration is
        started. Available property types are STRING, BOOL and CHOICE. Properties may be sorted
        into groups to improve visual separation in the test bench configuration.
        """
        return {
           
            'System Monitor Files': {

                'System Monitor project file': {
                'Description': 'Path location of prj File',
                'Type': 'STRING',
                'Default': 'C:\FormulaE_S11_VCU500\S11_D09_004.prj',
                },
                'System Monitor SMX into Customer Base': {
                'Description': 'Path location of SMX Files',
                'Type': 'STRING',
                'Default': 'C:\FormulaE_S11_VCU500\MAH_PROJECTS_S11\Baseline_C02JAR_001.smx'
                },
                'Project Load method': {
                'Description': 'Choose to open a project or load smx to existing project',
                'Type': 'CHOICE',
                'Choices': ['Keep the open project','Open Project', 'Load SMX'],
                'Default': 'Keep the open project',
                },
                
                'Advanced file Configuration':{
                    'Load filesfrom these path': {
                        'Description': '',
                        'Type': 'BOOL',
                        'Default': False,
                    },

                    'System Monitor Project': {
                    'Description': 'Path location of Project file',
                    'Type': 'STRING',
                    'Default': '.prj',
                    },
                    'PGV0': {
                    'Description': 'Path location of Project file',
                    'Type': 'STRING',
                    'Default': '.pgv',
                    },
                    'PGV1': {
                    'Description': 'Path location of Project file',
                    'Type': 'STRING',
                    'Default': '.pgv',
                    },
                    'PGV2': {
                    'Description': 'Path location of Project file',
                    'Type': 'STRING',
                    'Default': '.pgv',
                    },
                    'PGV3': {
                    'Description': 'Path location of Project file',
                    'Type': 'STRING',
                    'Default': '.pgv',
                    },
                    'PGV4': {
                    'Description': 'Path location of Project file',
                    'Type': 'STRING',
                    'Default': '.pgv',
                    },
                    'PGV5': {
                    'Description': 'Path location of Project file',
                    'Type': 'STRING',
                    'Default': '.pgv',
                    },
                    'PGV6': {
                    'Description': 'Path location of Project file',
                    'Type': 'STRING',
                    'Default': '.pgv',
                    },
                    'PGV7': {
                    'Description': 'Path location of Project file',
                    'Type': 'STRING',
                    'Default': '.pgv',
                    },
                    'PGV8': {
                    'Description': 'Path location of Project file',
                    'Type': 'STRING',
                    'Default': '.pgv',
                    }

                },

            },
        }

    def GetVersion(self) -> str:
        """
        Version of the external tool. This version will be documented in the test report.
        """
        return '1.0.0'

    def Reprogram_App(self, AppNo: int = 1) -> float :
        """
        Descreption

        :param AppNo: Individual number of the App
      
        :return: True or False return from SM
        """

        (res) = SysMon.Reprogram(AppNo)
        print(res)
        return float(res)
    

    
    def Jobnumbertwo(self, paramOne: float = 1.0, paramTwo: float = 2.0) -> float:
        """
        Jobnumbertwo

        :param paramOne: Description for paramOne
        :param paramTwo: Description for paramTwo
        :return: Multiplication of paramOne and paramTwo
        """
        try:
            a = float(self._properties['Option 4'])
        except ValueError:
            a = 1.0
        return paramOne * paramTwo * a
    

    def IsBroken(self) -> bool:
        return False

    def Dispose(self) -> None:
        logging.getLogger('ecu.test').info(f'{self.GetToolName()} detached')
        pass


class VariableInfo(TypedDict):
    """
    Set of variable specific information that must or can be provided.
    """

    Type: Literal['Signal', 'Parameter']
    """
    Type of the variable.

      * Signal: Variable is read-only
      * Parameter: Variable can be read and written
    """
    Representation: Literal['Physical', 'Text']
    """
    Representation of the variable value.
    """
    Unit: NotRequired[str]
    """
    Unit of the variable.

    Default: ``None``
    """
    Description: NotRequired[str]
    """
    Description of the variable.

    Default: ``None``
    """


class Variable(TypedDict):
    Info: VariableInfo
    Value: str | int | float | bool


class ExampleUserModelPort:
    """
    Example implementation of a port with type 'MODEL'.

    This port implements MODELACCESS functionality. It can be used to read, write and record
    variables.
    """

    def __init__(self, tool: ExampleUserTool, properties: dict[str, str | bool]) -> None:
        """
        :param tool: Tool which provides this port. Can be used to query the properties of
                     the tool, for example.
        :param properties: Dictionary with the properties from the test bench configuration for
                           this port and the configured values. The possible properties are
                           defined by the return value of the :func:`GetProperties` method.
        """
        self._properties = properties    
        self._stepSize: float = float(properties['Simulation step size'])
        self._AppNameDict = {self._properties['1'] : 1 , self._properties['2']:2 , self._properties['3'] : 3 ,  self._properties['4'] : 4 , self._properties['5'] : 5 , self._properties['6'] : 6 , self._properties['7'] : 7 , self._properties['8'] : 8, self._properties['9'] : 9 } 

        self._variableDescriptions: dict[str, Variable] =  self.GetParametersDetails()
            # 'APP1#MEAS#VRESS': {
            #     'Info': {'Type': 'Signal', 'Representation': 'Physical'},
            #     'Value': 0,
            # },
            # 'APP1#SCALAR#VpCaliperFRawMax': {
            #     'Info': {'Type': 'Parameter', 'Representation': 'Physical'},
            #     'Value': 0,
            # },
            # 'Variables#PhysSignal': {
            #     'Info': {'Type': 'Signal', 'Representation': 'Physical'},
            #     'Value': 0,
            # },
            # 'Variables#PhysParameter': {
            #     'Info': {'Type': 'Parameter', 'Representation': 'Physical'},
            #     'Value': 0,
            # },
            # 'Variables#TextSignal': {
            #     'Info': {'Type': 'Signal', 'Representation': 'Text'},
            #     'Value': '',
            # },
        
        self._registeredVariables: set[str] = set()
        self._variables: dict[str, int | float | str | bool] = {
            k: v['Value'] for k, v in self._variableDescriptions.items()
        }
        self._acquisitionRates: list[str] = ['1Hz', '10Hz']


    def GetParametersDetails(self) -> dict[str, Variable]:
        # AppParameter.APPi [0-4]. ParameterNameList/ParameterCount
        #              <LIST>
        # * APPi[0] - MEAS
        # * APPi[1] - SCALAR
        # * APPi[2] - ONEAXIS
        # * APPi[3] - TWOAXIS
        # * APPi[4] - ARRAY
        MEAS = 0
        SCALAR = 1
        ONEAXIS = 2
        TWOAXIS = 3
        ARRAY = 4 

        ParamDataStruct = SysMon.GetParameterDetails()
        ParamaDict = {}
        #print(result1.APP1[0].MEAS.ParameterNameList[i])
        APP1MEAS = ParamDataStruct.APP1[MEAS].ParameterNameList
        APP1MEASCount = ParamDataStruct.APP1[MEAS].ParameterCount
        for i in range(0,APP1MEASCount):
            ParamaDict.update({'APP1_Input#MEAS#'+str(APP1MEAS[i]) : {'Info': {'Type': 'Signal', 'Representation': 'Text'},'Value': 0}})
        
        APP1MEAS = ParamDataStruct.APP1[SCALAR].ParameterNameList
        APP1MEASCount = ParamDataStruct.APP1[SCALAR].ParameterCount
        for i in range(0,APP1MEASCount):
            ParamaDict.update({'APP1_Input#SCALAR#'+str(APP1MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP1MEAS = ParamDataStruct.APP1[ONEAXIS].ParameterNameList
        APP1MEASCount = ParamDataStruct.APP1[ONEAXIS].ParameterCount
        for i in range(0,APP1MEASCount):
            ParamaDict.update({'APP1_Input#1AXIS#'+str(APP1MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP1MEAS = ParamDataStruct.APP1[TWOAXIS].ParameterNameList
        APP1MEASCount = ParamDataStruct.APP1[TWOAXIS].ParameterCount
        for i in range(0,APP1MEASCount):
            ParamaDict.update({'APP1_Input#2AXIS#'+str(APP1MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP1MEAS = ParamDataStruct.APP1[ARRAY].ParameterNameList
        APP1MEASCount = ParamDataStruct.APP1[ARRAY].ParameterCount
        for i in range(0,APP1MEASCount):
            ParamaDict.update({'APP1_Input#ARRAY#'+str(APP1MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})



        APP2MEAS = ParamDataStruct.APP2[MEAS].ParameterNameList
        APP2MEASCount = ParamDataStruct.APP2[MEAS].ParameterCount
        for i in range(0,APP2MEASCount):
            ParamaDict.update({'APP2_System#MEAS#'+str(APP2MEAS[i]) : {'Info': {'Type': 'Signal', 'Representation': 'Text'},'Value': 0}})
        
        APP2MEAS = ParamDataStruct.APP2[SCALAR].ParameterNameList
        APP2MEASCount = ParamDataStruct.APP2[SCALAR].ParameterCount
        for i in range(0,APP2MEASCount):
            ParamaDict.update({'APP2_System#SCALAR#'+str(APP2MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP2MEAS = ParamDataStruct.APP2[ONEAXIS].ParameterNameList
        APP2MEASCount = ParamDataStruct.APP2[ONEAXIS].ParameterCount
        for i in range(0,APP2MEASCount):
            ParamaDict.update({'APP2_System#1AXIS#'+str(APP2MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP2MEAS = ParamDataStruct.APP2[TWOAXIS].ParameterNameList
        APP2MEASCount = ParamDataStruct.APP2[TWOAXIS].ParameterCount
        for i in range(0,APP2MEASCount):
            ParamaDict.update({'APP2_System#2AXIS#'+str(APP2MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP2MEAS = ParamDataStruct.APP2[ARRAY].ParameterNameList
        APP2MEASCount = ParamDataStruct.APP2[ARRAY].ParameterCount
        for i in range(0,APP2MEASCount):
            ParamaDict.update({'APP2_System#ARRAY#'+str(APP2MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})

        APP3MEAS = ParamDataStruct.APP3[MEAS].ParameterNameList
        APP3MEASCount = ParamDataStruct.APP3[MEAS].ParameterCount
        for i in range(0,APP3MEASCount):
            ParamaDict.update({'APP3_Models#MEAS#'+str(APP3MEAS[i]) : {'Info': {'Type': 'Signal', 'Representation': 'Text'},'Value': 0}})
        
        APP3MEAS = ParamDataStruct.APP3[SCALAR].ParameterNameList
        APP3MEASCount = ParamDataStruct.APP3[SCALAR].ParameterCount
        for i in range(0,APP3MEASCount):
            ParamaDict.update({'APP3_Models#SCALAR#'+str(APP3MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP3MEAS = ParamDataStruct.APP3[ONEAXIS].ParameterNameList
        APP3MEASCount = ParamDataStruct.APP3[ONEAXIS].ParameterCount
        for i in range(0,APP3MEASCount):
            ParamaDict.update({'APP3_Models#1AXIS#'+str(APP3MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP3MEAS = ParamDataStruct.APP3[TWOAXIS].ParameterNameList
        APP3MEASCount = ParamDataStruct.APP3[TWOAXIS].ParameterCount
        for i in range(0,APP3MEASCount):
            ParamaDict.update({'APP3_Models#2AXIS#'+str(APP3MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP3MEAS = ParamDataStruct.APP3[ARRAY].ParameterNameList
        APP3MEASCount = ParamDataStruct.APP3[ARRAY].ParameterCount
        for i in range(0,APP3MEASCount):
            ParamaDict.update({'APP3_Models#ARRAY#'+str(APP3MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})



        APP4param = ParamDataStruct.APP4[MEAS].ParameterNameList
        APP4paramCount = ParamDataStruct.APP4[MEAS].ParameterCount
        for i in range(0,APP4paramCount):
            ParamaDict.update({'APP4_Energy#MEAS#'+str(APP4param[i]) : {'Info': {'Type': 'Signal', 'Representation': 'Text'},'Value': 0}})
 
        APP4param = ParamDataStruct.APP4[SCALAR].ParameterNameList
        APP4paramCount = ParamDataStruct.APP4[SCALAR].ParameterCount
        for i in range(0,APP4paramCount):
            ParamaDict.update({'APP4_Energy#SCALAR#'+str(APP4param[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})

        APP4param = ParamDataStruct.APP4[ONEAXIS].ParameterNameList
        APP4paramCount = ParamDataStruct.APP4[ONEAXIS].ParameterCount
        for i in range(0,APP4paramCount):
            ParamaDict.update({'APP4_Energy#1AXIS#'+str(APP4param[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})

        APP4param = ParamDataStruct.APP4[TWOAXIS].ParameterNameList
        APP4paramCount = ParamDataStruct.APP4[TWOAXIS].ParameterCount
        for i in range(0,APP4paramCount):
            ParamaDict.update({'APP4_Energy#2AXIS#'+str(APP4param[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
            
        APP4param = ParamDataStruct.APP4[ARRAY].ParameterNameList
        APP4paramCount = ParamDataStruct.APP4[ARRAY].ParameterCount
        for i in range(0,APP4paramCount):
            ParamaDict.update({'APP4_Energy#ARRAY#'+str(APP4param[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})




        APP5MEAS = ParamDataStruct.APP5[MEAS].ParameterNameList
        APP5MEASCount = ParamDataStruct.APP5[MEAS].ParameterCount
        for i in range(0,APP5MEASCount):
            ParamaDict.update({'APP5_Performance#MEAS#'+str(APP5MEAS[i]) : {'Info': {'Type': 'Signal', 'Representation': 'Text'},'Value': 0}})
        
        APP5MEAS = ParamDataStruct.APP5[SCALAR].ParameterNameList
        APP5MEASCount = ParamDataStruct.APP5[SCALAR].ParameterCount
        for i in range(0,APP5MEASCount):
            ParamaDict.update({'APP5_Performance#SCALAR#'+str(APP5MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP5MEAS = ParamDataStruct.APP5[ONEAXIS].ParameterNameList
        APP5MEASCount = ParamDataStruct.APP5[ONEAXIS].ParameterCount
        for i in range(0,APP5MEASCount):
            ParamaDict.update({'APP5_Performance#1AXIS#'+str(APP5MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP5MEAS = ParamDataStruct.APP5[TWOAXIS].ParameterNameList
        APP5MEASCount = ParamDataStruct.APP5[TWOAXIS].ParameterCount
        for i in range(0,APP5MEASCount):
            ParamaDict.update({'APP5_Performance#2AXIS#'+str(APP5MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP5MEAS = ParamDataStruct.APP5[ARRAY].ParameterNameList
        APP5MEASCount = ParamDataStruct.APP5[ARRAY].ParameterCount
        for i in range(0,APP5MEASCount):
            ParamaDict.update({'APP5_Performance#ARRAY#'+str(APP5MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})


        APP6MEAS = ParamDataStruct.APP6[MEAS].ParameterNameList
        APP6MEASCount = ParamDataStruct.APP6[MEAS].ParameterCount
        for i in range(0,APP6MEASCount):
            ParamaDict.update({'APP6_Control#MEAS#'+str(APP6MEAS[i]) : {'Info': {'Type': 'Signal', 'Representation': 'Text'},'Value': 0}})
        
        APP6MEAS = ParamDataStruct.APP6[SCALAR].ParameterNameList
        APP6MEASCount = ParamDataStruct.APP6[SCALAR].ParameterCount
        for i in range(0,APP6MEASCount):
            ParamaDict.update({'APP6_Control#SCALAR#'+str(APP6MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP6MEAS = ParamDataStruct.APP6[ONEAXIS].ParameterNameList
        APP6MEASCount = ParamDataStruct.APP6[ONEAXIS].ParameterCount
        for i in range(0,APP6MEASCount):
            ParamaDict.update({'APP6_Control#1AXIS#'+str(APP6MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP6MEAS = ParamDataStruct.APP6[TWOAXIS].ParameterNameList
        APP6MEASCount = ParamDataStruct.APP6[TWOAXIS].ParameterCount
        for i in range(0,APP6MEASCount):
            ParamaDict.update({'APP6_Control#2AXIS#'+str(APP6MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP6MEAS = ParamDataStruct.APP6[ARRAY].ParameterNameList
        APP6MEASCount = ParamDataStruct.APP6[ARRAY].ParameterCount
        for i in range(0,APP6MEASCount):
            ParamaDict.update({'APP6_Control#ARRAY#'+str(APP6MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})  

        APP7MEAS = ParamDataStruct.APP7[MEAS].ParameterNameList
        APP7MEASCount = ParamDataStruct.APP7[MEAS].ParameterCount
        for i in range(0,APP7MEASCount):
            ParamaDict.update({'APP7_Driver#MEAS#'+str(APP7MEAS[i]) : {'Info': {'Type': 'Signal', 'Representation': 'Text'},'Value': 0}})
        
        APP7MEAS = ParamDataStruct.APP7[SCALAR].ParameterNameList
        APP7MEASCount = ParamDataStruct.APP7[SCALAR].ParameterCount
        for i in range(0,APP7MEASCount):
            ParamaDict.update({'APP7_Driver#SCALAR#'+str(APP7MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP7MEAS = ParamDataStruct.APP7[ONEAXIS].ParameterNameList
        APP7MEASCount = ParamDataStruct.APP7[ONEAXIS].ParameterCount
        for i in range(0,APP7MEASCount):
            ParamaDict.update({'APP7_Driver#1AXIS#'+str(APP7MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP7MEAS = ParamDataStruct.APP7[TWOAXIS].ParameterNameList
        APP7MEASCount = ParamDataStruct.APP7[TWOAXIS].ParameterCount
        for i in range(0,APP7MEASCount):
            ParamaDict.update({'APP7_Driver#2AXIS#'+str(APP7MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP7MEAS = ParamDataStruct.APP7[ARRAY].ParameterNameList
        APP7MEASCount = ParamDataStruct.APP7[ARRAY].ParameterCount
        for i in range(0,APP7MEASCount):
            ParamaDict.update({'APP7_Driver#ARRAY#'+str(APP7MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})  



        APP8MEAS = ParamDataStruct.APP8[MEAS].ParameterNameList
        APP8MEASCount = ParamDataStruct.APP8[MEAS].ParameterCount
        for i in range(0,APP8MEASCount):
            ParamaDict.update({'APP8_Output#MEAS#'+str(APP8MEAS[i]) : {'Info': {'Type': 'Signal', 'Representation': 'Text'},'Value': 0}})
        
        APP8MEAS = ParamDataStruct.APP8[SCALAR].ParameterNameList
        APP8MEASCount = ParamDataStruct.APP8[SCALAR].ParameterCount
        for i in range(0,APP8MEASCount):
            ParamaDict.update({'APP8_Output#SCALAR#'+str(APP8MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP8MEAS = ParamDataStruct.APP8[ONEAXIS].ParameterNameList
        APP8MEASCount = ParamDataStruct.APP8[ONEAXIS].ParameterCount
        for i in range(0,APP8MEASCount):
            ParamaDict.update({'APP8_Output#1AXIS#'+str(APP8MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP8MEAS = ParamDataStruct.APP8[TWOAXIS].ParameterNameList
        APP8MEASCount = ParamDataStruct.APP8[TWOAXIS].ParameterCount
        for i in range(0,APP8MEASCount):
            ParamaDict.update({'APP8_Output#2AXIS#'+str(APP8MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP8MEAS = ParamDataStruct.APP8[ARRAY].ParameterNameList
        APP8MEASCount = ParamDataStruct.APP8[ARRAY].ParameterCount
        for i in range(0,APP8MEASCount):
            ParamaDict.update({'APP8_Output#ARRAY#'+str(APP8MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})  
        
        

        APP9MEAS = ParamDataStruct.APP9[MEAS].ParameterNameList
        APP9MEASCount = ParamDataStruct.APP9[MEAS].ParameterCount
        for i in range(0,APP9MEASCount):
            ParamaDict.update({'VCU500BIOS#MEAS#'+str(APP9MEAS[i]) : {'Info': {'Type': 'Signal', 'Representation': 'Text'},'Value': 0}})
        
        APP9MEAS = ParamDataStruct.APP9[SCALAR].ParameterNameList
        APP9MEASCount = ParamDataStruct.APP9[SCALAR].ParameterCount
        for i in range(0,APP9MEASCount):
            ParamaDict.update({'VCU500BIOS#SCALAR#'+str(APP9MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP9MEAS = ParamDataStruct.APP9[ONEAXIS].ParameterNameList
        APP9MEASCount = ParamDataStruct.APP9[ONEAXIS].ParameterCount
        for i in range(0,APP9MEASCount):
            ParamaDict.update({'VCU500BIOS#1AXIS#'+str(APP9MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP9MEAS = ParamDataStruct.APP9[TWOAXIS].ParameterNameList
        APP9MEASCount = ParamDataStruct.APP9[TWOAXIS].ParameterCount
        for i in range(0,APP9MEASCount):
            ParamaDict.update({'VCU500BIOS#2AXIS#'+str(APP9MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})
        APP9MEAS = ParamDataStruct.APP9[ARRAY].ParameterNameList
        APP9MEASCount = ParamDataStruct.APP9[ARRAY].ParameterCount
        for i in range(0,APP9MEASCount):
            ParamaDict.update({'VCU500BIOS#ARRAY#'+str(APP1MEAS[i]) : {'Info': {'Type': 'Parameter', 'Representation': 'Physical'},'Value': 0}})  







        return ParamaDict


    @classmethod
    def GetPortType(cls) -> str:
        """
        Returns the type of the port. This type defines which interface the port must fulfill and
        therefore which range of functions it offers. Valid types are

          * BASE (must fulfill the
            :class:`~tts.core.toolingFramework.userTool.interfaces.UserPort.UserPort`
            interface)
          * IMAGE (must fulfill the
            :class:`~tts.core.toolingFramework.userTool.interfaces.UserImagePort.UserImagePort`
            interface)
          * MODEL (must fulfill the
            :class:`~tts.core.toolingFramework.userTool.interfaces.UserModelPort.UserModelPort`
            interface)

        :return: Type of the port.
        """
        return 'MODEL'

    @classmethod
    def GetProperties(cls) -> dict[str, dict]:
        """
        Properties of the port. These properties can be configured in the testbench configuration.
        The configured properties are passed to the user port when the configuration is started.
        Available property types are STRING, BOOL and CHOICE. Properties may be sorted into groups
        to improve visual separation in the test bench configuration.

        Example:

        .. code-block:: python

            @classmethod
            def GetProperties(cls) -> dict[str, dict]:
                return {
                    'Group 1': {
                        'Option 1': {
                            'Description': 'This is Option 1',
                            'Type': 'STRING',
                            'Default': 'default value',
                        },
                        'Option 2': {
                            'Description': 'This is Option 2',
                            'Type': 'BOOL',
                            'Default': True,
                        },
                        'Option 3': {
                            'Description': 'This is Option 3',
                            'Type': 'CHOICE',
                            'Choices': ['c1', 'c2', 'c3'],
                            'Default': 'c2',
                        },
                    }
                }

        :return: Dictionary with properties of the user port.
        """
        return {
            'Simulation step size': {
                'Description': 'The used simulation step size in seconds',
                'Type': 'STRING',
                'Default': '0.1',
            },
             
            'Application Name Details':
            {
                '1': {
                    'Description': 'Name of APP1',
                    'Type': 'STRING',
                    'Default': 'APP1_Input',
                },
                '2': {
                    'Description': 'Name of APP2',
                    'Type': 'STRING',
                    'Default': 'APP2_System',
                },
                '3': {
                    'Description': 'Name of APP3',
                    'Type': 'STRING',
                    'Default': 'APP3_Models',
                },
                '4': {
                    'Description': 'Name of APP4',
                    'Type': 'STRING',
                    'Default': 'APP4_Energy',
                },
                '5': {
                    'Description': 'Name of APP5',
                    'Type': 'STRING',
                    'Default': 'APP5_Performance',
                },
                '6': {
                    'Description': 'Name of APP6',
                    'Type': 'STRING',
                    'Default': 'APP6_Control',
                },
                '7': {
                    'Description': 'Name of APP7',
                    'Type': 'STRING',
                    'Default': 'APP7_Driver',
                },
                '8': {
                    'Description': 'Name of APP8',
                    'Type': 'STRING',
                    'Default': 'APP8_Output',
                },
                '9': {
                    'Description': 'Name of APP9',
                    'Type': 'STRING',
                    'Default': 'VCU500BIOS',
                }
            }
        }

    def Dispose(self) -> None:
        """
        Called on port shutdown. This can be used to stop any external tool needed by this port.
        Can be omitted if no external tool ist used.
        """
        
    @classmethod
    @optional
    def GetPathDelimiter(cls) -> str:
        """
        Character or string to be used for splitting the variable path into its components.

        Example:

          * Delimiter:  ``#``
          * Path:       ``A#B#C``
          * Components: ``A``, ``B``, ``C``

        If this method is not implemented, ``/`` is used as the default delimiter.

        :return: Delimiting character or string
        """
        return '#'

    @classmethod
    @optional
    def GetRecorder(cls) -> type[ExampleUserRecorder]:
        """
        Class which takes care of the recording of one or more variables.

        :return: Class which fulfills the
                 :class:`~tts.core.toolingFramework.userTool.interfaces.UserRecorder.UserRecorder`
                 interface
        """
        return ExampleUserRecorder

    @classmethod
    @optional
    def GetSimulationManager(cls) -> type[ExampleUserSimulationManager]:
        """
        Class that manages the simulation.

        :return: Class which fulfills the
                 :class:`~tts.core.toolingFramework.userTool.interfaces.UserSimulationManager.UserSimulationManager`
                 interface
        """
        return ExampleUserSimulationManager

    @optional
    def GetAcquisitionRates(self) -> list[str]:
        """
        :return: List of available acquisition rates
        """
        return self._acquisitionRates

    @optional
    def GetDefaultAcquisitionRate(self) -> str:
        """
        :return: Default acquisition rate
        """
        return self._acquisitionRates[0]

    @optional
    def GetVariablesHash(self) -> str:
        """
        This hash is intended to provide information on whether the list of variables for this
        port has changed. The hash is used to decide whether the created cache of model variables
        needs to be recreated.

        If this method is not implemented, the available variables are queried each time the
        configuration is started.

        :return: Hash that represents all variables
        """
        # create md5 hash from variable description
        md5 = hashlib.md5()
        md5.update(json.dumps(self._variableDescriptions).encode('utf-8'))
        return md5.hexdigest()

    def GetVariables(self) -> dict[str, VariableInfo]:
        """
        Returns all available variables of the port.

        The key of the dictionary must be the path of the variable.

        The value of the dictionary contains information about the variable.

        Example:

        .. code-block:: python

            {
                'a/b/c/var': {
                    'Type': 'Signal',
                    'Representation': 'Physical',
                    'Unit': 'km/h'
                }
            }

        :return: All Variables
        """
        return {k: v['Info'] for k, v in self._variableDescriptions.items()}

    @optional
    def RegisterVariable(self, path: str) -> None:
        """
        This method is called for each variable that is used in a test case.
        It is called before the test case execution.

        :param path: Path of the variable that is used
        """
        self._registeredVariables.add(path)

    @optional
    def UnregisterVariable(self, path: str) -> None:
        """
        This method is called for each variable that was used in a test case.
        It is called after the test case has been executed.

        :param path: Path of the variable that was used
        """
        self._registeredVariables.remove(path)

    def Read(self, path: str) -> str | int | float | bool:
        """
        This method is called to read the value of a variable.

        .. note:: Currently only scalar values are supported.

        :param path: Path of the variable
        :return: Current value of the variable
        """
        
        (app,type,parameter)=path.split('#')
        
        if (type  in ['MEAS', 'SCALAR']):
            val = SysMon.GetStringValueMeasurement(int(self._AppNameDict[app]),parameter)
            if (val in ['YES', 'NO']):
                if val == 'NO':
                    val = -1
                elif val=='YES': # list complete(?)
                    val = 1
            else:
                try: 
                    val = float(val)
                except:
                    logging.getLogger('ecu.test').error(f"Read Error : Cannot Convert value to float for {parameter} from app number {app} result Value: {val}")
        
        elif (type  in ['1AXIS', '2AXIS', 'ARRAY']):
            if(type == '1AXIS'):
                val = SysMon.GetStringValue1AxisMap(int(self._AppNameDict[app]),parameter)

            pass # keeping string for now

        return val   # self._variables[path]

    def Write(self, path: str, value: str | int | float | bool) -> None:
        """
        This method is called to write the value of a variable.

        .. note:: Currently only scalar values are supported.

        :param path: Path of the variable
        :param value: Value to be written
        """
        (app,type,parameter)=path.split('#')
        if (type == 'MEAS'):
            logging.getLogger('ecu.test').error(f"Write Error : Cannot write in to a 'MEASUREMENT PARAM' param: {parameter} from app number {app}")
            return None

        elif (type  == 'SCALAR'):
            SysMon.SetStringValueScalar(int(self._AppNameDict[app]),str(parameter),str(value))

        self._variables[path] = value

        

    def GetStepSize(self) -> float:
        return self._stepSize


class RecordingVariable(TypedDict):
    Path: str
    AcquisitionRate: str


class ExampleUserRecorder:
    """
    Describes the interface of a user recorder.
    Is used to record one or more variables.
    """

    def __init__(self, port: ExampleUserModelPort, variables: list[RecordingVariable]) -> None:
        """
        :param port: Port providing this user recorder. Can be used to query the properties of
                     the port, for example.
        :param variables: Variables to be recorded by this recorder.
        """

    def Start(self) -> None:
        """
        Starts the recording of all variables of the recorder.
        Can be called several times in a test case.
        """
        # Here you should tell your simulation tool to start recording

    def Stop(self) -> list[str]:
        """
        Stops the recording of all variables of the recorder.
        Can be called several times in a test case.

        :return: List with paths to the recording files
        """
        # Here you should tell your simulation tool to stop recording
        return ['recorded_file01.csv', 'recorded_file02.csv']

    @optional
    def Dispose(self) -> None:
        """
        Ends the recorder gracefully.

        Is called when the recorder is no longer in use.
        """


class ExampleUserSimulationManager:
    """
    Describes the interface of a user simulation manager.
    Is used to manage the simulation. Currently, the example only implements continuous simulation
    mode.
    """

    def __init__(self, port: ExampleUserModelPort) -> None:
        """
        :param port: Port providing this user simulation manager. Can be used to query the
                     properties of the port, for example.
        """
        self._port = port
        self._stepSize = port.GetStepSize()
        self._updateTime: Callable[[int | float], None] | None = None
        self._stopped: Event = Event()
        self._sim: Thread | None = None

    def GetTime(self) -> float:
        """
        Returns the current simulation time.

        :return: Simulation time in **seconds**
        """
        return time.monotonic()

    @optional
    def Step(self, timeDelta: float) -> None:
        """
        Executes a sufficient number of simulation steps to increase the simulation time by the
        given time delta.

        .. note:: This method must be implemented to support the stepwise execution in
                  simulation time.

        :param timeDelta: Time delta in **seconds** by which the simulation time will be increased.
        """

    @optional
    def SetUpdateTimeCallback(self, callback: Callable[[int | float], None]) -> None:
        """
        The callback passed to this method can be used to send an update of the simulation time in
        **seconds** to ecu.test.

        .. note:: This method must be implemented to support the continuous execution in
                  simulation time.

        For example, this method can be executed for every simulation step. However, this
        method can also be executed only every nth simulation step, for example to reduce the load.

        It is important to note that ecu.test expects an update every 120 seconds at the latest
         (real time).

        :param callback: Function with an input parameter. The current simulation time in
                         **seconds** must be passed to this function.
        """
        self._updateTime = callback

    @optional
    def Start(self) -> None:
        """
        Starts the simulation.

        .. note:: This method must be implemented to support the continuous execution in
                  simulation time.
        """
        self.Pause()
        self._stopped.clear()
        self._sim = Thread(name='ExampleUserSimulationManager', target=self._Run, daemon=True)
        self._sim.start()

    @optional
    def Pause(self) -> None:
        """
        Pauses the simulation.
        """
        if self._sim is not None and self._sim.is_alive():
            self._stopped.set()
            self._sim.join(self._stepSize * 3)

    @optional
    def Dispose(self) -> None:
        """
        Gracefully terminates the simulation.

        Is called when the configuration is stopped.
        """
        self.Pause()

    def _Run(self) -> None:
        while not self._stopped.is_set():
            if self._updateTime is not None:
                self._updateTime(time.monotonic())
            time.sleep(self._stepSize)
