//
//  Datasource.swift
//  Camira
//
//  Created by Marcus Kida on 16/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Foundation

public class Datasource: NSObject {
    
    let game: Game
    
    public init(game: Game) {
        self.game = game
    }
    
    public func rows() -> [Scene] {
        return game.steps()
    }
    
    public func row(indexPath: IndexPath) -> Scene {
        return rows()[indexPath.row]
    }
    
    public func numberOfRows() -> Int {
        return rows().count
    }
    
    public func isActionRow(indexPath: IndexPath) -> Bool {
        guard (numberOfRows() - 1) >= indexPath.row else {
            return false
        }
        
        guard let _ = rows()[indexPath.row].actions else {
            return false
        }
        
        return true
    }
    
    public func actions(indexPath: IndexPath) -> [Action]? {
        guard let actions = row(indexPath: indexPath).actions  else {
            return nil
        }
        return actions
    }
    
    public func isActiveRow(indexPath: IndexPath) -> Bool {
        if (numberOfRows() - 1) == indexPath.row {
            return true
        }
        return false
    }
}
