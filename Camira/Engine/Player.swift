//
//  Player.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import Foundation
import Gloss

public class Player: Object, Glossy {

    let name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public required init?(json: JSON) {
        guard
            let _: String = "id" <~~ json,
            let name: String = "name" <~~ json
        else { return nil }
        
        self.name = name
    }
    
    public func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> id,
            "name" ~~> name
        ])
    }
}
