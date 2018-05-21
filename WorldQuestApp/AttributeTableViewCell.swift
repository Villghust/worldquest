//
//  AttributeTableViewCell.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 17/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class AttributeTableViewCell: UITableViewCell {

    @IBOutlet weak var identifierLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var toggleButton: ToggleButton!
    
    private var value: Int = 1 {
        didSet {
            valueLabel.text? = String(value)
            updateCharacterData()
        }
    }
    
    var attribute: (String, Int) = ("Attribute", 1) {
        didSet {
            identifierLabel.text = attribute.0
            value = attribute.1
        }
    }
    
    
    private func updateCharacterData() {
        if let vc = self.viewController as? CharacterCreationViewController {
            switch(attribute.0) {
            case "Strength":
                vc.character.str = value
                print("Força \(vc.character.str)")
            case "Agility":
                vc.character.agi = value
                print("Agility \(vc.character.agi)")
            case "Intelligence":
                vc.character.int = value
                print("Intelligence \(vc.character.int)")
            case "Vitality":
                vc.character.vit = value
                print("Vitality \(vc.character.vit)")
            default:
                break
            }
        }
    }
    
    @IBAction func levelupAttribute_Touch(_ sender: ToggleButton) {
        let vc = self.viewController as? CharacterCreationViewController
        
        if sender.isChecked {
            value -= 1
            vc?.character.attrPoints += 1
        } else {
            value += 1
            vc?.character.attrPoints -= 1
            if((vc?.character.attrPoints)! < 0) {
                value -= 1
                vc?.character.attrPoints += 1
                sender.buttonClicked(sender: sender)
            }
        }
        print("Remaining Points: \(vc?.character.attrPoints ?? -1) ")
    }
    
}
