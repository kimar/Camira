//
//  ActionTests.swift
//  Camira
//
//  Created by Marcus Kida on 16/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import XCTest
import Camira

class PlaceTests: XCTestCase {
    
    var action: Action!
    var scene: Scene!
    var nextScene: Scene!
    
    override func setUp() {
        super.setUp()
        
        nextScene = Scene(text: "NextPlace", actions: nil, npcs: nil, nextScene: nil)
        action = Action(text: "TestAction", nextScene: nextScene)
        scene = Scene(text: "TestPlace", actions: [action], npcs: nil, nextScene: nil)
    }
    
    override func tearDown() {
        scene = nil
        action = nil
        nextScene = nil
        super.tearDown()
    }
    
    func test_nextPlace() {
        scene.selectedAction = action
        XCTAssertEqual(nextScene, scene.getNext())
    }
    
}
