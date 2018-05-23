//
//  Enemy.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 18/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class Enemy: InitiativeMember, EnemyAI, UseAbilities {

    var stats: EnemyData
    
    var initiative: Int
    var side: Side?
    
    var maxHealth: Int
    var health: Int
    
    var aggroedOn: PlayerCharacter?
    
    var canUseAbilities: Bool
    var debuffs: [Debuff]
    
    init (stats: EnemyData, initiative: Int, maxHealth: Int) {
        self.stats = stats
        self.side = nil
        self.initiative = initiative
        self.maxHealth = maxHealth
        self.health = maxHealth
        self.canUseAbilities = false
        self.debuffs = [Debuff]()
    }
    
    // Mark: - InitiativeMember Protocol
    
    func onStartOfEachTurn() {
        if isMyTurn() {
            self.canUseAbilities = true
            // reduce ability cooldowns
        }
    }
    
    func onEndOfEachTurn() {
        if isMyTurn() {
            
        }
    }
    
    func startTurn() {
        canUseAbilities = true
        InitiativeSystem.singleton.onStartOfEachTurn()
        act()
    }
    
    func endTurn() {
        canUseAbilities = false
    InitiativeSystem.singleton.onEndOfEachTurn()
    }
    
    func act() {
        if isMyTurn() {
            let ability = chooseAbility()
            if ability != nil {
                useAbility (ability: ability!)
                print ("\(stats.name) is using \(ability!.name)")
            } else {
                endTurn()
            }
        }
        self.canUseAbilities = false
    }
    
    func isMyTurn() -> Bool {
        return InitiativeSystem.singleton.isTurn(im: self as InitiativeMember)
    }
    
    func turnActivator() -> User? {
        return nil
    }
    
    func endCombat() {
        side = nil
        self.debuffs = [Debuff]()
    }
    
    // MARK: - Damageable Protocol
    func takeDamage(amount: Int, source: Ability, caster: InitiativeMember) {
        health -= amount
        print ("\(stats.name) was damaged for: \(amount) (Health was: \(health + amount) and is now: \(health)")
        if health <= 0 {
            print ("\(stats.name) is dead.")
        }
    }
    
    func healDamage(amount: Int, source: Ability, caster: InitiativeMember) {
        if isAlive() {
            health += amount
            print ("\(stats.name) was healed for: \(amount) (Health was: \(health - amount) and is now: \(health)")
        } else {
            print ("\(stats.name) was dead. (Must be ressed instead)")
        }
    }
    
    func isAlive() -> Bool {
        return health > 0
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
        InitiativeSystem.singleton.usedAbility(caster: self, ability: ability) 
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
