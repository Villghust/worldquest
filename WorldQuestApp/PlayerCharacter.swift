//
//  PlayerCharacter.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 17/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

class PlayerCharacter: UseAbilities, InitiativeMember {
    
    var name: String!
    var str: Int!
    var agi: Int!
    var int: Int!
    var vit: Int!
    var attrPoints: Int
    var characterClass: CharacterClass!
    var player: User?
    
    init(attrPoints: Int, player: User?, characterClass: CharacterClass) {
        self.attrPoints = attrPoints
        self.player = player
        self.characterClass = characterClass
        self.agi = characterClass.agi
        self.str = characterClass.str
        self.int = characterClass.int
        self.vit = characterClass.vit
        self.maxHealth = self.vit * 3
        self.health = maxHealth
        self.initiative = self.agi * 3
        self.canUseAbilities = false
        self.debuffs = [Debuff]()
    }
    
    // MARK: - Initiative Member Protocol
    
    var initiative: Int
    var side: Side?
    var canUseAbilities: Bool
    var debuffs: [Debuff]
    
    func startTurn() {
        canUseAbilities = true
        InitiativeSystem.singleton.onStartOfEachTurn()
        act()
    }
    
    func onStartOfEachTurn() {
        if isMyTurn() {
            self.canUseAbilities = true
            // reduce ability cooldowns
        }
    }
    
    func act() {
        print ("implement")
        endTurn()
    }
    
    func endTurn() {
        canUseAbilities = false
        InitiativeSystem.singleton.onEndOfEachTurn()
    }
    
    func onEndOfEachTurn() {
        if isMyTurn() {
            
        }
    }
    
    func isMyTurn() -> Bool {
        return InitiativeSystem.singleton.isTurn(im: self as InitiativeMember)
    }
    
    func turnActivator() -> User? {
        return player
    }
    
    func endCombat() {
        side = nil
        self.debuffs = [Debuff]()
    }
    
    // MARK: - Damageable Protocol
    var maxHealth: Int
    var health: Int
    
    func takeDamage(amount: Int, source: Ability, caster: InitiativeMember) {
        health -= amount
        print ("\(self.name) was damaged for: \(amount) (Health was: \(health + amount) and is now: \(health)")
        if health <= 0 {
            print ("\(self.name) is dead.")
        }
    }
    
    func healDamage(amount: Int, source: Ability, caster: InitiativeMember) {
        if isAlive() {
            health += amount
            print ("\(self.name) was healed for: \(amount) (Health was: \(health - amount) and is now: \(health)")
        } else {
            print ("\(self.name) was dead. (Must be ressed instead)")
        }
    }
    
    func isAlive() -> Bool {
        return health > 0
    }
    
    // MARK: - Uses Abilities Protocol
    
    func availableAbilities() -> [Ability] {
        var availableAbilities = [Ability]()
        
        for ability in self.characterClass.abilities {
            if(ability.cooldown <= 0) {
                availableAbilities.append(ability)
            }
        }
        return availableAbilities
    }
    
    func useAbility(ability: Ability) {
        print ("use ability")
        // implement
    }
    
}
