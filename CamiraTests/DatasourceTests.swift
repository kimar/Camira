//
//  DatasourceTests.swift
//  Camira
//
//  Created by Marcus Kida on 16/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import XCTest
@testable import Camira

class DatasourceTests: XCTestCase {
    
    var datasource: Datasource!
    
    override func setUp() {
        super.setUp()
        
        let place2 = Place(text: "TestPlace2", actions: nil, npcs: nil, nextPlace: nil)
        let action = Action(text: "TestAction", nextPlace: place2)
        
        let place = Place(text: "TestPlace", actions: [action], npcs: nil, nextPlace: nil)
        place.selectedAction = action
        
        let player = Player(name: "TestPlayer")
        let game = Game(title: "TestGame", subtitle: "TestGame", initialPlace: place, player: player)
        
        datasource = Datasource(game: game)
    }
    
    override func tearDown() {
        datasource = nil
        super.tearDown()
    }

    func test_datasource_numberOfRows() {
        XCTAssertEqual(datasource.numberOfRows(), 2)
    }
    
    func test_datasource_isActionRow_0() {
        XCTAssertTrue(datasource.isActionRow(NSIndexPath(forRow: 0, inSection: 0)))
    }
    
    func test_datasource_isActionRow_1() {
        XCTAssertFalse(datasource.isActionRow(NSIndexPath(forRow: 1, inSection: 0)))
    }
}
