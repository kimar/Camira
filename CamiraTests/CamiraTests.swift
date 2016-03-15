//
//  CamiraTests.swift
//  CamiraTests
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit
import XCTest
import Camira

class CamiraTests: XCTestCase, GameDelegate {
    
    var sut: Game?
    
    override func setUp() {
        super.setUp()

        sut = Game(title: "Camira", subtitle: "A sample game", initialPlace: Place.start(), player: Player.main(), gameDelegate: self)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testWalkthrough() {
        sut?.debug(5)
    }
}

extension Action {
    static func hallwayToDiningRoom() -> Action {
        return Action(text: "Go to dining room", nextPlace: Place.diningRoom())
    }
    
    static func escapeThroughWindow() -> Action {
        return Action(text: "Escape through window", nextPlace: Place.outside())
    }
    
    static func goToBathroom() -> Action {
        return Action(text: "Go to bathroom", nextPlace: Place.bathroom())
    }
}

extension Place {
    static func start() -> Place {
        return Place(text: "You're standing in a giant hallway.", actions: [Action.hallwayToDiningRoom()], npcs: nil, nextPlace: nil)
    }
    
    static func diningRoom() -> Place {
        return Place(text: "Oh, a dining room.", actions: [Action.goToBathroom()], npcs: nil, nextPlace: nil)
    }
    
    static func bathroom() -> Place {
        return Place(text: "Smelly old bathroom", actions: [Action.escapeThroughWindow()], npcs: nil, nextPlace: nil)
    }
    
    static func outside() -> Place {
        return Place(text: "You're outside, it's over now!", actions: nil, npcs: nil, nextPlace: Place.gameOver())
    }
    
    static func gameOver() -> Place {
        let p = Place(text: "Really, over!", actions: nil, npcs: nil, nextPlace: nil)
        p.delay = 2
        return p
    }
}

extension Player {
    static func main() -> Player {
        return Player(name: "Marcus")
    }
}