//
//  ActionCell.swift
//  Camira
//
//  Created by Marcus Kida on 16/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import UIKit

class ActionCell: UITableViewCell {
    
    weak var tableView: UITableView?
    weak var place: Place?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
        
    @IBAction func leftButtonAction(sender: UIButton) {
        guard let p = place else {
            return
        }
        
        p.selectedAction = p.actions?.first
        reload()
    }
    
    @IBAction func rightButtonAction(sender: UIButton) {
        guard let p = place else {
            return
        }
        p.selectedAction = p.actions?.last
        reload()
    }
    
    func reload() {
        tableView?.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
}
