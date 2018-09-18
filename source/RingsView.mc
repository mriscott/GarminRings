//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Time;

class RingsView extends Ui.View {
    var stepgoal=0;
    var actgoal=0;
    var distgoal=500000;
    var water=0;
    var watergoal=2000;

    function initialize() {
        Ui.View.initialize();
	System.println("Init");
	water=Application.getApp().getProperty("water");
	var day=Application.getApp().getProperty("day");
	System.println("water:"+water);
	System.println("Day:"+day);
	var today = Time.today().value();
	System.println("Today:"+today);
	if(day!=today){	  
	  water=0;
          Application.getApp().setProperty("water",water);
	  Application.getApp().setProperty("day",today);
	}
    }


    // Load your resources here
    function onLayout(dc) {
	
    }

    function drawRing(dc, r, end){
       if (end>360){
         end=360;
       }
       var x=dc.getWidth()/2;
       var y=dc.getHeight()/2;
       for (var i=r;i<r+8;i++){
       	   if(end>0){
             dc.drawArc(x,y,i, 0, 0, end);
	   }
       }
    }

    function drawMsg(dc, offset, message) {
	offset*=23;
	dc.drawText(dc.getWidth()/2, dc.getHeight()/2 +offset, Graphics.FONT_MEDIUM, message, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }


    // Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
	var info = ActivityMonitor.getInfo();
        //var distMsg = "Dist:"+(info.distance/100);
	var stepMsg =  "Step : "+info.steps;
	var actMsg = "Act:"+info.activeMinutesDay.vigorous;
	//var calMsg =  "Cals : "+info.calories;
	var waterMsg="Water:"+water;

	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
	dc.clear();

	 if (stepgoal==0) {
	   stepgoal=info.stepGoal;
	 }

	 if (actgoal==0) {
	   actgoal=info.activeMinutesWeekGoal/7;
	 }

	 var steps=360*info.steps/stepgoal;
	 var act=360*info.activeMinutesDay.vigorous/actgoal;
	 //var dist=360*info.distance/distgoal;
	 var drunk=360*water/watergoal;
	 
        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
	drawMsg(dc,-1,actMsg);
	drawRing(dc,60,act);

	dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
	drawMsg(dc,0,waterMsg);
	drawRing(dc,70,drunk);

        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
	drawMsg(dc,1,stepMsg);
	drawRing(dc,80,steps);

	
    }

    // Called when this View is removed from the screen. Save the
    // state of your app here.
    function onHide() {
    }
    
    function onReceive(x){
       addWater();
    }

   function addWater(){
     water=water+125;
     if(water==10000) {
        water=0;
     }
     Application.getApp().setProperty("water",water);
     Ui.requestUpdate();
   }

}
