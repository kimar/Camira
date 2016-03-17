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
    
    weak var place: Place?
    
    var reloadAction: (()-> Void)?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
        
    @IBAction func leftButtonAction(sender: UIButton) {
        guard let p = place else {
            return
        }
        
        p.selectedAction = p.actions?.first
        if let a = reloadAction {
            a()
        }
    }
    
    @IBAction func rightButtonAction(sender: UIButton) {
        guard let p = place else {
            return
        }
        p.selectedAction = p.actions?.last
        if let a = reloadAction {
            a()
        }
    }
}
