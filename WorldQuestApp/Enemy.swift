//
//  Enemy.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 18/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class Enemy: InitiativeMember, EnemyAI, UseAbilities {
    
    var canUseAbilities: Bool
    var aggroedOn: PlayerCharacter?
    var stats: EnemyData
    
    init (stats: EnemyData) {
        self.stats = stats
        canUseAbilities = false
    }
    
    // Mark: - InitiativeMember Protocol
    
    func onStartOfEachTurn() {
        if isMyTurn() {
            self.canUseAbilities = true
            let ability = chooseAbility()
            if ability != nil {
                useAbility (ability: ability!)
                print ("Using \(ability!.name)")
            } else {
                endTurn()
            }
        }
    }
    
    func onEndOfEachTurn() {
        
    }
    
    func endTurn() {
        canUseAbilities = false
    }
    
    func isMyTurn() -> Bool {
        return true // get from initiative singleton
    }
    
    func turnActivator() -> User? {
        return nil
    }
    
    // MARK: - UseAbilities Protocol
    
    func availableAbilities() -> [Ability] {
        var availableAbilities = [Ability]()
        
        for ability in stats.abilities {
            if(ability.cooldown <= 0) {
                availableAbilities.append(ability)
            }
        }
        return availableAbilities
    }
    
    func useAbility(ability: Ability) {
        endTurn();
    }
    
    // MARK: - EnemyAI Protocol
    func chooseAbility() -> Ability? {
        let available = availableAbilities()
        var chosen: Ability?
        
        if available.count > 0 {
            chosen = available[Int.randomBetween(min: 0, max: available.count - 1)]
        }
        
        return chosen
    }
}
