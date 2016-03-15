//
//  Npc.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit

public class Npc: Object {
    var alive = true
    
    func kill () {
        self.alive = false
    }
    
    func revive () {
        self.alive = true
    }
}
