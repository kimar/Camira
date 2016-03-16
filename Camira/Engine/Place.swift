//
//  Place.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit

public class Place: NSObject {
    
    let text: String
    let actions: [Action]?
    let npcs: [Npc]?
    let nextPlace: Place?
    
    var selectedAction: Action?
    public var delay: Int?
    
    public init(text: String, actions: [Action]?, npcs: [Npc]?, nextPlace: Place?) {
        self.text = text
        self.actions = actions
        self.npcs = npcs
        self.nextPlace = nextPlace
    }
}

extension Place {
    func getNext() -> Place? {
        return actions?.filter { action in
            return action == selectedAction
        }.first?.nextPlace
    }
    
    func rows() -> Int {
        guard let actions = actions else {
            return 1
        }
        return actions.count
    }
}