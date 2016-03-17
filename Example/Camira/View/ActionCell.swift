//
//  ActionCell.swift
//  Camira
//
//  Created by Marcus Kida on 16/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import UIKit
import Camira

class ActionCell: UITableViewCell {
    
    weak var scene: Scene?
    
    var reloadAction: (()-> Void)?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
        
    @IBAction func leftButtonAction(sender: UIButton) {
        guard let s = scene else {
            return
        }
        
        s.selectedAction = s.actions?.first
        if let a = reloadAction {
            a()
        }
    }
    
    @IBAction func rightButtonAction(sender: UIButton) {
        guard let s = scene else {
            return
        }
        s.selectedAction = s.actions?.last
        if let a = reloadAction {
            a()
        }
    }
}
