# JavaScript-based date calculation

## Introduction

You can create a JavaScript-based script to calculate dates.

    1 - In the Automation Scripts application, define a new action launch point and create the JavaScript-based script, which generates an action.
    2 - In the Escalation application, update the SRDDESC escalation to point to the new action.

## New action launch point, action, and script

All three entities, action launch point, action and script, are named SRDDACTIONJS, and the script language is ‘javascript’. Associate the same input and output variables: input variables – reportdate; output variables – targetcontactdate, targetstartdate.

The JavaScript code is shown below.

```java
    function ISODateString (d)
    {
      function pad(n){return n<10 ? '0'+n : n}
      return d.getUTCFullYear()+'-' 
           + pad(d.getUTCMonth()+1)+'-' 
           + pad(d.getUTCDate())+'T' 
           + pad(d.getUTCHours())+':' 
           + pad(d.getUTCMinutes())+':' 
          + pad(d.getUTCSeconds())
    }

    println ('SRDDACTIONJS - script execution started');
    var currentTime = new Date(reportdate.getTime());
    currentTime.setDate(currentTime.getDate() + 1) ;
    targetcontactdate = ISODateString(currentTime);
    currentTime.setDate (currentTime.getDate() + 1);
    targetstartdate = ISODateString(currentTime);
    println ('SRDDACTIONJS - script execution complete'); 
```

The basic logic in the script is based on using the reportdate to calculate the targetcontactdate and targetstartdate. Targetcontactdate is calculated to be 1 day from reportdate, and the targetstartdate is calculated to be 2 days from reportdate.The JavaScript Date object is the primary object that is used to calculate the required dates

The following considerations must be accommodated:

1. The input variable reportdate is a Java-based Date object. It cannot be used as is with the JavaScript Date object. A JavaScript Date object can be initialized a number of ways. Initialize the JavaScript Date object as a value that represents time in milliseconds. Use the Java Date object’s getTime() method to obtain the ‘reportdate’ time value in milliseconds and construct the JavaScript Date object from that millisecond value.
2. Determine a suitable way of returning the calculated date that Maximo Asset Management can accept and set into the attributes of the target SR record.
3. Returning the value from a JavaScript Date.toDateString() or Date.toLocaleDateString() results in the following error: “BMXAA4144E - The date/time format is not valid. Make sure the date/time is specified in a valid format supported by the current locale setting”.
4. Returning the value from a JavaScript Date.getTime() results in the following error: “BMXAA7816E - Operation setValue(double value) is not supported on data type DATETIME. Report the error to your system administrator.”

Maximo Asset Management requires date values to be to a certain format. One of the acceptable formats is a date time value that is  represented in the ISO 8601 format. The ISODateString() in the sample script accepts the JavaScript Date object as parameter and constructs an ISO 8601-formatted date-time string. The ISO 8601 format is usually expressed in the following format:

```kotlin
<full year>-<month>-<day>T<hours>:<minutes>:<seconds>
```

or as:

```kotlin
YYYY-MM-DDThh:mm:ss
```

In the function, the call to Date.getUTCMonth() is followed by a ‘+1’, because that method returns an integer between 0 and 11, and an integer between 1 and 12 is needed.

By including a simple println() statement in the body of the script, you can view the output of the ISODateString() function. It is similar to the following output:

```kotlin 
2011-12-26T04:37:33
```
The pad() function inside the ISODateString() function is used to place a zero to the left of the number (month, date, hours, minutes or seconds) if that number is below 10 to ensure the final string is ISO 8601-compliant.

## Testing the new script

1. In the Escalations application, open the SRDDESC escalation definition.
2. Deactivate the escalation, if needed, and then delete the SRDDACTIONJAVA action.
3. Associate the new action SRDDACTIONJS with the escalation. Save and activate.

## Summary

Date calculations can be performed by using JavaScript’s Date object. The one drawback is the difficulty in formatting date and time strings, which can be overcome by writing simple functions.

## Useful Links

[Maximo 7.5 Scripting Cookbook](https://www.ibm.com/developerworks/mydeveloperworks/blogs/a9ba1efe-b731-4317-9724-a181d6155e3a/entry/scripting_with_maximo6?lang=en)

[Date Dizziness – Part I](AS06_dateDizzinessP1.md)

[Date Dizziness – Part II](AS06_dateDizzinessP2.md)

[Mozilla JavaScript Date object and methods](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Date)

