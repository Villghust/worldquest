//
//  Damageable.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 21/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

protocol Damageable {
    var maxHealth: Int { get set }
    var health: Int { get set }
    
    func takeDamage(amount: Int, source: Ability, caster: InitiativeMember)
    func healDamage(amount: Int, source: Ability, caster: InitiativeMember)
    func isAlive() -> Bool
}
