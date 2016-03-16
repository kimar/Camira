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

public class Game: NSObject {
    let title: String
    let subtitle: String
    
    let initialPlace: Place
    let player: Player
    
    var currentStep = 1
    
    weak var gameDelegate: GameDelegate?
        
    public init(title: String, subtitle: String, initialPlace: Place, player: Player, gameDelegate: GameDelegate? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.initialPlace = initialPlace
        self.player = player
        self.gameDelegate = gameDelegate
        super.init()
    }

    
}
