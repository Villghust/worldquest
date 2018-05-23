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
    var name: String
    var descricao: String
    var imagePath: String
    var cooldown: Int
    
    // MARK: - Effects
    var targets: Target
    var debuffs: [Debuff]
    
    // Mark: - Damage
    var dmgAttr: Attribute = Attribute.None
    var dmgScaling: Float = 1.0
    var dmgFlat: Int = 0
    
}

