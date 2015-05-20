//
//  Place.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit

enum CamiraPlaceAction: Int {
    case Left = 0, Right = 1
}

class Place: NSObject {
    let text: String!
    let actions:[Action]?
    let npcs:[Npc]?
    let nextPlace: Place?
    
    var selectedAction: CamiraPlaceAction?
    var delay: Int?
    
    init(text: String!, actions:[Action]?, npcs:[Npc]?, nextPlace: Place?) {
        self.text = text
        self.actions = actions
        self.npcs = npcs
        self.nextPlace = nextPlace
        super.init()
    }
}
