//
//  QuotesViewController.swift
//  englishBar
//
//  Created by Konstantin Mashirov on 13/01/2019.
//  Copyright © 2019 Konstantin Mashirov. All rights reserved.
//

import Cocoa

class QuotesViewController: NSViewController {

    @IBOutlet var textLabel: NSTextView!
    @IBOutlet var textExample: NSTextField!
    
    static var mainTitle = "Loading..."
    
    let quotes = Quote.getFromJson(name: "Objects")
    var currentQuoteIndex: Int = 0 {
        didSet {
            updateQuote()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuoteIndex = 0
    }
    
    public static func getTitle() -> String {
       
        return mainTitle
    }

    func updateQuote() {
        
        print ("UPDATE")
        
        //textLabel.string = String(describing: quotes[currentQuoteIndex])
        let enWord = String(describing: quotes[currentQuoteIndex]["VocabularyWord"])
        
        var text = ""
        
        for (index,subJson) in quotes[currentQuoteIndex]["EnglishExamples"] {
            let nextI: Int = Int(index)!
            text += "\(nextI + 1). "
            text +=  String(describing: subJson)
            text += "\n\n"
            print(subJson)
        }
        
        textExample.stringValue = String(describing: text)

        let scores = ["word": enWord]
        NotificationCenter.default.post(name: .didReceiveData, object: nil, userInfo: scores)
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
    
    static func freshController() -> QuotesViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("QuotesViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? QuotesViewController else {
            fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
