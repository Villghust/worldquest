//
//  UICheckbox.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 15/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class Checkbox: UIButton {
    
    
    let checkedImage = UIImage(named: "_CHECKBOX_CHECKED")!
    let uncheckedImage = UIImage(named: "_CHECKBOX_UNCHECKED")!
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControlState.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
