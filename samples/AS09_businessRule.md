# Turning a business rule by using scripting

## Work Order Tracking application - location and asset business rule

In Maximo Asset Management, the Work Order Tracking application is one of the most heavily used business applications. In versions 5.x, 6.x and 7.x, the following business rule is automatically: Populate the **Asset** field if the Location that is selected for the work order contains only one asset.

For many users, the auto-population of the **Asset** field is not useful. Most work orders are opened for a location, not an asset. When the **Asset** field is so populated by the application, users must consciously clear the entry before saving the work order record. An unwanted consequence of leaving the asset reference on the work order record is to have costs accrue to the wrong entity.

## "Turning off" the business rule

You can effectively turn off the business rule by using automation scripts. A simple attribute launch point and associated automation script can clear the value that is populated into the **Asset** field.

The attribute launch point and script are executed always after the standard business application field validation logic is executed. The job of the script logic is to determine whether the **Asset** field is empty or not, and if not empty, to set it to null. In the implementation, the script logic applies to a work order record that is newly inserted and n existing work order records that are modified.

Clearing the **Asset** field has an effect on other fields and business rules in the Work Order Tracking application. For example, a safety plan that is associated with the combination of asset and job plan will not be applied when the asset field is cleared automatically. In this particular example, if a user subsequently enters the asset, then the safety plan business rule will be launched, as expected.

## WOASSETCLR launch point and script

The following actions are required for the launch point and script implementation:

* Define an attribute launch point by using the Automation Scripts application.
* Specify that the business object is <code>WORKORDER</code> and the attribute is <code>LOCATION</code>.
* Define an <code>INOUT</code> variable <code>v_assetnum</code> and bind it to the <code>ASSETNUM</code> attribute of the <code>WORKORDER</code> object.
* Enter these lines of Jython code for the script:

```python
...
    if v_assetnum is not None:

            v_assetnum=None
...
```

* Save the launch point and script, and the launch point is already active.

## Testing the launch point

If you have a product environment that has a location that is associated with a single asset, create a work order and select that location. When you tab out of the **Location** field, the **Asset** field remains empty. The following screen captures shows the effect of the launch point and script.

Maximo Asset Management version 7.5 Work Order Tracking application with standard business rule (**Asset** field is populated):

[Business Rules](sample09/pic1.jpeg)
<center><font size=1><b>Figure 1</b> Work Order Configuration </font></center>

Maximo Asset Management version 7.5 Work Order Tracking application with the WOASSETCLRlaunch point enabled (**Asset** field is cleared automatically):

[Business Rules](sample09/pic2.jpeg)
<center><font size=1><b>Figure 2</b> Work Order Configuration </font></center>

## Summary

Automation scripts are an enabling component of the Maximo product architecture to incorporate business rules. However, in many cases, to incorporate business rules in the product, knowledge of the business application behavior is nrequired. Although only two lines of script code were needed to implement the turn off the business rule, a review of the implementation by a subject matter expert or experienced practitioner and testing in a development environment are essential before you make the business rule available to end users in a production environment.

## Useful Links

[Automation Scripting Cookbook](http://ibm.co/pPl32E)
