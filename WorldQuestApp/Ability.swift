//
//  Ability.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 17/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

struct Ability {
    // MARK: - Base
    var id: Int
    var name: String
    var descricao: String
    var cooldown: Int
    
    // MARK: - Damage
    var damage: Int
    var areaDamage: Bool
    var criticalMultiplier: Bool
    var poison: Bool
    var poisonDamage: Int
    var poisonDuration: Int
    var triggeredAttacks: Bool
    var triggeredAttackChance: Float
    var triggeredAttacksCanTriggerAttacks: Bool
    var multipleAttack: Int // if > 1 attack repeats.
    
    
    // MARK: - Debuffs
    var stun: Bool
    var damageDebuff: Float
    var taunt: Bool
    var missChance: Float
    
    // MARK: - Utility
    var counterAttacks: Bool
    var selfHeal: Int
    var healGroup: Int
    var raiseInt: Int
}
