//
//  parseCell.swift
//  Parstagram
//
//  Created by Bonnie Nguyen on 6/23/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class parseCell: UITableViewCell {

    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var feedText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
