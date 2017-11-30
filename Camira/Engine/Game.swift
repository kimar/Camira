//
//  Game.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import Foundation
import Gloss

public typealias StoredGame = (json: JSON, step: Int)

public protocol GameDelegate {
    func gameWillReloadData (game: Game)
}

public class Game: Object, Glossy {
    let title: String
    let subtitle: String
    
    let initial: Scene
    let player: Player
    
    var step = 1
    
    var delegate: GameDelegate?
        
    public init(title: String, subtitle: String, initial: Scene, player: Player, delegate: GameDelegate? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.initial = initial
        self.player = player
        self.delegate = delegate
    }
    
    public convenience init?(storedGame: StoredGame) {
        self.init(json: storedGame.json)
        step = storedGame.step
    }
    
    public required init?(json: JSON) {
        guard
            let _: String = "id" <~~ json,
            let title: String = "title" <~~ json,
            let subtitle: String = "subtitle" <~~ json,
            let initial: Scene = "initial" <~~ json,
            let player: Player = "player" <~~ json
        else { return nil }
        
        self.title = title
        self.subtitle = subtitle
        self.initial = initial
        self.player = player
    }
    
    public func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> id,
            "title" ~~> title,
            "subtitle" ~~> subtitle,
            "initial" ~~> initial,
            "player" ~~> player
        ])
    }
}

extension Game {
    func steps() -> [Scene] {
        guard var next = initial.getNext() else {
            return [initial]
        }
        var scenes = [initial, next]
        while let nextNext = next.getNext() {
            next = nextNext
            scenes.append(next)
        }
        return scenes
    }
}
