from __future__ import print_function
# Custom Action Launchpoint PORECCOMM
# Called from Escalation PORECESC
# com.ibm.tivoli.maximo.script.ScriptAction
# PORECCOMM,PORECCOMM,PORECCOMM
# PO.LASTRECDATE is a custom attribute to reflect latest receipt date (MATREC or SERVREC)
# Written against MX 7.5.0.10

import java
from java.util import Calendar 
from java.util import Date 
from psdi.server import MXServer
from psdi.mbo import MboConstants
from psdi.mbo import MboSet
from com.ibm.tivoli.maximo.util.mbo import IterableMboSet
servDT = MXServer.getMXServer().getDate()
df = java.text.SimpleDateFormat("MM/dd/yy kk:mm")
dfnow = java.text.SimpleDateFormat("kk:mm:s:S")
today = MXServer.getMXServer().getDate()
now = dfnow.format(today)
today = df.format(today)

def log(e): print(str(now) + ": "+str(launchPoint)+("__>> %s" % e) + "\r\n")
print("*************")
log("buffer")
log("Entering Script:....."+str(now))

s_poNum = str(mbo.getString("PONUM") or None)
s_poDesc = str(mbo.getString("DESCRIPTION") or None)
s_poVend = str(mbo.getString("VENDOR.NAME") or None)
s_poType = str(mbo.getString("POTYPE") or None)
b_hasReceipts,b_sendComm = (False,)*2
h_tableBody = ""
d_lastRecDate = mbo.getDate("LASTRECDATE") or None # Custom attribute to display and reference on PO
if(d_lastRecDate is None): d_lastRecDate = mbo.getDate("STATUSDATE")
d_lastRec = d_lastRecDate
d_newLastRec = d_lastRec

# Some substitution variables to use in HTML
h_left = " style=""text-align:left;"""
h_size = " style=""font-size:90%;"""
h_htmlHead = "<!DOCTYPE html><html>"
h_htmlFoot = "</html>"
h_tableBody = ""
h_poHead = "<h4>The following has been received from "+str(s_poVend)+" on PO:"+str(s_poNum)+"<br/><br/>"+str(s_poDesc)+"</h4>"	
h_tableHead = "<table style=""width:100%;""><tr><th"+h_left+">Item</th><th"+h_left+">Description</th><th"+h_left+">Quantity</th></tr>"
h_tableFoot = "</table>"
h_message = h_htmlHead

# sendComm function
def sendComm(s_templateId,s_subject,h_message):
	whereclause = "TEMPLATEID = '"+str(s_templateId)+"'"
	ctMboSet = mbo.getMboSet("$commtemp","COMMTEMPLATE",whereclause);
	ctMboSet.setQbeExactMatch("true")
	ctMboSet.reset()
	ctMbo = ctMboSet.getMbo(0)
	if(ctMbo is not None):
		ctMbo.setValue("SUBJECT",s_subject, MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
		ctMbo.setValue("MESSAGE",h_message, MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
		ctMbo.sendMessage(mbo,mbo);
	return

s_matRecSql = " ponum = '"+s_poNum+"' and receiptref is NULL and issuetype = 'RECEIPT'  and transdate > '"+str(d_lastRec)+"' "
matRecSet = mbo.getMboSet("$MATREC$","MATRECTRANS",s_matRecSql)
log("matRecSet.count(): "+str(matRecSet.count()))
if(matRecSet.count() > 0):
	b_hasReceipts = True
	matRec = matRecSet.moveFirst()
	while(matRec is not None):
		d_mrTransDate = matRec.getDate("TRANSDATE")
		if(d_mrTransDate > d_newLastRec): d_newLastRec = d_mrTransDate
		s_toStoreLoc = matRec.getString("TOSTORELOC") or None
		if(s_toStoreLoc is None and s_poType == "STD"):
			s_itemNum = matRec.getString("ITEMNUM") or None
			s_itemDesc = (matRec.getString("DESCRIPTION") or None)[:65]
			s_itemQty = str(matRec.getFloat("QUANTITY"))
			b_sendComm = True
			h_tableBody = h_tableBody + "<tr><td"+h_size+">"+str(s_itemNum)+"</td><td"+h_size+">"+str(s_itemDesc)+"</td><td"+h_size+">"+str(s_itemQty)+"</td></tr>"
		matRec = matRecSet.moveNext()

		
s_servRecSql = " ponum = '"+s_poNum+"' and receiptref is NULL and issuetype = 'RECEIPT' and transdate > '"+str(d_lastRec)+"' "
servRecSet = mbo.getMboSet("$SERVREC$","SERVRECTRANS",s_servRecSql)
log("servRecSet.count(): "+str(servRecSet.count()))
if(servRecSet.count() > 0):
	b_hasReceipts = True
	servRec = servRecSet.moveFirst()
	while(servRec is not None):
		d_srTransDate = servRec.getDate("TRANSDATE")
		if(d_srTransDate > d_newLastRec): d_newLastRec = d_srTransDate
		if(s_poType == "STD"):
			b_sendComm = True
			s_servDesc = (servRec.getString("DESCRIPTION") or None)[:65]
			s_servQty = str(servRec.getFloat("QUANTITY"))
			h_tableBody = h_tableBody + "<tr><td"+h_size+">SERVICE</td><td"+h_size+">"+str(s_servDesc)+"</td><td"+h_size+">"+str(s_servQty)+"</td></tr>"
		servRec = servRecSet.moveNext()


log("*********")
log("b_hasReceipts: "+str(b_hasReceipts))
log("b_sendComm: "+str(b_sendComm))


		
if(b_hasReceipts):
	log("Set PO.LASTRECDATE")
	mbo.setValue("LASTRECDATE",d_lastRec,MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
	if(b_sendComm):
		log("Send Communication")
		s_templateId = "PORECEIPT"
		s_subject = "Receipts on PO: "+s_poNum+" "+str(df.format(d_lastRec))	
		# Build HTML for message
		h_message = h_message+h_tableHead+h_tableBody+h_htmlFoot
		sendComm(s_templateId,s_subject,h_message)
			
log("Exiting Script")
log("buffer")

''' SQL

V_PORECEIPTS
create view dbo.v_poreceipts (siteid,orgid,itemnum,description,glcreditacct,gldebitacct,issuetype,linecost,linetype,transid,mrlinenum,mrnum,polinenum,ponum,porevisionnum,quantity,receivedunit,refwo,remark,requestedby,status,transdate,unitcost,receiptref,owner,invoicenum,tostoreloc,packingslipnum,issue) as

(SELECT mr.siteid,mr.orgid,mr.itemnum,mr.description,mr.glcreditacct,mr.gldebitacct,mr.issuetype,mr.linecost,mr.linetype,mr.matrectransid 'transid',
mr.mrlinenum,mr.mrnum,mr.polinenum,mr.ponum,mr.porevisionnum,mr.quantity,mr.receivedunit,mr.refwo,
mr.remark,mr.requestedby,mr.status,mr.transdate,mr.unitcost,mr.receiptref,'MATRECTRANS',mr.invoicenum,mr.tostoreloc,mr.packingslipnum,mr.issue
FROM matrectrans mr
UNION ALL
SELECT sr.siteid,sr.orgid,'Service',sr.description,sr.glcreditacct,sr.gldebitacct,sr.issuetype,sr.linecost,sr.linetype,sr.servrectransid 'transid',sr.mrlinenum,
sr.mrnum,sr.polinenum,sr.ponum,sr.porevisionnum,sr.quantity,pol.orderunit,sr.refwo,sr.remark,pol.requestedby,
sr.status,sr.transdate,sr.unitcost,sr.receiptref,'SERVRECTRANS',sr.invoicenum,NULL,NULL,1
FROM servrectrans sr LEFT JOIN poline pol ON sr.ponum = pol.ponum AND sr.polinenum = pol.polinenum AND sr.porevisionnum = pol.revisionnum)

V_MX_PORECEIPTS
create view dbo.v_mx_poreceipts (siteid,orgid,itemnum,description,glcreditacct,gldebitacct,issuetype,linecost,linetype,transid,mrlinenum,mrnum,polinenum,ponum,porevisionnum,quantity,receivedunit,refwo,remark,requestedby,status,transdate,unitcost,receiptref,owner,invoicenum,tostoreloc,packingslipnum,issue) as 
SELECT siteid,orgid,itemnum,description,glcreditacct,gldebitacct,issuetype,linecost,linetype,transid,mrlinenum,mrnum,polinenum,ponum,porevisionnum,quantity,receivedunit,refwo,remark,requestedby,status,transdate,unitcost,receiptref,owner,invoicenum,tostoreloc,packingslipnum,issue FROM v_poreceipts

UPDATE   po 
SET po.ns_lastrecdate = 
                       isnull( (SELECT isnull(max(por.transdate),po.statusdate)
                        FROM v_poreceipts por 
                        WHERE por.ponum = po.ponum
                        AND por.receiptref is NULL
                        AND por.issuetype = 'RECEIPT'
                        GROUP by por.ponum) ,po.statusdate)
WHERE po.receipts <> 'NONE'

'''