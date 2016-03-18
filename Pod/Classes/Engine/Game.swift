//
//  Game.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit

@objc public protocol GameDelegate {
    optional func gameWillReloadData (game: Game)
}

public class Game: Object, Persistable, Mapable {
    let title: String
    let subtitle: String
    
    let initial: Scene
    let player: Player
    
    var step = 1
    
    weak var delegate: GameDelegate?
        
    public init(title: String, subtitle: String, initial: Scene, player: Player, delegate: GameDelegate? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.initial = initial
        self.player = player
        self.delegate = delegate
    }
    
    
    // MARK: - Persistable
    func persist() -> String? {
        return JSON(
            game: self
        ).serialize()
    }
    
    func restore(persisted: String) {
        
    }
    
    // MARK: - Mapable
    func map() -> [String : AnyObject] {
        return [
            "uuid": id,
            "title": title,
            "subtitle": subtitle,
            "initial": initial,
            "player": player
        ]
    }
}

extension Game {
    func steps() -> [Scene] {
        return steps([])
    }
    
    private func steps(scenes: [Scene]) -> [Scene] {
        guard scenes.count > 0 else {
            return steps([initial])
        }
        
        guard let scene = scenes.last?.getNext() else {
            return scenes
        }
        
        return steps([scenes, [scene]].flatMap {$0})
    }
}
