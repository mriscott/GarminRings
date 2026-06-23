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
    var floorgoal=0;
    var actgoal=0;
    var weekday=0;

    function initialize() {
        Ui.View.initialize();
	System.println("Init");
	var day=Application.getApp().getProperty("day");
	System.println("Day:"+day);
	var today = Time.today().value();
	if(day!=today){	  
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
	dc.drawText(dc.getWidth()/2, dc.getHeight()/2 +offset, Graphics.FONT_TINY, message, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }


    // Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
	var weekday=(Time.Gregorian.info(Time.today(),Time.FORMAT_SHORT).day_of_week-1);
	if(weekday==0){
	    weekday=7;
	}
	System.println("Today:"+weekday);
	var info = ActivityMonitor.getInfo();
	var actMsgD = "  Int:"+info.activeMinutesDay.total;
	var actMsgW = "  WTD:"+info.activeMinutesWeek.total;
	var floorMsg="Floor:"+info.floorsClimbed;
	var stepMsg=" Step:"+info.steps;


	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
	dc.clear();

	 if (actgoal==0) {
	   actgoal=info.activeMinutesWeekGoal/7;
	 }
	 var targetyesterday=actgoal*(weekday-1);
	 var progress=info.activeMinutesWeek.total-targetyesterday;
	 if(progress<0){
	     progress=0;
	 }
	 System.println("wtd:"+progress);
	 
	 var actd=360*info.activeMinutesDay.total/actgoal;
	 var actw=360*progress/actgoal;
	 if(actw<0){
	     actw=0;
	 }
	 
	 var steps=360*info.steps/info.stepGoal;
	var floors=360*info.floorsClimbed/info.floorsClimbedGoal;	 


	    
        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
	drawMsg(dc,-1.5,actMsgD);
	drawRing(dc,100,actd);

	dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
	drawMsg(dc,-0.5,actMsgW);
	drawRing(dc,90,actw);

	dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
	drawMsg(dc,0.5,floorMsg);
	drawRing(dc,80,floors);
	
	dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
	drawMsg(dc,1.5,stepMsg);
	drawRing(dc,70,steps);

	


	
    }

    // Called when this View is removed from the screen. Save the
    // state of your app here.
    function onHide() {
    }
    
    function onReceive(x){
    }



}


