//
//  Game.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import Foundation

public protocol GameDelegate {
    func gameWillReloadData (game: Game)
}

fileprivate enum GameCodingKeys: String, CodingKey {
    case title = "title"
    case subtitle = "subtitle"
    case initial = "inital"
    case player = "player"
    case step = "step"
}

public class Game: Object, Codable {
    let title: String
    let subtitle: String
    
    let initial: Scene
    let player: Player
    
    public private(set) var step = 1
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GameCodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.subtitle = try container.decode(String.self, forKey: .subtitle)
        self.initial = try container.decode(Scene.self, forKey: .initial)
        self.player = try container.decode(Player.self, forKey: .player)
        self.step = try container.decode(Int.self, forKey: .step)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GameCodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(initial, forKey: .initial)
        try container.encode(player, forKey: .player)
        try container.encode(step, forKey: .step)
    }
    
    var delegate: GameDelegate?
        
    public init(title: String, subtitle: String, initial: Scene, player: Player, delegate: GameDelegate? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.initial = initial
        self.player = player
        self.delegate = delegate
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
