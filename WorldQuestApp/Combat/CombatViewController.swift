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
    
    var playerCharacter: PlayerCharacter! = nil // no prepare tem que setar
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
        
        enemyCollectionView.dataSource = enemyDatasource
        abilityCollectionView.dataSource = abilityDatasource
    }
    
    // MARK: - Scroll View delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let invisibleScrollView = scrollView as? ScalingCarouselView {
            invisibleScrollView.didScroll()
            if let selectedAbilityCell = abilityCollectionView.currentCenterCell as? AbilityCollectionViewCell {
                
            }
        }
    }
}

/*
 var goblin1 = Enemy(stats: GameData.goblinData, initiative: Int.randomBetween(min: 1, max: 3), maxHealth: 10)
 var goblin2 = Enemy(stats: GameData.goblinData, initiative: Int.randomBetween(min: 2, max: 4), maxHealth: 10)
 
 InitiativeSystem.singleton.startCombat(sideA: [goblin1, goblin2], sideB: [])
 */
