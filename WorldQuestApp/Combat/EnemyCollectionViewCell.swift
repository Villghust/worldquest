//
//  EnemyCollectionViewCell.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 23/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class EnemyCollectionViewCell: ScalingCarouselCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var healthLabel: UILabel!
    
    var enemy: InitiativeMember = GameData.debugGoblin {
        didSet {
            if let en = enemy as? Enemy {
                print (en)
                print (en.stats)
                print (en.stats.imagePath)
                self.imageView.image = UIImage(named: en.stats.imagePath)
                self.nameLabel.text = en.stats.name
            } else if let ec = enemy as? PlayerCharacter {
                print (ec)
                self.imageView.image = UIImage(named: ec.characterClass.imagePath)
                self.nameLabel.text = ec.name
            }
            self.healthLabel.text = "\(enemy.health)/\(enemy.maxHealth)"

        }
    }
}
