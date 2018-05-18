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
    var cooldown: Int
    
    // MARK: - Effects
    var targets: [User]
    var debuffs: [Debuff]
    
}

