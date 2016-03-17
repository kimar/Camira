//
//  CamiraTests.swift
//  CamiraTests
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit
import XCTest
@testable import Camira

class CamiraTests: XCTestCase {
    
    var sut: Game!
    
    override func setUp() {
        super.setUp()
        sut = Game(title: "Camira", subtitle: "A sample game", initial: Scene.start(), player: Player.main())
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
}

extension Action {
    static func hallwayToDiningRoom() -> Action {
        return Action(text: "Go to dining room", nextScene: Scene.diningRoom())
    }
    
    static func escapeThroughWindow() -> Action {
        return Action(text: "Escape through window", nextScene: Scene.outside())
    }
    
    static func goToBathroom() -> Action {
        return Action(text: "Go to bathroom", nextScene: Scene.bathroom())
    }
}

extension Scene {
    static func start() -> Scene {
        return Scene(text: "You're standing in a giant hallway.", actions: [Action.hallwayToDiningRoom()], npcs: nil, nextScene: nil)
    }
    
    static func diningRoom() -> Scene {
        return Scene(text: "Oh, a dining room.", actions: [Action.goToBathroom()], npcs: nil, nextScene: nil)
    }
    
    static func bathroom() -> Scene {
        return Scene(text: "Smelly old bathroom", actions: [Action.escapeThroughWindow()], npcs: nil, nextScene: nil)
    }
    
    static func outside() -> Scene {
        return Scene(text: "You're outside, it's over now!", actions: nil, npcs: nil, nextScene: Scene.gameOver())
    }
    
    static func gameOver() -> Scene {
        return Scene(text: "Really, over!", actions: nil, npcs: nil, nextScene: nil)
    }
}

extension Player {
    static func main() -> Player {
        return Player(name: "Marcus")
    }
}