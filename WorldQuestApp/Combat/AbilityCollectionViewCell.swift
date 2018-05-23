//
//  AbilityCollectionViewCell.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 23/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class AbilityCollectionViewCell: ScalingCarouselCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var ability: Ability = GameData.goblinDagger {
        didSet {
            self.nameLabel.text = ability.name
            self.imageView.image = UIImage(named: ability.imagePath)
        }
    }
    
}
