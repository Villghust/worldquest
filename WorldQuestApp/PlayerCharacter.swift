//
//  PlayerCharacter.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 17/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

class PlayerCharacter {
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
    }
}
