#!/bin/bash

./commonEnv.sh

export JAVA_HOME="../../java/jre"

# Command line parameter are as follows
# -s represents source. Valid values are 
#	OS - Object Structure 
#	PH - Publish Channel 
#	ES - Enterprise Service 
#	IC - Invocation Channel 
#	WS - Web Service Registry 
#	EP - End Point
#	EX - External System
#	TABLE - Table
#	BYOS - All objects for the Object Structure (have to have same where caluse)
#	WC - All objects to create new work center (the data does not need to exist in Maximo)
# -n represents name (os name, es name, interaction name, table name ...). For multiple names use "," separation
# -x represents external system name (for es and ph).
# -w represents where clause (for table and byos).
# -f represents file name. Must end with .ora, .sqs, .db2, .sql, .dbc. For dbc scripts use .dbc
# -p represents the password - value must be the password to access the e-mail account
# -p represents the tenant code - value must be the tenant code for consultant users in MT
# -u represents the  user - value must be a valid e-mail account name
# -p represents password
# -h represents host name (if not used will use localhost)
# -a represents use header. Do you want to create sigoption header. If multiple interaction for one application. Header need to be created only once
# -r name of resource type when creating JSON resource (if specified resourcetype statemens will be created. Specify 0 if you do npot want to create resource type)
# -y add delete statement before insert
# -g for SIGOPTION grant application name
# -b for Object Structure work center name
# -i for Object Structure SIGOPTION names (supported ALL and READ)
# -k for Object Structure authorization group name
# -0 for Work Center all Object Structures for this work center
# -v for Work Center demo user for work center

# Create Object Structure and add it to work Center
# -sOS represents source Object Structure. 
# -n represents Object Structure name name. For multiple names use "," separation
# -y add delete statement before insert
# -b for Object Structure work center name
# -i SIGOPTION names (supported ALL and READ)
# -k authorization group name (will create mxdemo group authorization)
# -f represents file name. Must end with .ora, .sqs, .db2, .sql, .dbc. For dbc scripts use .dbc
# -h represents host name (if not used will use localhost)
# -u represents the  user - value must be a valid e-mail account name
# -p represents password
# -t represents the tenant code - value must be the tenant code for consultant users in MT

# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sOS -nMXAPICRAFT -y0 -bTEST -iALL -kTEST -ftestcraft.dbc -umaxadmin -pmaxadmin -hlocalhost -t00

# Create Object Structure only
# -sOS represents source Object Structure. 
# -n represents Object Structure name name. For multiple names use "," separation
# -y add delete statement before insert
# -f represents file name. Must end with .ora, .sqs, .db2, .sql, .dbc. For dbc scripts use .dbc
# -h represents host name (if not used will use localhost)
# -u represents the  user - value must be a valid e-mail account name
# -p represents password
# -t represents the tenant code - value must be the tenant code for consultant users in MT

# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sOS -nMXAPICRAFT -y0 -fapicraft1.dbc -umaxadmin -pmaxadmin -hlocalhost -t00

# Create Automation script
# -sSCRIPT represents source Automation script. 
# -n represents Automation script name name.
# -y add delete statement before insert
# -f represents file name. Must end with .ora, .sqs, .db2, .sql, .dbc. For dbc scripts use .dbc
# -h represents host name (if not used will use localhost)
# -u represents the  user - value must be a valid e-mail account name
# -p represents password
# -t represents the tenant code - value must be the tenant code for consultant users in MT

$JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sSCRIPT -n"COMPSETACTUALDATES" -y1 -fcompsetactualdates.dbc -umaxadmin -pmaxadmin -hlocalhost -t01

# Create Work Center
# -sWC represents source Work center (demo group name will have same name). 
# -b represents Work Center name.
# -l Work Center description (same description will be used for demo group name)
# -i for Object Structure SIGOPTION names (supported ALL and READ)
# -0 all Object Structures for this work center
# -v demo user for work center
# -f represents file name. Must end with .ora, .sqs, .db2, .sql, .dbc. For dbc scripts use .dbc
# -h represents host name (if not used will use localhost)
# -u represents the  user - value must be a valid e-mail account name
# -p represents password
# -t represents the tenant code - value must be the tenant code for consultant users in MT

# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sWC -bTEST -l"Test work Center" -oMXAPIPERUSER,MXAPIASSET,MXAPIDOMAIN -iALL -vtest77 -ftest1.dbc -umaxadmin -pmaxadmin -hlocalhost -t00

# Create table (for maxtable and maxrelationshup it will create proper dbc statements)
# -sTABLE represents source table. 
# -n represents table name. For multiple names use "," separation
# -w represents where clause (for table and byos).
# -y add delete statement before insert
# -d use default date (will use current date or date from database)
# -f represents file name. Must end with .ora, .sqs, .db2, .sql, .dbc. For dbc scripts use .dbc
# -h represents host name (if not used will use localhost)
# -u represents the  user - value must be a valid e-mail account name
# -p represents password
# -t represents the tenant code - value must be the tenant code for consultant users in MT

# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nLOCATIONS -w"location like 'PUMPHOUSE%%'" -y1 -d1 -floc.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nAUSCRIPT -w"location like 'PUMPHOUSE%%'" -y1 -d1 -floc.dbc -umaxadmin -pmaxadmin -hlocalhost -t01

# Get data from all tables based on the Object Structure
# -sBYOS represents source by Object Structure. 
# -n represents Object Structure name name. For multiple names use "," separation
# -w represents where clause (where clase have to be valid for all objest in Object Structure).
# -y add delete statement before insert
# -d use default date (will use current date or date from database)
# -f represents file name. Must end with .ora, .sqs, .db2, .sql, .dbc. For dbc scripts use .dbc
# -h represents host name (if not used will use localhost)
# -u represents the  user - value must be a valid e-mail account name
# -p represents password
# -t represents the tenant code - value must be the tenant code for consultant users in MT

# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sBYOS -nMXCLASSIFICATION -w"classstructureid = '157937'" -y1 -d1 -fspec.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sBYOS -nWORKORDER -w "classstructureid = '157937'" -y1 -d1 -fspec_1.dbc -umaxadmin -pmaxadmin -hlocalhost

# Following 2 commands let record all changes which happening between you start process and end process
# -sSTART represents source Start Process. 
# -sEND represents source End Process. 
# -y add delete statement before insert
# -d use default date (will use current date or date from database)
# -f represents file name. Must end with .ora, .sqs, .db2, .sql, .dbc. For dbc scripts use .dbc
# -h represents host name (if not used will use localhost)
# -u represents the  user - value must be a valid e-mail account name
# -p represents password
# -t represents the tenant code - value must be the tenant code for consultant users in MT

# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sSTART -ftest.dbc -umaxadmin -pmaxadmin -hlocalhost -t00

# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sPH -nMXPOInterface,MXPRInterface -xEXTSYS1 -ftest.dbc -umaxadmin -pmaxadmin -hlocalhost -t00
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sES -nIOTFASSET -xIOTFSYNC -fiotf.dbc -y1 -umaxadmin -pmaxadmin -hlocalhost -t00
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sEX -nIOTFSYNC -fiotf.dbc -umaxadmin -y1 -pmaxadmin -hlocalhost -t00
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sWS -nMXPO -ftest.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sEP -nMXXMLFILE -ftest.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sINT -nECRI -a0 -fecri1.dbc -umaxadmin -pmaxadmin
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sJSONRES -nHISTORIAN -fhist.dbc -y1 -umaxadmin -pmaxadmin
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sJSONMAP -nLAYER16IN -flayer16.dbc -y1 -umaxadmin -pmaxadmin

# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sBYOS -nMXJSONMAPPING -w"mapname='WEATHERALERT'" -y1 -d0 -fmap.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sBYOS -nMXOPERLOC -wsiteid='BEDFORD' -d0 -floc.sql -umaxadmin -pmaxadmin -hlocalhost

# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nASSETATTRIBUTE -w"assetattrid = 'MFGLIFE'" -y1 -d1 -fattr.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nMAXRELATIONSHIP -w"name in ('TEMPMETER', 'MFGLIFE')" -y1 -d1 -frel.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nQUERY -w"clausename in ('Bad Actor - LTD Cost', 'METERSALARMLEVEL')" -y1 -d1 -fquery.dbc -umaxadmin -pmaxadmin -hlocalhost 
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nMAXUSER -w"userid='MAXADMIN'" -y1 -d1 -fuser.dbc -umaxadmin -pmaxadmin -hlocalhost -t00
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nIOTFCFG -w"1=1" -y1 -fyajin1.sql -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nIOTFDEVICEMAPPING -w"1=1" -y1 -fyajin2.sql -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nLOCATIONS -w"location like 'WELL FIELD%%'" -y1 -d1 -floc1.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nLOCATIONS -w"location = 'TWC'" -y1 -d1 -floc2.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nLOCOPER -w"location like 'PUMPHOUSE%%'" -y1 -d1 -flocoper.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nLOCOPER -w"location like 'WELL FIELD%%'" -y1 -d1 -flocoper1.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nLOCOPER -w"location = 'TWC'" -y1 -d1 -flocoper2.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nMAXENDPOINTDTL -w"endpointname = 'IOTHISTCLOUD'" -y1 -d1 -fdet.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nLOCHIERARCHY -w"systemid = 'WATER'" -y1 -d1 -flochier.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nLOCSTATUS -w"location like 'PUMPHOUSE%%'" -y1 -d1 -flocstat.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nLOCSTATUS -w"location like 'WELL FIELD%%'" -y1 -d1 -flocstat1.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nLOCSTATUS -w"location = 'TWC'" -y1 -d1 -flocstat2.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nLOCSYSTEM -w"systemid = 'WATER'" -y1 -d1 -flocsys.dbc -umaxadmin -pmaxadmin -hlocalhost

# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nASSET -w"assetnum like 'AH%%'" -y1 -d1 -fasset.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nASSETSPEC -w"assetnum like 'AH%%'" -y1 -d1 -fassetspec.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nASSETSPECHIST -w"assetnum like 'AH%%'" -y1 -d1 -fassethist.dbc -umaxadmin -pmaxadmin -hlocalhost
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sTABLE -nASSETMETER -w"assetnum like 'AH%%'" -y1 -d1 -fassetmeter.dbc -umaxadmin -pmaxadmin -hlocalhost


# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sEND -nALL -y1 -d1 -ftest5.dbc -umaxadmin -pmaxadmin -hlocalhost -t00
# $JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$MAXIMO_CLASSPATH/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sEND -nALL -y1 -d1 -ftest5.dbc -umaxadmin -pmaxadmin -hlocalhost -t00

