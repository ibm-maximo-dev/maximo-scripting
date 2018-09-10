from java.util import Calendar
from java.util import Date
from psdi.server import MXServer
from java.sql import Statement
from java.sql import PreparedStatement
from java.sql import Connection
from java.sql import ResultSet
from psdi.mbo import Mbo


mxserver = MXServer.getMXServer()
userInfo = mxserver.getSystemUserInfo()
currentSet = mxserver.getMboSet("MAXUSER",userInfo)
currentMbo = currentSet.getMbo(0)
con = currentMbo.getMboServer().getDBConnection(userInfo.getConnectionKey())
schema = currentMbo.getMboServer().getSchemaOwner()
schema = schema.upper()
currentDate = MXServer.getMXServer().getDate()
userQuery = ['select userid, max(attemptdate) "LASTLOGINDATE" from logintracking where attemptresult = ','\'','LOGIN','\'', 'group by userid having max(attemptdate) <(sysdate-20)']
userQuery = ''.join(userQuery)
s= con.createStatement()
rs1 = s.executeQuery(userQuery)
while(rs1.next()):
	date = rs1.getString ('LASTLOGINDATE')
	def calcelapsedtime(msdiff):
		secondinmillis = 1000
		minuteinmillis = secondinmillis  * 60
		hourinmillis = minuteinmillis * 60
		dayinmillis = hourinmillis * 24
		elapseddays = msdiff / dayinmillis
		elapsedhours = msdiff / hourinmillis
		elapsedminutes = msdiff / minuteinmillis
		if(elapseddays !=0): 
			return str(elapseddays) 
	timediff = currentDate.getTime() - date.getTime()
	daydiff = calcelapsedtime(timediff)
	commSet = mxserver.getMboSet("COMMTEMPLATE",userInfo)
	commSet.setWhere("TEMPLATEID = 'XXX' ")
	commSet.reset()
	ctMbo = commSet.getMbo(0)
	if (ctMbo is not None):
		print " inside if"
		ctMbo.setValue("SUBJECT","daydiff", MboConstants.NOVALIDATION_AND_NOACTION_AND_NOACCESSCHECK)
		ctMbo.sendMessage(mbo,mbo)
		 
rs1.close()
