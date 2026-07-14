//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Application as App;

class RingsApp extends App.AppBase {
    hidden var mView;
    hidden var mGlanceView;


    function initialize() {
        App.AppBase.initialize();
    }

    function getWeekDay(){
	var weekday=(Time.Gregorian.info(Time.today(),Time.FORMAT_SHORT).day_of_week-1);
	if(weekday==0){
	    weekday=7;
	}
	return weekday;
    }

    function getDailyProgress(){
	var progress=ActivityMonitor.getInfo().activeMinutesWeek.total-getTargetYesterday();
	return progress;
    }
    function getAbsDailyProgress(){
	var progress=getDailyProgress();
	if(progress<0){
	    progress=0;
	}
	return progress;
    }

    function getDailyGoal(){
	return ActivityMonitor.getInfo().activeMinutesWeekGoal/7;
    }

    function getTargetToday(){
	return getDailyGoal()*getWeekDay();
    }
    
    function getTargetYesterday(){
	return getDailyGoal()*(getWeekDay()-1);
    }
    

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        mView = new RingsView();
        return [mView];
    }

    function getGlanceView() {
        mGlanceView = new RingsGlanceView();
        return [mGlanceView];
    }
    

}
