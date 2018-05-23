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
        
        var goblin1 = Enemy(stats: GameData.goblinData, initiative: Int.randomBetween(min: 1, max: 3), maxHealth: 10)
        var goblin2 = Enemy(stats: GameData.goblinData, initiative: Int.randomBetween(min: 2, max: 4), maxHealth: 10)
        
        InitiativeSystem.singleton.startCombat(sideA: [goblin1, goblin2], sideB: [])
    }
}
