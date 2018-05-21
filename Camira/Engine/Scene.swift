//
//  Place.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import Foundation

public class Scene: Object, Codable {
    
    let npcs: [Npc]?
    let nextScene: Scene?
    var enteredAt: Date?

    public let text: String
    public let actions: [Action]?
    
    public var selectedAction: Action?
    public var notBefore: TimeInterval?
    
    public init(text: String, actions: [Action]?, npcs: [Npc]?, nextScene: Scene?) {
        self.text = text
        self.actions = actions
        self.npcs = npcs
        self.nextScene = nextScene
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
