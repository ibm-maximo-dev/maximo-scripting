@ECHO OFF

SETLOCAL

call commonEnv.bat

set JAVA_HOME=..\..\java\jre

rem Command line parameters are as follows
rem -s represents source. Valid value is INT 
rem -n represents name (os name, es name ...). For multiple names use "," separation
rem -a represents use header. Do you want bto create sigoption header. If multiple interaction for one application. Header need to be created only once
rem -f represents file name. Must end with .ora, .sqs, .db2, .sql, .dbc. For dbc scripts use .dbc
rem -p represents the password - value must be the password to access the e-mail account
rem -u represents the  user - value must be a valid e-mail account name
rem -h represents host name (if not used will use localhost)
%JAVA_HOME%\bin\java  -classpath ../classes;%MAXIMO_CLASSPATH%;.\mail.jar psdi.tools.DBCConverter -sINT -nECRI -a0 -fecri.dbc -uwilson -pwilson