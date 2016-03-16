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
    
    var place: Place!
    var player: Player!
    var game: Game!
    
    override func setUp() {
        super.setUp()
        
        place = Place(text: "TestPlace", actions: nil, npcs: nil, nextPlace: nil)
        player = Player(name: "TestPlayer")
        game = Game(title: "TestGame", subtitle: "TestGame", initialPlace: place, player: player)
    }
    
    override func tearDown() {
        place = nil
        player = nil
        game = nil
        super.tearDown()
    }
    

    func test_steps_initial() {
        XCTAssertEqual(game.steps().count, 1)
    }
    
    func test_steps_final() {

        let place2 = Place(text: "TestPlace2", actions: nil, npcs: nil, nextPlace: nil)
        let action = Action(text: "TestAction", nextPlace: place2)
        
        place = Place(text: "TestPlace", actions: [action], npcs: nil, nextPlace: nil)
        place.selectedAction = action
        
        player = Player(name: "TestPlayer")
        game = Game(title: "TestGame", subtitle: "TestGame", initialPlace: place, player: player)
        
        XCTAssertEqual(game.steps().count, 2)
    }
}
