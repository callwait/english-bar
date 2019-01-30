//
//  AppDelegate.swift
//  englishBar
//
//  Created by Konstantin Mashirov on 13/01/2019.
//  Copyright © 2019 Konstantin Mashirov. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
    let popover = NSPopover()
    @objc dynamic var helloTitle = QuotesViewController.getTitle()

    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        popover.contentViewController = QuotesViewController.freshController()

        if let button = statusItem.button {
            button.title = helloTitle
            button.action = #selector(togglePopover(_:))
        }
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)

    }

    @objc func onDidReceiveData(_ notification:Notification) {
        // Do something now
        
        if let data = notification.userInfo?["word"]
        {
            statusItem.button?.title = String(describing: data)
            print("OK!!", data)

        }
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func changeTitle(title: String) {
        print("OK")
    }


}

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let didCompleteTask = Notification.Name("didCompleteTask")
    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}
