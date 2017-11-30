//
//  Place.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import Foundation
import Gloss

public class Scene: Object, Glossy {
    
    let npcs: [Npc]?
    let nextScene: Scene?
    var enteredAt: Date?

    public let text: String
    public let actions: [Action]?
    
    public var selectedAction: Action?
    public var notBefore: TimeInterval?
    
    public required init?(json: JSON) {
        guard
            let _: String = "id" <~~ json,
            let text: String = "text" <~~ json
        else { return nil }
        
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
        if let notBefore: TimeInterval = "notBefore" <~~ json {
            self.notBefore = notBefore
        }
        if let enteredAt: TimeInterval = "enteredAt" <~~ json {
            self.enteredAt = Date(timeIntervalSince1970: enteredAt)
        }
    }
    
    public init(text: String, actions: [Action]?, npcs: [Npc]?, nextScene: Scene?) {
        self.text = text
        self.actions = actions
        self.npcs = npcs
        self.nextScene = nextScene
    }
    
    public func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> id,
            "text" ~~> text,
            "actions" ~~> actions,
            "npcs" ~~> npcs,
            "nextScene" ~~> nextScene,
            "selectedAction" ~~> selectedAction,
            "notBefore" ~~> notBefore,
            "enteredAt" ~~> enteredAt?.timeIntervalSince1970
        ])
    }
}

extension Scene {
    func getNext() -> Scene? {
        guard let nxt = nextScene else {
            return selectedAction?.nextScene
        }
//        if let nbf = nxt.notBefore, let eat = nxt.enteredAt {
//            if Date(timeIntervalSince1970: eat.timeIntervalSince1970 + nbf).compare(Date()) == .orderedDescending {
//                return nil
//            }
//        }
//        nxt.enteredAt = Date()
        return nxt
    }
    
    func rows() -> Int {
        guard let actions = actions else {
            return 1
        }
        return actions.count
    }
}
