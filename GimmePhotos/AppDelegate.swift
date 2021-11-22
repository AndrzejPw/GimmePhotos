//
//  AppDelegate.swift
//  GimmePhotos
//
//  Created by andrzej.biernacki on 28/08/2021.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBAction func onAboutMenuClicked(_ sender: NSMenuItem) {
    
        let options = [NSApplication.AboutPanelOptionKey.credits : NSAttributedString(string: "creditse we")]
        NSApplication.shared.orderFrontStandardAboutPanel(options: [:])
    }
    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}

