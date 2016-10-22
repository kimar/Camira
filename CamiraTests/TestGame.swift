//
//  TestGame.swift
//  Camira
//
//  Created by Marcus Kida on 22/10/16.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Foundation
import Camira

extension Action {
    static func hallwayToDiningRoom() -> Action {
        return Action(text: "Go to dining room", nextScene: Scene.diningRoom())
    }
    
    static func escapeThroughWindow() -> Action {
        return Action(text: "Escape through window", nextScene: Scene.outside())
    }
    
    static func backToDiningRoom() -> Action {
        return Action(text: "Head back to dining room", nextScene: Scene.diningRoomBack())
    }
    
    static func goToBathroom() -> Action {
        return Action(text: "Go to bathroom", nextScene: Scene.bathroom())
    }
}

extension Scene {
    static func start() -> Scene {
        return Scene(text: "You're standing in a giant hallway.", actions: [Action.hallwayToDiningRoom()], npcs: nil, nextScene: nil)
    }
    
    static func itsATrap() -> Scene {
        let p = Scene(text: "It's a trap...", actions: nil, npcs: nil, nextScene: Scene.damnTrapped())
        p.notBefore = Date(timeIntervalSinceNow: 10)
        return p
    }
    
    static func damnTrapped() -> Scene {
        let p = Scene(text: "Damn you're trapped..it's over 😌", actions: nil, npcs: nil, nextScene: nil)
        p.notBefore = Date(timeIntervalSinceNow: 13)
        return p
    }
    
    static func diningRoom() -> Scene {
        return Scene(text: "Oh, a dining room.", actions: [Action.goToBathroom()], npcs: nil, nextScene: nil)
    }
    
    static func diningRoomBack() -> Scene {
        return Scene(text: "Oh, a dining room. Again.", actions: nil, npcs: nil, nextScene: Scene.itsATrap())
    }
    
    static func bathroom() -> Scene {
        return Scene(text: "Smelly old bathroom", actions: [Action.escapeThroughWindow(), Action.backToDiningRoom()], npcs: nil, nextScene: nil)
    }
    
    static func outside() -> Scene {
        return Scene(text: "You're outside, it's over now!", actions: nil, npcs: nil, nextScene: Scene.gameOver())
    }
    
    static func gameOver() -> Scene {
        let p = Scene(text: "Really, over!", actions: nil, npcs: nil, nextScene: nil)
        p.notBefore = Date(timeIntervalSinceNow: 15)
        return p
    }
}

extension Player {
    static func main() -> Player {
        return Player(name: "Marcus")
    }
}
