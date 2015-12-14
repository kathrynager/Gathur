//
//  UserGathuringsTableViewCell.swift
//  Gathur
//
//  Created by Kathryn Ager on 12/9/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit

class UserGathuringsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gathuring: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
   }
