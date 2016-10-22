//
//  Npc.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import Foundation
import Gloss

public class Npc: Glossy {
    var alive = true
    
    func kill () {
        self.alive = false
    }
    
    func revive () {
        self.alive = true
    }
    
    public required init?(json: JSON) {
        if let alive: Bool = "alive" <~~ json {
            self.alive = alive
        }
    }
    
    public func toJSON() -> JSON? {
        return jsonify([
            "alive" ~~> alive
        ])
    }
}
