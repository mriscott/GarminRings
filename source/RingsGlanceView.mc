//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics;

class RingsGlanceView extends Ui.GlanceView {


    // Load your resources here
    function onLayout(dc) {
    }

    function onShow() {

    }

    function update(){
      Ui.requestUpdate();
    }

    // Update the view
    function onUpdate(dc) {
	var weekday=(Time.Gregorian.info(Time.today(),Time.FORMAT_SHORT).day_of_week-1);
	if(weekday==0){
	    weekday=7;
	}
	var info = ActivityMonitor.getInfo();
	var actMsgW = "WTD:"+info.activeMinutesWeek.total;
	var actgoal=info.activeMinutesWeekGoal/7;

	var actw=(info.activeMinutesWeek.total)/(actgoal*weekday);
	var weektarget=(actgoal*weekday);
	if(weekday==7){
	    weektarget=info.activeMinutesWeek;
        }
	
	 
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        dc.drawText(5, dc.getHeight()/4, Graphics.FONT_SMALL, "Int mins", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
	dc.drawLine(0,dc.getHeight()/2,dc.getWidth(),dc.getHeight()/2);
	dc.drawText(5, dc.getHeight()/4*3, Graphics.FONT_SMALL, ""+info.activeMinutesWeek.total+"/"+weektarget, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
	dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
	dc.fillRectangle(0,dc.getHeight()/2-3,((dc.getWidth()*info.activeMinutesWeek.total)/weektarget),6);
			 
       }

    // Called when this View is removed from the screen. Save the
    // state of your app here.
    function onHide() {
    }



}
