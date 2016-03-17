//
//  Place.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit

public class Place: NSObject {
    
    let npcs: [Npc]?
    let nextPlace: Place?
    
    public let text: String
    public let actions: [Action]?
    
    public var selectedAction: Action?
    public var notBefore: NSDate?
    
    public init(text: String, actions: [Action]?, npcs: [Npc]?, nextPlace: Place?) {
        self.text = text
        self.actions = actions
        self.npcs = npcs
        self.nextPlace = nextPlace
    }
}

extension Place {
    func getNext() -> Place? {
        guard let nxt = nextPlace else {
            return actions?.filter({ action in
                return action == selectedAction
            }).first?.nextPlace
        }
        if let nbf = nxt.notBefore {
            if NSDate().compare(nbf) == .OrderedAscending {
                return nil
            }
        }
        return nxt
    }
    
    func rows() -> Int {
        guard let actions = actions else {
            return 1
        }
        return actions.count
    }
    
//    public func selectAction(action: Action) -> Bool {
//        guard let _ = selectedAction else {
//            selectedAction = action
//            return true
//        }
//        return false
//    }
}