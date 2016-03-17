//
//  ViewController.swift
//  Camira
//
//  Created by Marcus Kida on 03/17/2016.
//  Copyright (c) 2016 Marcus Kida. All rights reserved.
//

import UIKit
import Camira

class ViewController: UITableViewController {
    
    var game: Game!
    var datasource: Datasource!
    var timer: NSTimer!
    
    var lastNumRows = 0
    
    @IBAction func restart(sender: UIBarButtonItem) {
        resetGame()
        lastNumRows = 0
        tableView.reloadData()
    }
    
    func resetGame() {
        game = Game(title: "Camira - The Game", subtitle: "An sample adventure", initial: Scene.start(), player: Player.main())
        datasource = Datasource(game: game)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "tick", userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
    }
    
    func rowDelta() -> Int {
        return datasource.numberOfRows() - lastNumRows
    }
    
    func tick() {
        synchronized(self) { [weak self] in
            guard let s = self else { return }
            if s.rowDelta() > 0 {
                var indexPaths = [NSIndexPath]()
                for i in 0...s.rowDelta().predecessor() {
                    indexPaths.append(NSIndexPath(forRow: s.lastNumRows + i, inSection: 0))
                }
                s.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lastNumRows = datasource.numberOfRows()
        return lastNumRows
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if datasource.isActionRow(indexPath) {
            return 88
        }
        return 44
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let scene = datasource.row(indexPath)
        if datasource.isActionRow(indexPath) {
            let cell = tableView.dequeueReusableCellWithIdentifier("ActionCell") as! ActionCell
            cell.reloadAction = { [weak self] in
                self?.tick()
                self?.tableView.reloadRowsAtIndexPaths(
                    [NSIndexPath(forRow: indexPath.row, inSection: 0)],
                    withRowAnimation: .None)
            }
            cell.scene = scene
            cell.label.text = scene.text
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
        cell.scene = scene
        cell.label.text = scene.text
        return cell
    }
    
}

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
        p.notBefore = NSDate(timeIntervalSinceNow: 10)
        return p
    }
    
    static func damnTrapped() -> Scene {
        let p = Scene(text: "Damn you're trapped..it's over 😌", actions: nil, npcs: nil, nextScene: nil)
        p.notBefore = NSDate(timeIntervalSinceNow: 13)
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
        p.notBefore = NSDate(timeIntervalSinceNow: 15)
        return p
    }
}

extension Player {
    static func main() -> Player {
        return Player(name: "Marcus")
    }
}

