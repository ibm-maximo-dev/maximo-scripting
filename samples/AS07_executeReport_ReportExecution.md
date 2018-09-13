# Report execution

The Purchase Order application is supported by several reports, including Purchase Order Details and PO Status Details. This scenario uses the Purchase Order Details report as the report execute for this scenario.

When a purchase order is selected on the **List** tab, the typical user-initiated report execution tasks are shown in the following table:

<table>
<tr><td>Task</td><td>
Description</td><tr>
<tr><td>1</td><td>
If **Run Reports** is available, click this action.
<tr><td>2</td><td>
In the Reports Selection window that appears, click the **Purchase Order Details Report**.</td><tr>
<tr><td>3</td><td>
In the Request Page window that appears, chose or specify the following:
a.
Schedule (Immediate, At This Time, Recurring)
b.
Email (Recipients, Subject, Comments, File Type, Report Delivery Format)</td><tr>
<tr><td>4</td><td>
On the Request Page window, click **Submit**.</td><tr>
<tr><td>5</td><td>
If report execution was scheduled to run</td><tr>
</table>
<center><font size=1><b>Table 1</b> Report execution tasks</font></center>


If the **Immediate** option was chosen, the report runs immediately, which opens the BIRT Report Viewer in a new browser window and displays details of the currently open purchase order.

[Dizziness](sample07/pic1.png)
<center><font size=1><b>Figure 1</b> Details of a open purchase order.</font></center>

If the **Schedule | At This Time** option was chosen, then e-mail details, such as recipient, must be specified, and the report is executed in the background. Depending on the selected delivery option, a notification is sent to the recipient that includes the report as a PDF file, an Excel spreadsheet, or a live URL that can be clicked by the recipient as shown in <b>Figure 2</b>.

[Dizziness](sample07/pic2.png)
<center><font size=1><b>Figure 2</b> Confirmation note</font></center>

Clicking the URL brings the user to a login page and after the user logs in, the Report Viewer is displayed. The Report Viewer shows a single entry that represents the executed report. A Download Content link enables the user to download the report as a PDF file or an XLS spreadsheet.

[Dizziness](sample07/pic3.png)
<center><font size=1><b>Figure 3</b> Confirmation note</font></center>

A couple of important points must be noted:
1. The recipient of the report must have an active person record.
2. If the report is scheduled for execution at a later time, the selected time slot must be in the future.

## Scheduled report execution

The following report execution options involve scheduling:
* Running a report once in the future (The **At this Time** option)
* Running a report on a recurring basis in the future (The **Recurring** option)

After a report is scheduled, the following table shows the configuration records that drive report execution:

<table>
<tr><td>Report schedule record</td><td>Used by the reporting framework to store the scheduling details for a report.</td><tr>
<tr><td>Cron task instance record for the REPORTSCHEDULE cron task</td><td>Used by the Cron Task manager to execute the report on a schedule by placing a job into the report queue. The REPORTSCHEDULE cron task looks up the report schedule record to obtain details of the report execution.</td><tr>
</table>
<center><font size=1><b>Table 2</b> Report configuration</font></center>

When a report is run by using the **At This Time** option, the reporting framework prepares a one-time cron task instance that uses the REPORTSCHEDULE cron task. After the report is executed, this one-time instance record is removed from the Cron Task instance table.
When the report is run by using the **Recurring** option, the reporting framework prepares a cron task instance that uses the REPORTSCHEDULE cron task. This cron task instance remains in the product environment until an administrator deletes the report schedule record by using the View Scheduled Reports user interface in Report Administration application.

<face color='RED'><b>NOTE</b>: The REPORTSCHEDULE cron task is a read-only cron task. To view it in the Cron Task Setup application, you must set the **Access Level** field to READONLY and search.</face>
