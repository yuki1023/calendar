//
//  TodoTableViewCell.swift
//  ScheduleApp
//
//  Created by 篠原万由子 on 2020/09/16.
//  Copyright © 2020 net_shinohara. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet var TodoNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
