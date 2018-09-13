# Using an escalation to calculate dates

## Introduction
The following example outlines a Java-based approach to calculating dates. In this scenario, an escalation executes a scripted action. 

## Service request date calculation

In Maximo Asset Management and other products that are built on the process automation engine, service requests form a central unit of work in service desk implementations. Many service requests are managed on the basis of commitments that are stated in a service level agreement (SLA), however other requests are managed based on request priority, affected asset, and so forth without an associated SLA. For the latter type of service request, target dates must be computed and stored in the service request record based on business rules even though a governing SLA may not exist.

An escalation can be used to automate the date calculation. The combination of escalation and the scripted action reduce the amount of work a service desk manager or agent needs to perform to complete the service request processing.

The escalation uses SQL criteria to identify a subset of records that qualify for the date calculation. The automation script is launched on each of these records by the associated action, and the action launch point performs the calculation and updates the service request record. A work log entry is created for the updated service request record to indicate that automated work was performed on the request.

## Implementation approach - action launch point, script, and escalation

The following high-level steps implement the solution:

    1 - In the Automation Scripts application, define the action launch point and create the script. This activity  automatically generates an action.
    2 - In the Escalation application, define the escalation and associate it with the action.

## SRDDACTIONJAVA – action launch point and script

In the action launch point wizard, you can define an action launch point and associated script code.

[Calculation](sample06-2/pic1.jpeg)
<center><font size=1><b>Figure 1</b> Configurations to enable a scripted action in Maximo Asset Management version 7.5</font></center>

In Step 1 of the action launch point wizard, name the launch point, name, the action and provide a description for the action.

[Calculation](sample06-2/pic2.jpeg)
<center><font size=1><b>Figure 2</b> Step 1 of the action launch point wizard</font></center>

In this example, the action launch point name and the action name are the same: ‘SRDDACTIONJAVA’. The ‘SR’ business object is associated with the launch point and the action.

In Step 2 of the action launch point wizard, define two output variables: ‘targetcontactdate’ and ‘targetstartdate’, which are bound in the SR object to the attributes ‘TARGETCONTACTDATE’ and ‘TARGETSTART’ respectively. Also define the input variable ‘reportdate’, which is bound in the SR object to the attribute ‘REPORTDATE’. The goal of the scripting scenario is to compute targetcontactdate and targetstartdate values by using the reportdate value.

In Step 3 of the action launch point wizard, enter the following lines of code:
```java
    from java.util import Calendar
    from java.util import Date

    print 'SRDDACTIONJAVA - script execution started'
    cal=Calendar.getInstance()
    cal.setTime(reportdate)
    cal.add(Calendar.DATE, +1)
    targetcontactdate =  cal.getTime()
    cal.add(Calendar.DATE,+1)
    targetstartdate=cal.getTime()

    worklogset = mbo.getMboSet ('WORKLOG')
    worklogentry = worklogset.add()
    worklogentry.setValue('clientviewable',1)
    worklogentry.setValue('logtype','WORK')
    worklogentry.setValue('description','System initiated processing')

    print 'SRDDACTIONJAVA - script execution complete'
```

The script does not have any ‘if’ conditions, because ‘if’ conditions are handled by escalation criteria in the escalation. If a service request record meets the criteria, the escalation picks up the record and initiates the action. The job of the script code is to calculate the dates and set them into the output variables, which are then set in the targeted service request record that is supplied by the escalation. 

The script imports the Java Calendar and Date classes, which allows the scipt to use a variety of calendar and date Java APIs. You can obtain an instance of a calendar object. The getInstance() method returns an object that is based on the current time in the default time zone and default locale of the current Java virtual machine where Maximo Asset Management is running. However, the script sets the Calendar object’s time to the SR record’s reportdate value in the very next line of code by using the Calendar class’ setTime() method. The parameter to the setTime() method is the input variable reportdate. The scripting framework recognizes that the input variable is bound to a Maximo attribute of DATETIME or DATE type and automatically creates a Java Date object to represent the reportdate from the SR record. This automatic processing allows the script to directly pass the input variable reportdate to setTime().

Now that the Calendar object is initialized with reportdate, time can be added to it. The script adds one day to it and sets the ‘targetcontactdate’ to be 1 day from the reported date and time. Another day is added to the calendar object, and the script setsthe ‘targetstartdate’ to be 2 days from the reported date and time. The amount of time added might vary depending on the type of service request.

After the date calculations, the script creates a work log entry for the given service request to indicate that the system initiated processing on the record. This work log entry is created by using traditional business object method calls. Because the current record is represented by a Service Request business object, the script obtains a handle to the related work log MBO set. Records can be added by using the MBO add() method.

<b>Figure 3</b> shows the action definition

[Calculation](sample06-2/pic3.jpeg)
<center><font size=1><b>Figure 3</b> Scripted action definition</font></center>

This action was automatically generated when the launch point and script were created. The action definition includes the fields and values that are listed in <b>Table 1</b>.

<table>
    <tr><td>Action</td><td>SRDDACTIONJAVA</td></tr>
    <tr><td>Object</td><td>SR</td></tr>
    <tr><td>Type</td><td>Custom Class</td></tr>
    <tr><td>Value</td><td>com.ibm.tivoli.maximo.script.ScriptAction</td></tr>
    <tr><td>Parameter / Attribute</td><td>SRDDACTIONJAVA,SRDDACTIONJAVA,SRDDACTIONJAVA</td></tr>
     <tr><td>Accessible From</td><td>ALL</td></tr>
</table>
<center><font size=1><b>Table 1</b> Action definition details</font></center>
	
Details regarding the action definition:

* The name of the action is specified by the user in the **Action** field.
* The **Object** the action is associated with is the same as the object that the corresponding action launch point is associated with.
* The **Type** is ‘Custom Class’, which indicates that a Java class is executed whenever this action is invoked.
* The **Value** specifies the complete name of the Java class. This class is part of the default automation scripting framework.
* The **Parameter / Attribute** field shown in the **Table 1**  is a comma-separated list of parameters that is processed by the Java action to determine the corresponding launch point and script. The number of comma-separated values is always three. The values are interpreted as: 
    ```kotlin 
        <script name>, <launch point name>, <action name> 

        // The implementation of the framework-supplied custom Java class uses these three values to identify, prepare and execute the script.
    ```
    
* The **Accessible From** field is set to ALL, which indicates that this scripted action is available to escalations, workflows, and any other entity that can consume the action, including user interface button defninitions.

<face color=RED><b>NOTE:</b> Altering the generated values for the Object, Type, Value and Parameter / Attribute fields may break the action definition and its link with the action launch point.</face>

## SRDDESC escalation

When defining the escalation, use the following SQL criteria at the escalation header level:
```kotlin
    assetnum is not null and reportedpriority = 1 and status = 'NEW' and targetcontactdate is null and targetstart is null
```

<face color=RED><b>NOTE:</b> These criteria may be insufficient in your product environments. Adjust the criteria accordingly.</face>

Change the schedule so that the escalation runs every minute. Add an escalation point. Then add an action. Associate the SRDACTION with the escalation and save all changes. <b>Figure 4</b> shows the final escalation definition.

[Calculation](sample06-2/pic4.jpeg)
<center><font size=1><b>Figure 4</b> SRDDESC escalation definition</font></center>

## Testing the configurations

Activate the escalation and then create a test service request record that has a reported priority of 1, associate it with an asset, and save it with ‘NEW’ status. When the escalation runs, the associated action is executed, and the script computes new dates and inserts a work log. <b>Figure 5</b> shows the result of the date computation on the target service request record in the form of input and output.

[Calculation](sample06-2/pic5.jpeg)
<center><font size=1><b>Figure 5</b> Result of escalation execution on a service request record</font></center>

<b>Figure 6</b> shows the result of the work log record creation.
	
[Calculation](sample06-2/pic6.jpeg)
<center><font size=1><b>Figure 6</b> Work log created by script against the target service request record</font></center>

## Using logs to review script execution

If you choose to set the ‘autoscript’ logger to ‘DEBUG’ and the SRDDACTIONJAVA script log level also to ‘DEBUG’, then the Maximo product log shows the following log statements:

```kotlin
    [DEBUG] [MXServer] [CID-CRON-3917] ScriptAction called for scriptName SRDDACTIONJAVA has been called for launch point SRDDACTIONJAVA

    [DEBUG] [MXServer] [CID-MXSCRIPT-3918] AbstractScriptDriver context value = null for mbo attribute targetcontactdate

    [DEBUG] [MXServer] [CID-MXSCRIPT-3918] AbstractScriptDriver context value = null for mbo attribute targetstartdate

    [DEBUG] [MXServer] [CID-MXSCRIPT-3918] AbstractScriptDriver context value = 2011-12-23 22:14:28.0 for mbo attribute reportdate

    [DEBUG] [MXServer] [CID-MXSCRIPT-3918] about to execute the cached compiled script for SRDDACTIONJAVA for launch point SRDDACTIONJAVA

    [DEBUG] [MXServer] [CID-MXSCRIPT-3918] created script context for cached compiled script SRDDACTIONJAVA for launch point SRDDACTIONJAVA

    [DEBUG] [MXServer] [CID-MXSCRIPT-3918] execution completed for cached compiled script SRDDACTIONJAVA for launch point SRDDACTIONJAVA

    [DEBUG] [MXServer] [CID-MXSCRIPT-3918] SRDDACTIONJAVA - script execution started

    SRDDACTIONJAVA - script execution complete

    [INFO] [MXServer] [CID-MXSCRIPT-3918] The total time taken to execute the SRDDACTIONJAVA script for the SRDDACTIONJAVA  launch point is 87 ms.

    [DEBUG] [MXServer] [] ScriptAction call ended for scriptName SRDDACTIONJAVA and launch point SRDDACTIONJAVA
```

The log that is associated with the SRDDACTIONJAVA action, action launch point, and script are bracketed by statements that indicate the action launch point was initiated and completed. The script framework writes the values for the input and output variables that are passed to the script. The reportdate variable carries the date-time value that is retrieved from the target Maximo record. The log also shows the output from the print statements that are in the script, which is useful when a script needs to be debugged. Finally, the script framework also records the total time that was taken to execute the script in milliseconds.

## Summary

This example illustrates how an action launch point and script can be exploited to achieve a higher degree of automation in Maximo Asset Management than previously possible. A few Java APIs were used to implement the script logic. However, Jython or JavaScript functions can be used to achieve the same results. 

## Useful Links

[Java Calendar class and methods](http://docs.oracle.com/javase/6/docs/api/java/util/Calendar.html)

[Maximo 7.5 Scripting Cookbook](https://www.ibm.com/developerworks/mydeveloperworks/blogs/a9ba1efe-b731-4317-9724-a181d6155e3a/entry/scripting_with_maximo6?lang=en)

## Files accompanying this article

[Date Calculation – Part II.pdf](https://www.ibm.com/developerworks/mydeveloperworks/blogs/a9ba1efe-b731-4317-9724-a181d6155e3a/resource/DateDizziness-PartII.pdf)

[Automation script in a ZIP file – srddactionjava.py](https://www.ibm.com/developerworks/mydeveloperworks/blogs/a9ba1efe-b731-4317-9724-a181d6155e3a/resource/srddactionjava.zip)

[Migration Manager package containing escalation, action and script](https://www.ibm.com/developerworks/mydeveloperworks/blogs/a9ba1efe-b731-4317-9724-a181d6155e3a/resource/DDCHGPKG_ibm-rhkb7omky1r_MX75_MAXIMO_20111224154036.zip)

Deploy the package into your product environment by using the Migration Manager application. Admin Mode is not required. The action launch point should be automatically activated. However, the escalation is left inactive. To test the script, you must be activate the escalation.
	




	




	
