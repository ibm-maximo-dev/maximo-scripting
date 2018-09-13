# Calculating elapsed time based on date and time measurements in Maximo business objects 

## Introduction

Many Maximo business objects, processes, and applications record date and time measurements. Such measurements can be used to compute the total time spent by operators on particular tasks. For example, in the Service Request application, finding the elapsed time difference between Actual Finish and Actual Start date and time can help measure the time spent by service desk agents in completing and closing a ticket. This computed information can then be used in ad hoc reporting to gain insights into the efficiency of the service desk.

## Date and time processing with scripts

You want to calculate the elapsed time and show it in the Service Request application user interface formatted in an easy-to-read manner. For example, if the Actual Start time for a service request was 9/2/04 12:04 PM and the Actual Finish time was 9/2/04 12:14 PM, then the time spent in resolving the service request is 10 minutes.

Note: In Maximo Asset Management, the time that is spent on a service request is tracked by labor transaction records. These records are generated whenever a service desk agent starts a timer and then stops it, which captures the time spent. An agent may also manually enter Actual Start and Finish information directly into the service request record. Various totals for a service request can be viewed under different categories, such as Total Labor Hours and Total Costs. 

## Requirements for the scenario

The following actions are required for the scenario

* Add a persistent attribute TIMESPENT to the TICKET business object
* Modify the Service Request presentation to show a Time Spent field 
* Create an Object launch point for the Service Request business object. This launch point is executed whenever an existing service request record is modified.
* Create a Jython script that is associated with the object launch point. This script performs the elapsed time computation.

<u>TIMESPENT attribute</u>

The purpose of this attribute is to save the computed elapsed time in an end-user-friendly format in the product database. In the Database Configuration application ,create the persistent TIMESPENT attribute for the TICKET business object. The data type is ALN, and its length is 20 characters. Configure the product so that this new attribute takes effect. The attribute is inherited by the SR business object. 

[Calculation](sample06-1/pic1.jpeg)

<u>SR application presentation</u>

In the Application Designer, open the SR application presentation. Locate the Dates section on the **Service Request** tab. Add a text box  below the **Actual Finish** field. Configure the text box by binding the field with the TIMESPENT attribute of the SR business object. In the Textbox Properties dialog box, specify a label and select the SR.TIMESPENT attribute by using the Attribute lookup. Save the presentation. 

[Calculation](sample06-1/pic2.jpeg)

<u>Object Launchpoint</u>

In the Automation Scripts application, select the **Create > Script with Object Launch Point** to open the wizard.

In Step 1 of the wizard, provide the following values:

    Launch Point: CALCELAPSEDTIME
    Object: SR
    Active: Checked
    Update: Checked

In Step 2 of the wizard, provide the following values:


    Script: CALCELAPSEDTIME
    Script Language: jython
    Log Level: ERROR
    Input variable ‘actualfinish’, bound to SR.ACTUALFINISH attribute
    Input variable ‘actualstart’, bound to SR.ACTUALSTART attribute
    Output variable ‘timespent’, bound to SR.TIMESPENT attribute

In Step 3 of the wizard, provide the following script:
```java
    timediff = actualfinish - actualstart

    timespent = elapsedtime(msdiff)
```    
In Step 3 of the wizard, click the **Create** button to create the object launch point and save the script.

## Troubleshooting with Dates

To test this configuration, open the Service Requests application, select a service request record that is in the RESOLVED state and has an actual start and finish date and time. Edit the long description and save the record. The following error is displayed:

```kotlin
    BMXAA7837E - An error occured that prevented the CALCELAPSEDTIME script for the CALCELAPSEDTIME launch point from running.
    TypeError: unsupported operand type(s) for -: 'java.sql.Timestamp' and 'java.sql.Timestamp' in <script> at line number 1
```

The error occurs for the following reasons:

* Jython does not directly support applying the subtraction operator against java.sql.Timestamp operands.
* The script is using objects of the java.sql.Timestamp class, which extends from java.util.Date class.
* Subtracting Java Date object instances is not straightforward.

The automation scripts framework returns Java Date object instances for those variables that are bound to business object attributes of Maximo data type DATE, TIME and DATETIME. Make the following changes to the script:
```python
        def calcelapsedtime(msdiff):
        secondinmillis = 1000
        minuteinmillis = secondinmillis  * 60
        hourinmillis = minuteinmillis * 60
        dayinmillis = hourinmillis * 24
        elapseddays = msdiff / dayinmillis
        elapsedhours = msdiff / hourinmillis
        elapsedminutes = msdiff / minuteinmillis
        if(elapseddays !=0):
                 return str(elapseddays) + " days"
        if(elapsedhours !=0):
                return str(elapsedhours) + " hours"
        if(elapsedminutes !=0):
                return str(elapsedminutes) + " minutes"
timediff = actualfinish.getTime() - actualstart.getTime()
                  timespent = calcelapsedtime(timediff)
```
Test the revised script by opening the Service Requests application and saving the updated description on the same record that was used previously. The following error is displayed:

```kotlin
    BMXAA7837E - An error occured that prevented the CALCELAPSEDTIME script for the CALCELAPSEDTIME launch point from running.
    TypeError: unsupported operand type(s) for /: 'java.math.BigInteger' and 'int' in <script> at line number 20
```

The calcelapsedtime() function is called at the end of the script. Yet the error message specifies an ‘unsupported operand type for /’ indicating the operation being attempted is a division. The problem is in the first division operation occurring on line 7 of the script:

```python
     elapseddays = msdiff / dayinmillis
```
The parameter that is passed into the calcelapsedtime() function is not a long value but a java.math.BigInteger object. Jython does not support automatic conversion of the Java BigInteger object to a long value. Revise the script by converting the BigInteger object to a long value and pass the long value to the calcelapsedtime() function. Here’s the final script:

```python
        def calcelapsedtime(msdiff):
        secondinmillis = 1000
        minuteinmillis = secondinmillis  * 60
        hourinmillis = minuteinmillis * 60
        dayinmillis = hourinmillis * 24
        elapseddays = msdiff / dayinmillis
        elapsedhours = msdiff / hourinmillis
        elapsedminutes = msdiff / minuteinmillis
        if(elapseddays !=0):
                 return str(elapseddays) + " days"
        if(elapsedhours !=0):
                return str(elapsedhours) + " hours"
        if(elapsedminutes !=0):
                return str(elapsedminutes) + " minutes"
        timediff = actualfinish.getTime() - actualstart.getTime()
        timespent = calcelapsedtime(timediff.longValue())
```

Test the final script on the service request record and, this time, the elapsed time is successfully written into the Time Spent field:

[Calculation](sample06-1/pic3.jpeg)                            

A test on a different service request record yields this output into the Time Spent field:

[Calculation](sample06-1/pic4.jpeg) 


The script consists of two parts:

    1 - A function <code>calcelapsedtime()</code> that accepts a long value that reporesents elapsed time in milliseconds and divides it by using various factors to establish human-readable elapsed time that is measured in days, hours, or minutes. This function returns a string back to the main script to resporesent a nicely formatted elapsed time period.
    2 - The main body of the script that accepts the two input variables, actualfinish and actual start, executes the subtraction, and invokes the function with the time difference passed in as a long value.

The logic within the <code>calcelapsedtime()</code> function is simple. The passed in long value, which is in milliseconds, is progressively divided by a number that represents a time conversion in days, hours, or minutes. Only one of the operations results in a non-zero result. That result is returned to the main script.


## Summary

Dates-based calculations in Maximo scripting are not difficult to create. It is important to understand which Maximo data type you are working with and how the script framework passes a representation to the script. With that insight, you can create useful scripts that deliver application enhancements rapidly to end users. You can find copy of the script here [datedifference](sample06-1/datedifference.py)


## Useful Links

[Java Date class and methods](http://download.oracle.com/javase/6/docs/api/java/util/Date.html)

[Java Timestamp class and methods](http://download.oracle.com/javase/6/docs/api/java/sql/Timestamp.html)

[Java BigInteger class and methods](http://download.oracle.com/javase/6/docs/api/java/math/BigInteger.html)

[Jython operators](http://www.jython.org/jythonbook/en/1.0/OpsExpressPF.html)

[Jython functions](http://www.jython.org/jythonbook/en/1.0/DefiningFunctionsandUsingBuilt-Ins.html)

[Working with Java Date objects – good introduction with examples](http://www.javaworld.com/javaworld/jw-03-2001/jw-0330-time.html)

[Maximo 7.5 scripting cookbook](http://www.javaworld.com/javaworld/jw-03-2001/jw-0330-time.html)
