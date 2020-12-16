//
//  ScheduleTableViewCell.swift
//  ScheduleApp
//
//  Created by 篠原万由子 on 2020/09/16.
//  Copyright © 2020 net_shinohara. All rights reserved.
//

import UIKit

protocol ScheduleTableViewCellDelegate {
    func didTapcheckButton(tableViewCell: UITableViewCell, button: UIButton)
    
}

class ScheduleTableViewCell: UITableViewCell {
    
    var delegate: ScheduleTableViewCellDelegate?
       
   
    @IBOutlet var checkbutton: UIButton!

    @IBOutlet var scheduleNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   @IBAction func check(button: UIButton) {
     self.delegate?.didTapcheckButton(tableViewCell: self, button: button)
   
    }
    
   
    
}
