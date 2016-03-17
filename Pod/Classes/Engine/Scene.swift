//
//  Place.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit

public class Scene: NSObject {
    
    let npcs: [Npc]?
    let nextScene: Scene?
    
    public let text: String
    public let actions: [Action]?
    
    public var selectedAction: Action?
    public var notBefore: NSDate?
    
    public init(text: String, actions: [Action]?, npcs: [Npc]?, nextScene: Scene?) {
        self.text = text
        self.actions = actions
        self.npcs = npcs
        self.nextScene = nextScene
    }
}

extension Scene {
    public func getNext() -> Scene? {
        guard let nxt = nextScene else {
            return actions?.filter({ action in
                return action == selectedAction
            }).first?.nextScene
        }
        if let nbf = nxt.notBefore {
            if NSDate().compare(nbf) == .OrderedAscending {
                return nil
            }
        }
        return nxt
    }
    
    public func rows() -> Int {
        guard let actions = actions else {
            return 1
        }
        return actions.count
    }
}