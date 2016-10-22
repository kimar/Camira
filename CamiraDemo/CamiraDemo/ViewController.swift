//
//  ViewController.swift
//  CamiraDemo
//
//  Created by Marcus Kida on 22/10/16.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import UIKit
import Camira
import Gloss

class ViewController: UITableViewController {
    
    var game: Game!
    var datasource: Datasource!
    var timer: Timer!
    
    var lastNumRows = 0
    
    var stored: (JSON, Int)?
    
    @IBAction func restart(sender: UIBarButtonItem) {
        resetGame()
        lastNumRows = 0
        tableView.reloadData()
    }
    
    func resetGame() {
        game = Game(title: "Camira - The Game", subtitle: "An sample adventure", initial: Scene.start(), player: Player.main())
        datasource = Datasource(game: game)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.tick), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
    }
    
    func rowDelta() -> Int {
        return datasource.numberOfRows() - lastNumRows
    }
    
    func tick() {
        synchronized(object: self) { [weak self] in
            guard let s = self else { return }
            if s.rowDelta() > 0 {
                var indexPaths = [IndexPath]()
                for i in 0...(s.rowDelta() - 1) {
                    indexPaths.append(IndexPath(row: s.lastNumRows + i, section: 0))
                }
                s.tableView.insertRows(at: indexPaths, with: .automatic)
            }
        }
    }
    
    @IBAction func persistAndRestore() {
        if let storedGame = stored {
            guard let g = Game(json: storedGame.0) else { return assertionFailure() }
            game = g
            datasource = Datasource(game: game)
            lastNumRows = storedGame.1
            return tableView.reloadData()
        }
        stored = (game.toJSON()!, lastNumRows)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lastNumRows = datasource.numberOfRows()
        return lastNumRows
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datasource.isActionRow(indexPath) {
            return 88
        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let scene = datasource.row(indexPath)
        if datasource.isActionRow(indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell") as! ActionCell
            cell.reloadAction = { [weak self] in
                self?.tick()
                self?.tableView.reloadRows(
                    at: [IndexPath(row: indexPath.row, section: 0)],
                    with: .none)
            }
            cell.scene = scene
            cell.label.text = scene.text
            cell.leftButton.isHidden = true
            cell.rightButton.isHidden = true
            guard let actions = datasource.actions(indexPath) else {
                return cell
            }
            cell.leftButton.isHidden = false
            cell.leftButton.setTitle(actions.first?.text, for: .normal)
            if actions.count > 1 {
                cell.rightButton.isHidden = false
                cell.rightButton.setTitle(actions[1].text, for: .normal)
            }
            cell.leftButton.isEnabled = datasource.isActiveRow(indexPath)
            cell.rightButton.isEnabled = datasource.isActiveRow(indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as! PlaceCell
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

