//
//  CharacterCreationNameTableViewCell.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 17/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CharacterCreationNameTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var characterNameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.characterNameTextField.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let vc = self.viewController as? CharacterCreationViewController {
            vc.character.name = textField.text
            print ("Name: \(vc.character.name)")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
