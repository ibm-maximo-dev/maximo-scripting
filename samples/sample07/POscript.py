#-------------------------------------------------------------
# AUTOSCRIPT:	 POEMAIL
# DESCRIPTION:	Send a PO to the supplier
# AUTHOR:	 David Shaw
# Created	 04.08.17
# LOGLEVEL:	 ERROR
# VERSION:	0.1
# COPYRIGHT:	(c) David Shaw
# MAXIMO/ICD Version: 7.6
#-------------------------------------------------------------
# History of Changes
#
# Ver	Date 		Name 				Description
# 0.1	17.07.17	David Shaw			Initial Draft Version (based off Scripting report execution in 7.5 by agrippa)
#
#-------------------------------------------------------------
#
# Launch point - EMAILPO - Action launch point, trigger to be determined
#
#-------------------------------------------------------------

from java.util import Calendar
from java.util import Date
from psdi.app.report import ReportUtil
from psdi.server import MXServer
from psdi.mbo import MboConstants
from psdi.mbo import SqlFormat
from java.lang import StringBuilder

# Required functions, do not alter
v_appname = app
v_emailfiletype = 'PDF'
v_emailtype = 'attach'
v_paramdelimiter = '||'
v_paramstring = 'appHierarchy=PO||displayWhere'

# DPWS Set variables
v_emailsubject = mbo.getString('ponum') #Text for email subject
v_reportname = 'custom_POrder.rptdesign' # BIRT report name to send
v_maximourl = 'http://maximoeamsdev/maximo' # Server URL
#v_maximourl = StringBuilder()
#v_maximourl.append(mbo.getMboSet('$maxpropvalue','maxpropvalue',"propname = 'DPWS.WebURL'").getMbo(0).getString('propvalue'))


## V_EMAILTO gets the PO vendor and finds all person records for that vendor.	It then strings together all their email addresses.
##v_emailto = '' # Email address of recipient (MUST BE A VALID PERSON RECORD EMAIL!!!! SENDING WITHOUT BREAKS IT!)
v_emailto = StringBuilder()

vendor = mbo.getMboSet('VENDOR').getMbo(0)

if vendor is None: # pop up NO VENDOR message if PO has no vendor
	ponum = mbo.getString('PONUM')
	errorgroup = 'DPWS'
	errorkey = 'POERR1'
	params=[ponum]

elif vendor.getString('HOMEPAGE')=='': # If vendor has no email address, show error message
	vendor = mbo.getString('VENDOR')
	errorgroup = 'DPWS'
	errorkey = 'POERR3'
	params=[vendor]

else: # If PO has vendor and vendor has email address
	person = mbo.getMboSet('$PERSON','PERSON',"personid='POEMAIL'").getMbo(0)
	person.setValue('PRIMARYEMAIL',vendor.getString('HOMEPAGE'))


	v_emailto.append(person.getString('PRIMARYEMAIL'))

	v_emailcomments = StringBuilder() # Body of the email text
	v_emailcomments.append('<br><p style="font-family:Calibri">This email contains a Purchase Order from xxxxx.<br>')
	v_emailcomments.append('<br>Please confirm the price and ETA of this order. Please ensure this happens today and <u>before you deliver</u>. All orders will be approved on our system after this time and can not be amended, therefore your invoice may go into query if there are any discrepancies.<br>')
	v_emailcomments.append('<br>Delivery address for <b><u>ALL</u></b> orders:<br>')

	v_emailcomments.append('<br><br><u>Partial Deliveries are acceptable</u><br><br></p>')

	v_emailcomments.append('<br><span style="color:#00B050;font-size:8.0pt"><u>please note:</u>')
	v_emailcomments.append('<br><br>As of <b><u>1st October 2012</u></b> all delivery drivers must be in possession of photographic id (passport or driving licence), this is to comply with the requirements of the Security Secretariat of the Department for Transport Maritime Security and Resillence Divison (MSRD) for entry to the stores which is located within the secure zone (Restricted Area).')
	v_emailcomments.append('<br><br>Failure to comply with current MSRD regulations may result in delays and the inability to make deliveries and or collections.')
	v_emailcomments.append('<br><br>Your help and compliance under government regulations is mandatory</span></p>')


	# set a schedule for the report
	c = Calendar.getInstance()

	# add 60 seconds to current time to allow preparing REPORTSCHED cron task instance
	c.add(Calendar.SECOND,60)
	d = c.getTime()
	thisposet = mbo.getThisMboSet()
	if thisposet is not None:
			locale = thisposet.getClientLocale()
			userinfo = thisposet.getUserInfo()
	schedule = ReportUtil.convertOnceToSchedule(d,locale,c.getTimeZone())

	if schedule is not None:
		reportschedset = MXServer.getMXServer().getMboSet("REPORTSCHED",userinfo)
		if reportschedset is not None:
			print "Obtained REPORTSCHED set"
			reportsched = reportschedset.add()
			reportsched.setValue("REPORTNAME",v_reportname)
			reportsched.setValue("appname",app)
			reportsched.setValue("USERID",userinfo.getUserName()) # To run as current logged in user
			reportsched.setValue("TYPE","once")
			reportsched.setValue("EMAILTYPE",v_emailtype)
			reportsched.setValue("MAXIMOURL",v_maximourl)#.toString())
			reportsched.setValue("EMAILUSERS",v_emailto.toString())
			reportsched.setValue("EMAILSUBJECT",v_emailsubject)
			reportsched.setValue("EMAILCOMMENTS",v_emailcomments.toString())
			reportsched.setValue("EMAILFILETYPE",v_emailfiletype)
			reportsched.setValue("COUNTRY",locale.getCountry())
			reportsched.setValue("LANGUAGE",locale.getLanguage())
			reportsched.setValue("VARIANT",locale.getVariant())
			reportsched.setValue("TIMEZONE",thisposet.getClientTimeZone().getID())
			reportsched.setValue("LANGCODE",userinfo.getLangCode())
			print "About to work with REPORTSCHEDULE cron task"
			crontaskdef = reportsched.getMboSet("$parent","crontaskdef","crontaskname='REPORTSCHEDULE'").getMbo(0)
			if crontaskdef is not None:
				crontaskinstset = crontaskdef.getMboSet("CRONTASKINSTANCE")
				if crontaskinstset is not None:
					print "About to work with Cron task instance of REPORTSCHEDULE cron task"
					crontaskinst = crontaskinstset.add(MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
					if crontaskinst is not None:
						d = Date()
						crontaskinstname = str(d.getTime())
						crontaskinst.setValue("CRONTASKNAME","REPORTSCHEDULE",MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
						crontaskinst.setValue("INSTANCENAME",crontaskinstname,MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
						crontaskinst.setValue("SCHEDULE",schedule,MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
						crontaskinst.setValue("ACTIVE",1,MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
						crontaskinst.setValue("RUNASUSERID",userinfo.getUserName(),MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
						crontaskinst.setValue("HASLD",0,MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
						crontaskinst.setValue("AUTOREMOVAL",True,MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
						print "have set all cron task instance values for REPORTSCHEDULE cron task"
			reportsched.setValue("CRONTASKNAME",crontaskinst.getString("CRONTASKNAME"))
			reportsched.setValue("INSTANCENAME",crontaskinst.getString("INSTANCENAME"))
			print "Now going to work with Cron task PARAMETERS"
			cronparamset = crontaskinst.getMboSet("PARAMETER")
			if cronparamset is not None:
				sqf = SqlFormat(cronparamset.getUserInfo(),"reportname=:1")
				sqf.setObject(1,"REPORTPARAM","REPORTNAME",v_reportname)
				reportparamset = MXServer.getMXServer().getMboSet("REPORTPARAM",cronparamset.getUserInfo())
				if reportparamset is not None:
					print "working with REPORTPARAM mbo set"
					reportparamset.setWhere(sqf.format())
					reportparamset.reset()
					i=reportparamset.count()
					reportparammbo = None
					for j in range(i):
						reportparam = reportparamset.getMbo(j)
						cronparam = cronparamset.add(MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
						if cronparam is not None:
							print "going to copy values from REPORTPARAM into CRONTASKPARAM"
							cronparam.setValue("CRONTASKNAME","REPORTSCHEDULE",MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
							cronparam.setValue("INSTANCENAME",crontaskinstname,MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
							cronparam.setValue("CRONTASKNAME","REPORTSCHEDULE",MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
							paramname = reportparam.getString("PARAMNAME")
							cronparam.setValue("PARAMETER",paramname,MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
							if paramname=="where":
								# prepare dynamic where clause for report params
								uniqueidname = mbo.getUniqueIDName()
								uniqueidvalue = mbo.getUniqueIDValue()
								uniquewhere = uniqueidname + "=" + str(uniqueidvalue)
								cronparam.setValue("VALUE",uniquewhere,MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
							elif paramname=="paramstring":
								print 'If condition for v_paramstring'
								cronparam.setValue("VALUE",v_paramstring,MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
							elif paramname=="paramdelimiter":
								print 'If condition for v_paramdelimiter'
								cronparam.setValue("VALUE",v_paramdelimiter,MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
							elif paramname=="appname":
								cronparam.setValue("VALUE",v_appname,MboConstants.NOACCESSCHECK | MboConstants.NOVALIDATION_AND_NOACTION)
							else:
								continue
			reportschedset.save()