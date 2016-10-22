//
//  Place.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import Foundation
import Gloss

public class Scene: Glossy {
    
    let npcs: [Npc]?
    let nextScene: Scene?
    
    public let text: String
    public let actions: [Action]?
    
    public var selectedAction: Action?
    public var notBefore: Date?
    
    public required init?(json: JSON) {
        guard let text: String = "text" <~~ json else { return nil }
        self.text = text
        if let actions: [Action] = "actions" <~~ json {
            self.actions = actions
        } else { self.actions = nil }
        if let npcs: [Npc] = "npcs" <~~ json {
            self.npcs = npcs
        } else { self.npcs = nil }
        if let nextScene: Scene = "nextScene" <~~ json {
            self.nextScene = nextScene
        } else { self.nextScene = nil }
        if let selectedAction: Action = "selectedAction" <~~ json {
            self.selectedAction = selectedAction
        }
        if let notBefore: Date = "notBefore" <~~ json {
            self.notBefore = notBefore
        }
    }
    
    public init(text: String, actions: [Action]?, npcs: [Npc]?, nextScene: Scene?) {
        self.text = text
        self.actions = actions
        self.npcs = npcs
        self.nextScene = nextScene
    }
    
    public func toJSON() -> JSON? {
        let j = jsonify([
            "text" ~~> text,
            "actions" ~~> actions,
            "npcs" ~~> npcs,
            "nextScene" ~~> nextScene,
            "selectedAction" ~~> selectedAction,
            "notBefore" ~~> notBefore
            ])
        return j
    }
}

extension Scene {
    func getNext() -> Scene? {
        guard let nxt = nextScene else {
            return actions?.filter{ $0 === selectedAction }.first?.nextScene
        }
        if let nbf = nxt.notBefore {
            if Date().compare(nbf) == .orderedAscending {
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
}
