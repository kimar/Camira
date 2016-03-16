//
//  Object.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit

public class Object: NSObject {
    let name: String
    var quantity = 1
    
    public init(name: String) {
        self.name = name
    }
}
