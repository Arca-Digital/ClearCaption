//
//  ViewController.swift
//  clearCaption
//
//  Created by rick on 28/8/21.
//

import Cocoa

// TODO: listen for key combination, to activate the editor quickly

class ViewController: NSViewController {
    @IBOutlet private weak var textField: NSTextField!
    private var previousApp: NSRunningApplication?
    
    override func viewDidAppear() {
        super.viewDidAppear()
        setupView()
        NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged) { [weak self] in
                    switch $0.modifierFlags.intersection(.deviceIndependentFlagsMask) {
                    case [.shift, .control, .option]:
                        self?.previousApp = NSWorkspace.shared.frontmostApplication
                        NSApplication.shared.activate(ignoringOtherApps: true)
                        self?.view.window?.makeFirstResponder(self?.textField)
                    default:
                        break
                    }
                }
    }
    
    private func setupView() {
        guard let window = view.window else {
            print("Can't get window")
            return
        }
        // Transparent window
        window.isOpaque = false
        window.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
        window.isMovableByWindowBackground = true
        window.isMovable = true
        window.level = .floating
        
        textField.drawsBackground = false
        textField.backgroundColor = NSColor.clear
        textField.isBezeled = false
        textField.maximumNumberOfLines = 0
        textField.lineBreakMode = .byCharWrapping
        textField.preferredMaxLayoutWidth = 0
    }
    
    @IBAction func onSubmitText(_ sender: NSTextField) {
        DispatchQueue.main.async { [view, previousApp] in
            sender.setAccessibilitySelectedTextRange(NSRange(location: sender.stringValue.count-1, length: 0))
            view.window?.makeFirstResponder(nil)
            let size = sender.attributedStringValue.size()
            self.preferredContentSize = CGSize(width: size.width + 45, height: size.height)
            if let windowBottom = view.window?.frame.minY,
                  let screenBottom = view.window?.screen?.frame.minY,
                  let windowLeft = view.window?.frame.minX,
                  windowBottom < screenBottom {
                view.window?.setFrameOrigin(NSPoint(x: windowLeft, y: screenBottom))
            }
            previousApp?.activate(options: [.activateAllWindows, .activateIgnoringOtherApps])
        }
    }
}

