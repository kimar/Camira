//
//  PersistenceTests.swift
//  Camira
//
//  Created by Marcus Kida on 17/03/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import Camira

class PersistenceTests: XCTestCase {
    
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
    
    func test_Persistence() {
        let persist = game.persist()
        
    }
    
}
