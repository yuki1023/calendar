//
//  Checkbox.swift
//  ScheduleApp
//
//  Created by 篠原万由子 on 2020/09/28.
//  Copyright © 2020 net_shinohara. All rights reserved.
//

import UIKit
import NCMB

class Checkbox: UIButton {

 let checkedImage = UIImage(named: "icons8-checkmark.png")! as UIImage
   let uncheckedImage = UIImage(named: "icons8-checkbox.png")! as UIImage
   // Bool property
   var isChecked: Bool = false {
     didSet{
       if isChecked == true {
         self.setImage(checkedImage, for: UIControl.State.normal)
        
        
        
       } else {
         self.setImage(uncheckedImage, for: UIControl.State.normal)
       }
     }
   }
   override func awakeFromNib() {
     self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
   self.isChecked = false
 }
   @objc func buttonClicked(sender: UIButton) {
     if sender == self {
       isChecked = !isChecked
     }
    }

    
    
}
