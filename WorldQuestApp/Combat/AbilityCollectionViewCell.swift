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
    @IBOutlet weak var useButton: UIButton!
    
    var ability: Ability = GameData.goblinDagger {
        didSet {
            self.nameLabel.text = ability.name
            self.imageView.image = UIImage(named: ability.imagePath)
        }
    }
    
    
    @IBAction func useAbility_Touch(_ sender: UIButton) {
        if let vc = viewController as? CombatViewController {
            print ("Player:  \(vc.playerCharacter)")
            
            vc.selectedAbility = ability
            print ("Ability: \(vc.selectedAbility)")
            
            if let currentEnemyCell = vc.enemyCollectionView.currentCenterCell as? EnemyCollectionViewCell {
                vc.selectedEnemy = currentEnemyCell.enemy
            }
            print ("Target: \(vc.selectedEnemy)")
            
            if ability.targets == .singleEnemy {
                InitiativeSystem.singleton.playerActed(character: vc.playerCharacter, ability: vc.selectedAbility!, targets: [vc.selectedEnemy!])
            } else if ability.targets == .allEnemies {
                InitiativeSystem.singleton.playerActed(character: vc.playerCharacter, ability: vc.selectedAbility!, targets: InitiativeSystem.singleton.getOpposingSide(side: vc.playerCharacter.side!))
            } else if ability.targets == .allAllies {
                InitiativeSystem.singleton.playerActed(character: vc.playerCharacter, ability: vc.selectedAbility!, targets: InitiativeSystem.singleton.getSide(side: vc.playerCharacter.side!))
            } else {
                print ("ability target mode not implemented for player yet")
            }
        }
    }
    
}
