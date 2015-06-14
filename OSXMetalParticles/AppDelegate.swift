//
//  AppDelegate.swift
//  OSXMetalParticles
//
//  Created by Simon Gladman on 12/06/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        window.setContentSize(NSSize(width: 800, height: 600))
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true;
    }
    
}