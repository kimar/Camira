//
//  Datasource.swift
//  Camira
//
//  Created by Marcus Kida on 16/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Foundation

public class Datasource {
    
    let game: Game
    
    public init(game: Game) {
        self.game = game
    }
    
    public func rows() -> [Scene] {
        return game.steps()
    }
    
    public func row(_ indexPath: IndexPath) -> Scene {
        return rows()[indexPath.row]
    }
    
    public func numberOfRows() -> Int {
        return rows().count
    }
    
    public func isActionRow(_ indexPath: IndexPath) -> Bool {
        guard (numberOfRows() - 1) >= indexPath.row else {
            return false
        }
        
        guard let _ = rows()[indexPath.row].actions else {
            return false
        }
        
        return true
    }
    
    public func actions(_ indexPath: IndexPath) -> [Action]? {
        guard let actions = row(indexPath).actions  else {
            return nil
        }
        return actions
    }
    
    public func isActiveRow(_ indexPath: IndexPath) -> Bool {
        if (numberOfRows() - 1) == indexPath.row {
            return true
        }
        return false
    }
}
