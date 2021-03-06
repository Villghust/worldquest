//
//  CharacterClass.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 17/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

struct CharacterClass {
    var name: String
    var description: String
    var imagePath: String
    var str: Int
    var agi: Int
    var int: Int
    var vit: Int
    var abilities: [Ability]
}
