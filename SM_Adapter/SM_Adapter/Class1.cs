using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using SystemMonitor;
using System.Security.Cryptography;
using System.Xml.Linq;
using System.Diagnostics.CodeAnalysis;


namespace SM_Adapter
{
    public class SM_Adapter
    {
        public List<int> GetAPPId(int app)
        {
            List<int> result = new List<int>();

            //create a new instance of the System Monitor API
            TSysMonApi sysMonApi = new TSysMonApi();

            short x = Convert.ToInt16(app);
            //try to perform the MATLAB import
            result.Add(sysMonApi.GetActiveApp(x));

            return result;
        }


        public List<int> GetAppIDs()
        {

            List<int> appIDs = new List<int>();
            List<string> appNames = new List<string>();

            // Create an instance of the System Monitor API
            TSysMonApi sysMonApi = new TSysMonApi();

            try
            {
                object appIdObject = null;
                object appNameObject = null;

                // Call the GetAppDetails method from the API
                int result = sysMonApi.GetAppDetails(ref appIdObject, ref appNameObject);

                if (result == 0 && appIdObject is Array && appNameObject is Array)
                {
                    foreach (object id in (Array)appIdObject)
                    {
                        appIDs.Add(Convert.ToInt32(id));
                    }
                }
                else
                {
                    Console.WriteLine("Error occurred: " + result);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An exception occurred: " + ex.Message);
            }
            return (appIDs);
        }

        public List<string> GetAppNames()
        {
            List<int> appIDs = new List<int>();
            List<string> appNames = new List<string>();

            // Create an instance of the System Monitor API
            TSysMonApi sysMonApi = new TSysMonApi();

            try
            {
                object appIdObject = null;
                object appNameObject = null;

                int result = sysMonApi.GetAppDetails(ref appIdObject, ref appNameObject);
                if (result == 0 && appIdObject is Array && appNameObject is Array)
                {

                    foreach (object name in (Array)appNameObject)
                    {
                        appNames.Add(Convert.ToString(name));
                    }
                }
                else
                {
                    Console.WriteLine("Error occurred: " + result);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An exception occurred: " + ex.Message);
            }

            return (appNames);
        }


        //self.sm.ImportProject(str(importPath), base)

        public int ImportProject(string ImportSlxPath,string CustomerBasePath)
        {
            int result; // 0 - Sunccess
            TSysMonApi sysMonApi = new TSysMonApi();
            result = sysMonApi.ImportProject(Convert.ToString(ImportSlxPath), Convert.ToString(CustomerBasePath));
            return result;
        }

        //self.sm.OpenProject(str(importPath))
        public int OpenProject(string ProjectPath)
        {
            int result; // 0 - Sunccess
            TSysMonApi sysMonApi = new TSysMonApi();
            result = sysMonApi.OpenProject(Convert.ToString(ProjectPath));
            return result;
        }

        //(res) = self.sm.Reprogram(AppNo+12800)
        public int Reprogram_App(int AppNo)
        {
            int result; // 0 - Sunccess
            short ReproAppID;
            TSysMonApi sysMonApi = new TSysMonApi();
            List<int> AppIDs = GetAppIDs();
            ReproAppID = Convert.ToInt16( AppIDs[AppNo - 1]);  // Get appid for appno

            result = sysMonApi.Reprogram(ReproAppID);
            return result;
        }

        // SM_API.sm.GetStringValueMeasurement(app, parameter)

        //[int32 scalar RetVal, System.String pszApplicationName, System.Array str1xArrParameterIds, System.Array str1xArrParameterNames, int32 scalar pnParameterCount] GetParameterListByType(SystemMonitor.TSysMonApiClass this, int16 scalar wAppId, System.String pszParamType, System.String pszApplicationName, System.Array str1xArrParameterIds, System.Array str1xArrParameterNames)

        public string GetStringValueMeasurement(int AppNo, string ParameterName)
        {
            short AppID;
            string PrameterValue = "NoValueFetched";
            TSysMonApi sysMonApi = new TSysMonApi();
            List<int> AppIDs = GetAppIDs();
            AppID = Convert.ToInt16(AppIDs[AppNo - 1]);  // Get appid for appno

            sysMonApi.GetStringValueMeasurement(AppID, ParameterName, ref PrameterValue);

            return PrameterValue;
        }
        public List<string> GetStringValue1AxisMap(int AppNo, string ParameterName)
        {
            short AppID;
            object Pvalue = null;
            List<string> ParamValues = new List<string>();

            List<int> AppIDs = GetAppIDs();
            TSysMonApi sysMonApi = new TSysMonApi();

            AppID = Convert.ToInt16(AppIDs[AppNo - 1]);  // Get appid for appno

            
            int result = sysMonApi.GetStringValue1AxisMap(AppID, ParameterName, ref Pvalue);

            // Check if Pvalue is an array or a single object
            if (result == 0 && Pvalue is Array)
            {
                foreach (object p in (Array)Pvalue)
                {
                    ParamValues.Add(p.ToString());
                }
            }
            else if (result == 0 && Pvalue != null)
            {
                // If Pvalue is a single object, add it directly
                ParamValues.Add(Pvalue.ToString());
            }
            else
            {
                Console.WriteLine("Failed to retrieve values or invalid type for Pvalue.");
            }

            return ParamValues;
        }

        public List<List<string>> GetStringValue2AxisMap(int appNo, string parameterName)
        {
            short appId;
            object value = null;  // To store the 2D array of strings
            List<List<string>> paramValues = new List<List<string>>();

            List<int> appIDs = GetAppIDs();
            appId = Convert.ToInt16(appIDs[appNo - 1]);  // Get app ID for the specified app number

            TSysMonApi sysMonApi = new TSysMonApi();

            // Call the API to retrieve the parameter values
            int result = sysMonApi.GetStringValue2AxisMap(appId, parameterName, ref value);

            // Check if the function call succeeded and value is a 2D array
            if (result == 0 && value is Array array && array.Rank == 2)
            {
                int rows = array.GetLength(0);
                int cols = array.GetLength(1);

                for (int i = 0; i < rows; i++)
                {
                    List<string> rowValues = new List<string>();
                    for (int j = 0; j < cols; j++)
                    {
                        rowValues.Add(array.GetValue(i, j).ToString());
                    }
                    paramValues.Add(rowValues);
                }
            }
            else
            {
                Console.WriteLine("Failed to retrieve values or invalid type for value.");
            }

            return paramValues;
        }



        public int SetStringValueScalar(int appNo, string ParameterName, string NewVal)
        {
            List<int> appIDs = GetAppIDs();
            short appID = Convert.ToInt16(appIDs[appNo - 1]);  // Get app ID for the specified app number
            TSysMonApi sysMonApi  = new TSysMonApi();
            int result = sysMonApi.SetStringValueScalar(appID, Convert.ToString(ParameterName), Convert.ToString(NewVal));
            return result;
        }

        public AppParameters GetParameterDetails()
        {
            // Create an instance of sysmon
            TSysMonApi sysMonApi = new TSysMonApi();

            // 1. Map AppIDs to App Names
            List<int> AppIDs = GetAppIDs();
            List<string> appNamesList = GetAppNames();
            //Dictionary<int, string> appnNmeDict = AppIDs.Zip(appNamesList, (id, name) => new { id, name }).ToDictionary(x => x.id, x => x.name);

            // 2. Define Parameter Types
            string[] ParamTypeList = { "MEAS", "SCALAR", "1AXIS", "2AXIS", "ARRAY" };

            

            AppParameters appNameStruct = new AppParameters {
                APP1 = new List<ParameterNames> (),
                APP2 = new List<ParameterNames>(),
                APP3 = new List<ParameterNames>(),
                APP4 = new List<ParameterNames>(),
                APP5 = new List<ParameterNames>(),
                APP6 = new List<ParameterNames>(),
                APP7 = new List<ParameterNames>(),
                APP8 = new List<ParameterNames>(),
                APP9 = new List<ParameterNames>()
              
            };

            try
            {
                foreach (int app in AppIDs)
                {
                    //Console.WriteLine(app);
                    foreach (string paramtype in ParamTypeList)
                    {
                        
                        short appid = Convert.ToInt16(app);
                        // Variables to hold parameter data
                        string in_AppName;
                        int in_PrameterCount;
                        Array in_PrameterNames;
                        Array in_ParameterIDs;

                        //Console.WriteLine(in_AppName);
                        //Console.WriteLine(paramtype);
                        // Reset lists for each parameter type
                        List<string> paramIDs = new List<string>();
                        List<string> paramNames = new List<string>();

                        ParameterNames parameterNameStruct = new ParameterNames { ParameterNameList = new List<string>() , ParameterCount = 0};
                        ParameterType paramTypeStructForApp = new ParameterType();

                        int result = sysMonApi.GetParameterListByType(appid, paramtype, out in_AppName, out in_ParameterIDs, out in_PrameterNames, out in_PrameterCount);
                        if (result == 0)
                        {
                            
                            foreach (object id in in_ParameterIDs)
                            {

                                paramIDs.Add(id.ToString());
                            }

                            foreach (object name in in_PrameterNames)
                            {
                                //Console.WriteLine(name);
                                paramNames.Add(name.ToString());
                            }

                            parameterNameStruct.ParameterNameList = paramNames;
                            parameterNameStruct.ParameterCount = in_PrameterCount;

                            // Map paramtype to the ParameterType struct
                            //switch (paramtype)
                            //{
                            //    case "MEAS":
                            //        paramTypeStructForApp.MEAS = parameterNameStruct; Console.WriteLine("MEASUREMENT PARAMETERS"); break;
                            //    case "SCALAR": 
                            //        paramTypeStructForApp.SCALAR = parameterNameStruct; Console.WriteLine("SCALAR PARAMETERS"); break;
                            //    case "1AXIS": 
                            //        paramTypeStructForApp.ONEAXIS = parameterNameStruct; break;
                            //    case "2AXIS": 
                            //        paramTypeStructForApp.TWOAXIS = parameterNameStruct; break;
                            //    case "ARRAY": 
                            //        paramTypeStructForApp.ARRAY = parameterNameStruct; Console.WriteLine("ARRAY PARAMETERS"); break;
                            //    default:
                            //        Console.WriteLine("Unrecognized parameter type.");
                            //        continue;
                            //}
                        }

                        // Assign ParameterType to appNameStruct based on dictionary lookup
                        // !!!!!!!!!!!!!!!!!!!!!!!!  NOTICE  !!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        // Making the assumption of App names wont change in near feature

                        //if (appnNmeDict.TryGetValue(app, out string appName))
                        //{
                        switch (in_AppName)
                        {

                            /*
                             * Subscripting method - 
                             * APPi[0] - MEAS
                             * APPi[1] - SCALAR
                             * APPi[2] - ONEAXIS
                             * APPi[3] - TWOAXIS
                             * APPi[4] - ARRAY
                             */

                            case "APP1_Input": 
                                appNameStruct.APP1.Add(parameterNameStruct); break;
                            case "APP2_System": 
                                appNameStruct.APP2.Add(parameterNameStruct); break;
                            case "APP3_Models":
                                appNameStruct.APP3.Add(parameterNameStruct); break;
                            case "APP4_Energy":
                                appNameStruct.APP4.Add(parameterNameStruct); break;
                            case "APP5_Performance":
                                appNameStruct.APP5.Add(parameterNameStruct); break;
                            case "APP6_Control":
                                appNameStruct.APP6.Add(parameterNameStruct); break;
                            case "APP7_Driver":
                                appNameStruct.APP7.Add(parameterNameStruct); break;
                            case "APP8_Output":
                                appNameStruct.APP8.Add(parameterNameStruct); break;
                            case "VCU500BIOS":
                                appNameStruct.APP9.Add(parameterNameStruct); break;
                            default: 
                                Console.WriteLine("App name not found."); break;
                        }
                        //}
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An exception occurred: " + ex.Message);
            }


            // Final return to python
            return appNameStruct;
        }

        // Structs to organize parameter data
        public struct ParameterNames
        {
            public object ParameterNameList;
            public int ParameterCount;
        }

        public struct ParameterType
        {
            public ParameterNames MEAS;
            public ParameterNames SCALAR;
            public ParameterNames ONEAXIS;
            public ParameterNames TWOAXIS;
            public ParameterNames ARRAY;
        }

        public struct AppParameters
        {
            
            public List<ParameterNames> APP1;
            public List<ParameterNames> APP2;
            public List<ParameterNames> APP3;
            public List<ParameterNames> APP4;
            public List<ParameterNames> APP5;
            public List<ParameterNames> APP6;
            public List<ParameterNames> APP7;
            public List<ParameterNames> APP8;
            public List<ParameterNames> APP9;
        }


        //public struct FResult
        //{
        //    public string appName;
        //    public object paramIDs;
        //    public object paramNames;
        //    public int ParameterCount;
        //}

    }
}



