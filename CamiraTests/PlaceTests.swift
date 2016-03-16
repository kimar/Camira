//
//  ActionTests.swift
//  Camira
//
//  Created by Marcus Kida on 16/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import XCTest
@testable import Camira

class PlaceTests: XCTestCase {
    
    var action: Action!
    var place: Place!
    var nextPlace: Place!
    
    override func setUp() {
        super.setUp()
        
        nextPlace = Place(text: "NextPlace", actions: nil, npcs: nil, nextPlace: nil)
        action = Action(text: "TestAction", nextPlace: nextPlace)
        place = Place(text: "TestPlace", actions: [action], npcs: nil, nextPlace: nil)
    }
    
    override func tearDown() {
        place = nil
        action = nil
        super.tearDown()
    }
    
    func test_nextPlace() {
        place.selectedAction = action
        XCTAssertEqual(nextPlace, place.getNext())
    }
    
}
