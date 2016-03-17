//
//  GameTests.swift
//  Camira
//
//  Created by Marcus Kida on 16/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import XCTest
@testable import Camira

class GameTests: XCTestCase {
    
    var scene: Scene!
    var player: Player!
    var game: Game!
    
    override func setUp() {
        super.setUp()
        
        scene = Scene(text: "TestPlace", actions: nil, npcs: nil, nextScene: nil)
        player = Player(name: "TestPlayer")
        game = Game(title: "TestGame", subtitle: "TestGame", initial: scene, player: player)
    }
    
    override func tearDown() {
        scene = nil
        player = nil
        game = nil
        super.tearDown()
    }
    

    func test_steps_initial() {
        XCTAssertEqual(game.steps().count, 1)
    }
    
    func test_steps_final() {

        let place2 = Scene(text: "TestPlace2", actions: nil, npcs: nil, nextScene: nil)
        let action = Action(text: "TestAction", nextScene: place2)
        
        scene = Scene(text: "TestPlace", actions: [action], npcs: nil, nextScene: nil)
        scene.selectedAction = action
        
        player = Player(name: "TestPlayer")
        game = Game(title: "TestGame", subtitle: "TestGame", initial: scene, player: player)
        
        XCTAssertEqual(game.steps().count, 2)
    }
}
