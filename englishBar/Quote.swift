//
//  Quotes.swift
//  englishBar
//
//  Created by Konstantin Mashirov on 13/01/2019.
//  Copyright © 2019 Konstantin Mashirov. All rights reserved.
//

import SwiftyJSON

struct Quote {
    
    static func getFromJson (name: String) -> Array<JSON> {
        var output:[JSON] = []
        if let file = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: file))
                let json = try JSON(data: data)
            
                output = json["Data"].arrayValue
            } catch {
                print("Contents could not be loaded.")
            }
        }
        return output
    }
}
