//
//  parseCell.swift
//  Parstagram
//
//  Created by Bonnie Nguyen on 6/23/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class parseCell: UITableViewCell {


    @IBOutlet weak var feedImage: PFImageView!
    @IBOutlet weak var feedText: UILabel!
    @IBOutlet weak var feedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
