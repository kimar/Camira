//
//  Action.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit

class Action: NSObject {
    let text: String!
    let nextPlace: Place!
    var selected = false
    
    init(text: String!, nextPlace: Place!) {
        self.text = text
        self.nextPlace = nextPlace;
        super.init()
    }
}
