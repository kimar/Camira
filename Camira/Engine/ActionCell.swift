//
//  ActionCell.swift
//  Camira
//
//  Created by Marcus Kida on 20/05/2015.
//  Copyright (c) 2015 Marcus Kida. All rights reserved.
//

import UIKit

public class ActionCell: UITableViewCell {
    
    @IBOutlet weak var leftActionButton: UIButton!
    @IBOutlet weak var rightActionButton: UIButton!
    
    weak var place: Place!
    var reload: (() -> ())?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func leftButtonAction (sender: AnyObject!) {
        if let actions = place.actions {
            if let action = actions.first {
                action.selected = true
                place.selectedAction = .Left
            }
        }
        if let rSelector = reload {
            rSelector()
        }
    }
    
    @IBAction func rightButtonAction (sender: AnyObject!) {
        if let actions = place.actions {
            if let action = actions.last {
                action.selected = true
                place.selectedAction = .Right
            }
        }
        if let rSelector = reload {
            rSelector()
        }
    }

}
