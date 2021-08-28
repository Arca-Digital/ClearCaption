//
//  AppDelegate.swift
//  clearCaption
//
//  Created by rick on 28/8/21.
//

import Cocoa
import Carbon

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }


}

