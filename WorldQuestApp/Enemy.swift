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
            if let ability = chooseAbility() {
                if let targets = chooseTarget(ability: ability) {
                    useAbility(ability: ability, targets: targets)
                    print ("\(stats.name) is using \(ability.name) at \(targets)")
                } else {
                    print ("\(stats.name) ended his turn without choosing a target, therefore not using an ability")
                    endTurn()
                }
            } else {
                print ("\(stats.name) ended his turn without using an ability")
                endTurn()
            }
        }
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
    
    func useAbility(ability: Ability, targets: [InitiativeMember]) {
        InitiativeSystem.singleton.usedAbility(caster: self, ability: ability, targets: targets)
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
    
    func chooseTarget(ability: Ability) -> [InitiativeMember]? {
        if ability.targets == .allEnemies {
            return InitiativeSystem.singleton.getOpposingSide(side: self.side!)
        } else if ability.targets == .allAllies {
            return InitiativeSystem.singleton.getSide(side: self.side!)
        } else if ability.targets == .singleEnemy {
            let os = InitiativeSystem.singleton.getOpposingSide(side: self.side!)
            let target = os[Int.randomBetween(min: 0, max: os.count - 1)]
            return [target]
        } else {
            print ("Choose target for mode is not implemented")
        }
        return nil
    }
}
