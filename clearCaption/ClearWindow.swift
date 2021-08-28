//
//  ClearWindow.swift
//  ClearWindow
//
//  Created by rick on 28/8/21.
//

import Foundation
import AppKit

class ClearWindow: NSWindow {
    /// allows window to be a key window even without a title
    override var canBecomeKey: Bool { true }
    /// allows window to be a main window even without a title
    override var canBecomeMain: Bool { true }
}

class UnclickableTextField: NSTextField {
    /// Prevent users from tapping on text editor
    override func hitTest(_ point: NSPoint) -> NSView? {
        superview
    }
    
    ///  Allow users to drag window even when on top of text editor
    override var mouseDownCanMoveWindow: Bool { true }
}
