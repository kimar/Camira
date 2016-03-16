//
//  Datasource.swift
//  Camira
//
//  Created by Marcus Kida on 16/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import UIKit

public class Datasource: NSObject {
    
    let game: Game
    
    public init(game: Game) {
        self.game = game
    }
    
    public func rows() -> [Place] {
        return game.steps()
    }
    
    public func numberOfRows() -> Int {
        return rows().count
    }
    
    public func isActionRow(indexPath: NSIndexPath) -> Bool? {
        guard numberOfRows().predecessor() >= indexPath.row else {
            return nil
        }
        
        guard let _ = rows()[indexPath.row].actions else {
            return false
        }
        
        return true
    }
}
