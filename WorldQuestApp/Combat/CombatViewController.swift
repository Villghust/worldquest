//
//  CombatViewController.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 21/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CombatViewController: UIViewController, UICollectionViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var enemyCollectionView: ScalingCarouselView!
    @IBOutlet weak var abilityCollectionView: ScalingCarouselView!
    @IBOutlet weak var playerCharacterNameLabel: UILabel!
    @IBOutlet weak var playerCharacterHealthLabel: UILabel!
    
    var playerCharacter: PlayerCharacter! = GameData.debugWarriorChar // no prepare tem que setar
    var allies: [InitiativeMember]! = [InitiativeMember]()
    var enemies: [InitiativeMember]! = [InitiativeMember]() // no prepare tem que setar
    
    var selectedAbility: Ability?
    var selectedEnemy: InitiativeMember?
    
    lazy var enemyDatasource = EnemyCollectionViewDatasource(enemies: enemies)
    lazy var abilityDatasource = AbilityCollectionViewDatasource(playerCharacter: playerCharacter)
    
    let goblin = Enemy(stats: GameData.goblinData, initiative: Int.randomBetween(min: 4, max: 12), maxHealth: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allies.append(playerCharacter) // temporario
        enemies.append(goblin) // temporario
        playerCharacterNameLabel.text = playerCharacter.name
        
        enemyCollectionView.delegate = self
        abilityCollectionView.delegate = self
        
        enemyCollectionView.dataSource = enemyDatasource
        abilityCollectionView.dataSource = abilityDatasource
        
        print ("Loading Combat")
        print ("Selected Ability: \(String(describing: selectedAbility))")
        print ("Selected Enemy: \(String(describing: selectedEnemy))")
        
        InitiativeSystem.singleton.startCombat(sideA: allies, sideB: enemies, viewController: self)
        InitiativeSystem.singleton.reloadCharacterHealth()
    }
    
    // MARK: - Scroll View delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let invisibleScrollView = scrollView as? ScalingCarouselView {
            invisibleScrollView.didScroll()
            if invisibleScrollView == abilityCollectionView {
                if let selectedAbilityCell =  abilityCollectionView.currentCenterCell as? AbilityCollectionViewCell {
                    selectedAbility = selectedAbilityCell.ability
                    print ("Selected Ability: \(String(describing: selectedAbility))")
                }
            } else {
                if let selectedEnemyCell = enemyCollectionView.currentCenterCell as? EnemyCollectionViewCell {
                    selectedEnemy = selectedEnemyCell.enemy
                    print ("Selected Enemy: \(String(describing: selectedEnemy))")
                }
            }
        }
    }
}

/*
 var goblin1 = Enemy(stats: GameData.goblinData, initiative: Int.randomBetween(min: 1, max: 3), maxHealth: 10)
 var goblin2 = Enemy(stats: GameData.goblinData, initiative: Int.randomBetween(min: 2, max: 4), maxHealth: 10)
 
 InitiativeSystem.singleton.startCombat(sideA: [goblin1, goblin2], sideB: [])
 */
