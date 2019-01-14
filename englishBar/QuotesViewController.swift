//
//  QuotesViewController.swift
//  com.mashirov
//
//  Created by Konstantin on 13/01/2019.
//  Copyright © 2019 Konstantin. All rights reserved.
//

import Cocoa

class QuotesViewController: NSViewController {

    @IBOutlet var textLabel: NSTextView!
    
    
    let quotes = Quote.all
    
    var currentQuoteIndex: Int = 0 {
        didSet {
            updateQuote()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuoteIndex = 0
    }
    
    func updateQuote() {


        textLabel.string = String(describing: quotes[currentQuoteIndex])
    }
    
}
extension QuotesViewController {
    
    @IBAction func previous(_ sender: NSButton) {
        currentQuoteIndex = (currentQuoteIndex - 1 + quotes.count) % quotes.count
    }
    
    @IBAction func next(_ sender: NSButton) {
        currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
    }
    
    @IBAction func quit(_ sender: NSButton) {
        NSApplication.shared.terminate(sender)
    }
    
    // MARK: Storyboard instantiation
    static func freshController() -> QuotesViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier("QuotesViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? QuotesViewController else {
            fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
