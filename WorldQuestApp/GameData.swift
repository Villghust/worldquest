//
//  GameData.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 17/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

class GameData {
    
    static let initialAttrPoints: Int = 2
    
    static let classWarrior: CharacterClass = CharacterClass(name: "Warrior", description: "A powerful and sturdy fighter.", imagePath: "_CHAR_WARRIOR", str: 6, agi: 6, int: 4, vit: 8, abilities: [Ability]())
    static let classRogue: CharacterClass = CharacterClass(name: "Rogue", description: "An agile and dexterous combatant.", imagePath: "_CHAR_ROGUE", str: 4, agi: 8, int: 6, vit: 6, abilities: [Ability]())
    static let classMage: CharacterClass = CharacterClass(name: "Mage", description: "An cunning and flexible spellcaster", imagePath: "_CHAR_MAGE", str: 4, agi: 6, int: 8, vit: 6, abilities: [Ability]())
    static let allClasses: [CharacterClass] = [GameData.classWarrior, GameData.classRogue, GameData.classMage]

}
