//
//  CombatViewController.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 21/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CombatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print ("äaaaaa'")
        let goblinData = EnemyData(name: "Goblin 1", imagePath: "_ENEMY_GOBLIN", abilities: [GameData.abilities["Shield Bash"]!, GameData.abilities["Fire Wave"]!])
        
        let goblin2Data = EnemyData(name: "Goblin 2", imagePath: "_ENEMY_GOBLIN", abilities: [GameData.abilities["Shield Bash"]!, GameData.abilities["Fire Wave"]!])
        
        var goblin1 = Enemy(stats: goblinData, initiative: Int.randomBetween(min: 1, max: 3), maxHealth: 10)
        var goblin2 = Enemy(stats: goblinData, initiative: Int.randomBetween(min: 2, max: 4), maxHealth: 10)
        
        InitiativeSystem.singleton.startCombat(sideA: [goblin1], sideB: [goblin2])
    }
}
