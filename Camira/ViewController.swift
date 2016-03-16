//
//  ViewController.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var game: Game!
    var datasource: Datasource!
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game(title: "Camira - The Game", subtitle: "An sample adventure", initialPlace: Place.start(), player: Player.main())
        datasource = Datasource(game: game)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "tick:", userInfo: nil, repeats: true)
    }
    
    func tick(timer: NSTimer) {
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.numberOfRows()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if datasource.isActionRow(indexPath) {
            return 88
        }
        return 44
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let place = datasource.row(indexPath)
        if datasource.isActionRow(indexPath) {
            let cell = tableView.dequeueReusableCellWithIdentifier("ActionCell") as! ActionCell
            cell.tableView = tableView
            cell.place = place
            cell.label.text = place.text
            cell.leftButton.hidden = true
            cell.rightButton.hidden = true
            guard let actions = datasource.actions(indexPath) else {
                return cell
            }
            cell.leftButton.hidden = false
            cell.leftButton.setTitle(actions.first?.text, forState: .Normal)
            if actions.count > 1 {
                cell.rightButton.hidden = false
                cell.rightButton.setTitle(actions[1].text, forState: .Normal)
            }
            cell.leftButton.enabled = datasource.isActiveRow(indexPath)
            cell.rightButton.enabled = datasource.isActiveRow(indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell") as! PlaceCell
        cell.place = place
        cell.label.text = place.text
        return cell
    }
    
}

extension Action {
    static func hallwayToDiningRoom() -> Action {
        return Action(text: "Go to dining room", nextPlace: Place.diningRoom())
    }
    
    static func escapeThroughWindow() -> Action {
        return Action(text: "Escape through window", nextPlace: Place.outside())
    }
    
    static func backToDiningRoom() -> Action {
        return Action(text: "Head back to dining room", nextPlace: Place.diningRoomBack())
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
    
    static func diningRoomBack() -> Place {
        return Place(text: "Oh, a dining room. Again.", actions: nil, npcs: nil, nextPlace: nil)
    }

    static func bathroom() -> Place {
        return Place(text: "Smelly old bathroom", actions: [Action.escapeThroughWindow(), Action.backToDiningRoom()], npcs: nil, nextPlace: nil)
    }

    static func outside() -> Place {
        return Place(text: "You're outside, it's over now!", actions: nil, npcs: nil, nextPlace: Place.gameOver())
    }

    static func gameOver() -> Place {
        let p = Place(text: "Really, over!", actions: nil, npcs: nil, nextPlace: nil)
        p.notBefore = NSDate(timeIntervalSinceNow: 15)
        return p
    }
}

extension Player {
    static func main() -> Player {
        return Player(name: "Marcus")
    }
}

