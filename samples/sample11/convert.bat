@ECHO OFF

SETLOCAL

call commonEnv.bat

set JAVA_HOME=..\..\java\jre

rem Command line parameters are as follows
rem -s represents source. Valid values are 
rem	OS - Object Structure 
rem	PH - Publish Channel 
rem	ES - Enterprise Service 
rem	IC - Invocation Channel 
rem	WS - Web Service Registry 
rem	EP - End Point
rem	EX - External System
rem	TABLE - Table
rem	BYOS - All objects for the Object Structure (have to have same where caluse)
rem -n represents name (os name, es name, interaction name, table name ...). For multiple names use "," separation
rem -x represents external system name (for es and ph).
rem -w represents where clause (for table and byos).
rem -f represents file name. Must end with .ora, .sqs, .db2, .sql, .dbc. For dbc scripts use .dbc
rem -p represents the password - value must be the password to access the e-mail account
rem -p represents the tenant code - value must be the tenant code for consultant users in MT
rem -u represents the  user - value must be a valid e-mail account name
rem -h represents host name (if not used will use localhost)
rem -a represents use header. Do you want to create sigoption header. If multiple interaction for one application. Header need to be created only once
rem -r name of resource type when creating JSON resource (if specified resourcetype statemens will be created. Specify 0 if you do npot want to create resource type)
rem -y add delete statement before insert
rem -g for SIGOPTION grant application name
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sOS -nMXAPIASSET -y1 -fendpoint.dbc -umxintadm -pmxintadm -hlocalhost -t00
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sPH -nMXPOInterface,MXPRInterface -xEXTSYS1 -ftest.dbc -uwilson -pwilson -hlocalhost -t00
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sES -nIOTFASSET -xIOTFSYNC -fiotf.dbc -y1 -uwilson -pwilson -hlocalhost -t00
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sEX -nIOTFSYNC -fiotf.dbc -uwilson -y1 -pwilson -hlocalhost -t00
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sWS -nMXPO -ftest.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sEP -nMXXMLFILE -ftest.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sINT -nECRI -a0 -fecri1.dbc -uwilson -pwilson
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nAPPLICATIONAUTH -w"app='MXAPIWODETAIL' and optionname = 'INSERT'" -y1 -d1 -fauth.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nIOTFCFG -w"1=1" -y1 -fyajin1.sql -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nIOTFDEVICEMAPPING -w"1=1" -y1 -fyajin2.sql -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sBYOS -nMXJSONMAPPING -w"mapname='WEATHERALERT'" -y1 -d0 -fmap.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sBYOS -nMXOPERLOC -wsiteid='BEDFORD' -d0 -floc.sql -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sJSONRES -nHISTORIAN -fhist.dbc -y1 -uwilson -pwilson
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sJSONMAP -nLAYER16IN -flayer16.dbc -y1 -uwilson -pwilson


rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nASSETATTRIBUTE -w"assetattrid = 'MFGLIFE'" -y1 -d1 -fattr.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sBYOS -nMXCLASSIFICATION -w"classstructureid = '157937'" -y1 -d1 -fspec.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nMAXRELATIONSHIP -w"name in ('TEMPMETER', 'MFGLIFE')" -y1 -d1 -frel.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nQUERY -w"clausename in ('Bad Actor - LTD Cost', 'METERSALARMLEVEL')" -y1 -d1 -fquery.dbc -uwilson -pwilson -hlocalhost

rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nLOCATIONS -w"location like 'PUMPHOUSE%%'" -y1 -d1 -floc.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nLOCATIONS -w"location like 'WELL FIELD%%'" -y1 -d1 -floc1.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nLOCATIONS -w"location = 'TWC'" -y1 -d1 -floc2.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nLOCOPER -w"location like 'PUMPHOUSE%%'" -y1 -d1 -flocoper.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nLOCOPER -w"location like 'WELL FIELD%%'" -y1 -d1 -flocoper1.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nLOCOPER -w"location = 'TWC'" -y1 -d1 -flocoper2.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nMAXENDPOINTDTL -w"endpointname = 'IOTHISTCLOUD'" -y1 -d1 -fdet.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nLOCHIERARCHY -w"systemid = 'WATER'" -y1 -d1 -flochier.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nLOCSTATUS -w"location like 'PUMPHOUSE%%'" -y1 -d1 -flocstat.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nLOCSTATUS -w"location like 'WELL FIELD%%'" -y1 -d1 -flocstat1.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nLOCSTATUS -w"location = 'TWC'" -y1 -d1 -flocstat2.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nLOCSYSTEM -w"systemid = 'WATER'" -y1 -d1 -flocsys.dbc -uwilson -pwilson -hlocalhost

rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nASSET -w"assetnum like 'AH%%'" -y1 -d1 -fasset.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nASSETSPEC -w"assetnum like 'AH%%'" -y1 -d1 -fassetspec.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nASSETSPECHIST -w"assetnum like 'AH%%'" -y1 -d1 -fassethist.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sTABLE -nASSETMETER -w"assetnum like 'AH%%'" -y1 -d1 -fassetmeter.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sSTART -ftest.dbc -uwilson -pwilson -hlocalhost
rem %JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sEND -nALL -y1 -d1 -fsteve.dbc -uwilson -pwilson -hlocalhost
