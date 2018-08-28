//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;

class RingsDelegate extends Ui.BehaviorDelegate {
    var notify;

    // Handle menu button press
    function onMenu() {
        handlePress();
        return true;
    }

    function onSelect() {
        handlePress();
        return true;
    }
    
    function handlePress() {
        notify.invoke("Executing\nRequest");
    }

    // Set up the callback to the view
    function initialize(handler) {
        Ui.BehaviorDelegate.initialize();
        notify = handler;
    }

}

