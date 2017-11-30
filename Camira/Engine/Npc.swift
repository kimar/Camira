//
//  Npc.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import Foundation
import Gloss

public class Npc: Object, Glossy {
    var alive = true
    
    func kill () {
        alive = false
    }
    
    func revive () {
        alive = true
    }
    
    public required init?(json: JSON) {
        guard
            let _: String = "id" <~~ json
        else { return nil }
        
        if let alive: Bool = "alive" <~~ json {
            self.alive = alive
        }
    }
    
    public func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> id,
            "alive" ~~> alive
        ])
    }
}
