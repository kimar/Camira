//
//  Action.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit

public class Action: NSObject {

    let nextPlace: Place

    public let text: String
    public var selected = false

    public init(text: String, nextPlace: Place) {
        self.text = text
        self.nextPlace = nextPlace;
    }
}
