#!/bin/bash

./commonEnv.bat

export JAVA_HOME="../../java/jre"
export MAXIMO_CLASSPATH="../../../"

echo $MAXIMO_CLASSPATH

# Command line parameters are as follows
# -s represents source. Valid value is INT 
# -n represents name (os name, es name ...). For multiple names use "," separation
# -a represents use header. Do you want bto create sigoption header. If multiple interaction for one application. Header need to be created only once
# -f represents file name. Must end with .ora, .sqs, .db2, .sql, .dbc. For dbc scripts use .dbc
# -p represents the password - value must be the password to access the e-mail account
# -u represents the  user - value must be a valid e-mail account name
# -h represents host name (if not used will use localhost)

$JAVA_HOME/bin/java  -cp "../classes:$MAXIMO_CLASSPATH:mail.jar:/$MAXIMO_CLASSPATH/applications/maximo/lib/*:/$1/applications/maximo/businessobjects/classes:." psdi.tools.DBCConverter -sINT -nECRI -a0 -fecri.dbc -umaxadmin -pmaxadmin -hlocalhost