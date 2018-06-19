//
//  CustomTableViewCell.swift
//  EzParseandCoreData
//
//  Created by MacMiniCorei5-26Ghz on 6/18/18.
//  Copyright © 2018 GVN. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var lostLabel: UILabel!
    @IBOutlet weak var drawnLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
