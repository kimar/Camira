//
//  ViewController.swift
//  Camira
//
//  Created by Marcus Kida on 18/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, GameDelegate {
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let player = Player(name: "Gustbert")
        let surePlace = Place(text: "Sureplace! 😅", actions: nil, npcs: nil)
        let finalActions = [Action(text: "Sure!", nextPlace: surePlace), Action(text: "Probably not...", nextPlace: nil)]
        let actions = [Action(text: "Head right back", nextPlace: Place(text: "That's it, nothing to do for you, or is there?", actions: finalActions, npcs: nil))]
        let hall = Place(text: "You're standing inside a giant hall!", actions: actions, npcs: nil)
        game = Game(title: "Fuzzy Camira", subtitle: "An Adventure of low cunning!", initialPlace: hall, player: player, tableView: tableView, gameDelegate: self)
        
        game.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.numberOfRowsInSection(section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return game.cellForRowAtIndexPath(indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.reloadData()
    }

    func gameWillReloadData(game: Game) {
        tableView.reloadData()
    }
}

