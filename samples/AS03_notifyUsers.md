# Notify users of material and service receipts

You can create an automation script that can notify users of receipts in an email, without sending a separate email for each receipt record. This process uses an escalation to activate a custom action to do send the notification.

## Prerequirements: 

This automation script was developed on Maximo Asset Management version 7.5.0.10 and SQL Server.  


## Note: 
    
This automation script works only for purhcase orders where all lines are requested by the same user.  

## Step 1

Create a persistent attribute that is named PO.LASTRECDATE (DATETIME 10).
    <ul>
        <li>Optionally, add the attribute to the **List** and **Main** tabs for purchase orders. 
        <li>Turn off Admin mode. 
    </ul>
                     
## Step 2

Create a role that is named POREQ and specify the following information for the role:
    <ul>
        <li> <b>Type:</b> Data Related to the Record
        <li> <b>Object:</b> PO
        <li> <b>Value:</b> :poline.requestedby
    </ul>

## Step 3

Create a communication template that is named PORECEIPT and specify the following information for the template:
    <ul>
        <li><b>Applies To:</b> PO
        <li>Subject and Message are customizable for your business needs.
        <li>Add the POREQ role as a recipient.
        <li>Activate the template.
    </ul>


## Step 4

Create a custom launch point that is named PORECCOMM and specify the following information:
    <ul>
        <li><b>Object:</b> PO
        <li><b>Action:</b> PORECCOMM
        <li><b>Bound Variables:</b> None
        <li><b>Source:</b> <font color='RED'>See the poreccomm.py script. It is also available at this link.</font>
    </ul>

## Step 5 

Create an action group that is named PORECESC and specify the following information.
<ul>
    <li><b>Object:</b> PO
    <li><b>Type:</b> Action Group
    <li><b>Members:</b> PORECCOMM
</ul>

### Additional information: 

You can create new views on the database that are independent of Maximo Asset Management.

* The following sample code can be used to update all PO records:

```kotlin
V_PORECEIPTS
```
* The following sample code can also be used to update the V_MX_PORECEIPTS view:
```kotlin
V_MX_PORECEIPTS (extra credit)
```
* The following sample code can be used as an imported Maximo object that combines MATREC and SERVREC by PO: 

<a href="AS03_01_poreccomm.md">PORECCOMM Script</a>

## Step 6

Create an escalation that is named PORECESC and specify the following information.

<ul>
    <li><b>Applies To:</b> PO
    <li><b>Condition:</b> 
</ul>

```sql 

po.historyflag = 0  AND po.receipts <> 'NONE' 
AND (exists (SELECT 1 FROM matrectrans mr WHERE mr.ponum = po.ponum AND mr.receiptref is NULL AND mr.issuetype = 'RECEIPT' AND mr.transdate >  isnull(po.ns_lastrecdate,po.orderdate))
OR exists (SELECT 1 FROM servrectrans sr WHERE sr.ponum = po.ponum AND sr.receiptref is NULL AND sr.issuetype = 'RECEIPT' AND sr.transdate >  isnull(po.ns_lastrecdate,po.orderdate)))

```

•	Escalation Point: repeats
•	Action Group: PORECESC
•	Don’t forget to activate this SQL code.

## Sample script

The following code contains the entire sample script for this scenario.
<a href="AS03_01_poreccomm.md">PORECCOMM Script</a>





