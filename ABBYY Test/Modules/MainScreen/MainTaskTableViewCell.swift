//
//  MainTaskTableViewCell.swift
//  ABBYY Test
//
//  Created by Victor on 27/04/2019.
//  Copyright © 2019 com.example.LoD. All rights reserved.
//

import UIKit

class MainTaskTableViewCell: UITableViewCell {

    @IBOutlet var taskNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
