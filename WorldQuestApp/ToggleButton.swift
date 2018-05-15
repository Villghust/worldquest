//
//  UICheckbox.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 15/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {
    
    let unselectedColor: UIColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
    let selectedColor: UIColor = UIColor(red: 21/255, green: 126/255, blue: 251/255, alpha: 1.0)
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setTitleColor(selectedColor, for: .normal)
            } else {
                self.setTitleColor(unselectedColor, for: .normal)
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
