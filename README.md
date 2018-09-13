# Maximo automation scripting 

This document is a **Work in Progress**

This document is not intended to be a substitute for the official Maximo API documentation. If any contradiction is present, you must consider the official documentation as the source of truth.

You must have a basic knowledge about Maximo Asset Management and development, mainly Java, XML and HTTP requests. You must be also familiar with Maximo applications and modules. 

## About the Maximo automation scripting repository

Welcome to the Maximo automation scripting repository. Join us and use this technical repository to share ideas, solutions, and problems with other Maximo developers. The goal of this repository is for users to learn and share customizations that use scripting in Maximo Asset Management.
 
<face color=RED><b>NOTE:</b> This repository is not intended to act as a communication channel to Maximo Support regarding defects. Use the normal support channels for reporting defects.</face>

It is important to note that automation scripts are custom code. Support does not engage in writing scripts or debugging custom scripts. Any atuomation scripts that are provided in this repository by IBM or others are intended to be samples and are not supported by IBM.

## About Maximo automation scripts

An automation script consists of a launch point, variables that have corresponding binding values, and the source code. You use wizards to create the components of an automation script. You create automation scripts and launch points or you create a launch point and associate the launch point with an existing automation script.

### Prerequisite skills

To automate tasks, you must have knowledge in the following areas:

* Scripting language syntax and operations
* Product configurations, such as workflow processes, escalations, and actions
* Application data models and relationships

Experience with Maximo® business object (MBO) API is an advantage although not a prerequisite.

### Components of automation scripts

For an automation script to run, you specify the following components:

* A launch point that defines the context for the script to run
* Variables and corresponding binding values
* Source code written in a supported scripting language

### Launch point
    
    A launch point defines the execution context for an automation script, for example when a business object is updated or a value is entered into a field. Some types of launch point are supported and the Automation Scripts application provides a separate wizard application for creating each type of launch point.

### Variables and binding values
    
    You can specify the variables that determine how information is passed into or received from an automation script in the wizard applications. Variables are not mandatory, but when you use variables it simplifies the amount of code that is written and makes it easier to reuse the code.

### Source code
    
    You can write source code in an external application and import it into the Automation Scripts application. Alternatively, you can enter code directly into the **Source Code** field in the wizard applications. The source code must be written in the languages that are supported by the following script engines:

        Mozilla Rhino, version 1.6 release 2
        Jython, version 2.5.2


## Environment prerequisites

You must have an active Maximo user account to use these APIs.

## Getting Start with Maximo automation scripting

This section is intended to get you started with the basics of automation scripts, including which application to use, which fields to use,  and how you can run your automation scripts. 

## Maximo automation scripts 
    
Automation scripts are small, targeted pieces of code that can be authored, saved, and instantly activated in a Tivoli's Process Automation Engine-based product environment to extend the product. Automation scripts were first introduced with the 7.5 release of Tivoli's Process Automation Engine. Since this release, the capability has been welcomed and adapted by clients and implementers as an accelerated approach to implementing the desired solution.

This README.MD document serves as a landing page for learning and experimenting with automation scripts. Links will be added to other sources of automation script information that may be published by IBM or the broader user community. Examples of scripting will be listed here over time.

## Maximo Automation Scripting & Sample Packages

The following recipes can help you get started with automation scripts: 

<table>
    <tr>
        <th>Sample ID</th>
        <th>Sample Description & Sample Link</th>
    </tr>
    <tr>
        <td align='center'>01</td>
        <td align='left'>
        <a href="samples/AS10_creatingAS.md">Creating and import an automation script</a>
        </td>
    </tr>
    <tr>
        <td align='center'>02</td>
        <td align='left'>
        <a href="samples/AS01_scheduleDates.md">Automation script that sets actual dates from scheduled dates when a work order is completed.</a>
        </td>
    </tr>
    <tr>
        <td align='center'>03</td>
        <td align='left'>
        <a href="samples/AS02_makeWorkFlow.md">Automation script makes the workflow follow the status privileges that are defined by Security Groups</a>
        </td>
    </tr>
    <tr>
        <td align='center'>04</td>
        <td align='left'>
        <a href="samples/AS03_notifyUsers.md">Notify users of material and service receipts</a>
        </td>
    </tr>
    <tr>
        <td align='center'>05</td>
        <td align='left'>
        <a href="samples/AS04_workflowcondition.md">Worklog condition</a>
        </td>
    </tr>
    <tr>
        <td align='center'>06</td>
        <td align='left'>
        <a href="samples/AS05_useSequence.md">Use sequence instead autokeyn</a>
        </td>
    </tr>
    <tr>
        <td align='center'>07</td>
        <td align='left'>
            <a href="samples/AS06_dateCalculationP1.md">Date Calculation - Part 1</a>
            <br>
            <a href="samples/AS06_dateCalculationP2.md">Date Calculation - Part 2</a>
            <br>
            <a href="samples/AS06_dateCalculationP3.md">Date Calculation - Part 3</a>
            </td>
    </tr>
    <tr>
        <td align='center'>08</td>
        <td align='left'>
        <a href="samples/AS07_executeReport.md">Scripting report execution</a>
        </td>
    </tr>
    <tr>
        <td align='center'>09</td>
        <td align='left'>
        <a href="samples/AS08_emailListener.md">Extending email listener by using scripting</a>
        </td>
    <tr/>
     <tr>
        <td align='center'>10</td>
        <td align='left'>
        <a href="samples/AS09_businessRule.md">Turning off a Maximo built-in business rule by using scripting</a>
        </td>
    <tr/>
     <tr>
        <td align='center'>11</td>
        <td align='left'>
        <a href="samples/AS11_importExportScripts.md">How to import/export an automation script into a .dbc file.</a>
        </td>
    <tr/>
    </table>

## Maximo automation scripting official documentation: 

[Official Documentation - Maximo Automation Scripting 7.5](https://www.ibm.com/support/knowledgecenter/SSLKT6_7.5.0.5/com.ibm.mbs.doc/autoscript/t_ctr_automate_routine_app_tasks.html)

[Official Documentation - Maximo Automation Scripting 7.6](https://www.ibm.com/support/knowledgecenter/SSLKT6_7.6.0/com.ibm.mbs.doc/autoscript/t_ctr_automate_routine_app_tasks.html)    

## Document references 

[IBM developerWorks](https://www.ibm.com/developerworks/community/wikis/home?lang=en#!/wiki/IBM%20Maximo%20Asset%20Management/page/Customizing%20with%20automation%20scripts)

[Scripting with Maximo Wiki](https://www.ibm.com/developerworks/community/blogs/a9ba1efe-b731-4317-9724-a181d6155e3a/entry/scripting_with_maximo6?lang=en)

[Scripting with Maximo.pdf](https://www.ibm.com/developerworks/community/forums/ajax/download/77777777-0000-0000-0000-000014772567/b8ec7d85-6a8d-4e25-bb89-d729c3322406/attachment_14772567_Scripting_with_Maximo.pdf)

[Collection of Automation Scripts for Maximo](https://www.ibm.com/developerworks/community/blogs/a9ba1efe-b731-4317-9724-a181d6155e3a/entry/My_Collection_of_Automation_Scripts?lang=en)
## Important references

<b>NOTE:</b> Scripts are pieces of code. Products that are based on Tivoli's Process Automation Engine version 7.5 ship Jython and JavaScript engines to support automation scripts. The ability to use the right syntax and develop programming logic is a prerequisite to using automation scripts. These links provide significant details and examples on basic programming with Jython and JavaScript.

[Jython Tutorial](http://www.jython.org/docs/tutorial/indexprogress.html)

[Rhino JavaScript Documentation](https://developer.mozilla.org/en-US/docs/Rhino_documentation)

Automation scripting is built on top of the Java JSR-223 standard for using scripting languages in a Java Virtual Machine. This link provides the specification details for the JSR-223 standard.

[JSR-223 specification](https://jcp.org/en/jsr/detail?id=223)
