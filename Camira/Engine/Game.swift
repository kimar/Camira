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

public class Game: Glossy {
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
            "title" ~~> title,
            "subtitle" ~~> subtitle,
            "initial" ~~> initial,
            "player" ~~> player
        ])
    }
}

extension Game {
    func steps() -> [Scene] {
        return steps(scenes: [])
    }
    
    private func steps(scenes: [Scene]) -> [Scene] {
        guard scenes.count > 0 else {
            return steps(scenes: [initial])
        }
        
        guard let scene = scenes.last?.getNext() else {
            return scenes
        }
        
        return steps(scenes: [scenes, [scene]].flatMap {$0})
    }
}
