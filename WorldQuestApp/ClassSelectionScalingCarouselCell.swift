//
//  CharacterSelectionScalingCarouselCell.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 15/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class ClassSelectionScalingCarouselCell: ScalingCarouselCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var characterClass: CharacterClass = GameData.classWarrior {
        didSet {
            self.nameLabel.text = characterClass.name
            self.imageView.image = UIImage(named: characterClass.imagePath)
            self.descriptionLabel.text = characterClass.description
        }
    }
    
//    init(characterClass: CharacterClass) {
//        self.characterClass = characterClass
//    } 

}
