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
    
    // Mark: -  Character Abilities
    
    static let magicMissile: Ability = Ability(name: "Magic Missile", descricao: "The Mage waves his hand in the direction of the enemies and watch, as they are hurt by the flames.", imagePath: "_MS_MAGICMISSILE", cooldown: 0, targets: Target.singleEnemy, debuffs: [], dmgAttr: Attribute.Intelligence, dmgScaling: 1.0, dmgFlat: 4)
    
    static let fireWave: Ability = Ability(name: "Fire Wave", descricao: "The Mage waves his hand in the direction of the enemies and watch, as they are hurt by the flames.", imagePath: "_MS_FIREWAVE", cooldown: 0, targets: Target.allEnemies, debuffs: [], dmgAttr: Attribute.Intelligence, dmgScaling: 0.6, dmgFlat: 1)
    
    static let shieldBash: Ability = Ability(name: "Shield Bash", descricao: "The Warrior bashes the shield with great force at the enemy.", imagePath: "_WS_SHIELDBASH", cooldown: 0, targets: Target.singleEnemy, debuffs: [], dmgAttr: Attribute.Strength, dmgScaling: 2.0, dmgFlat: 1)
    
    static let cleave: Ability = Ability(name: "Cleave", descricao: "The Warrior whirls his weapon around himself hitting all enemies.", imagePath: "_WS_CLEAVE", cooldown: 0, targets: Target.allEnemies, debuffs: [], dmgAttr: Attribute.Strength, dmgScaling: 0.4, dmgFlat: 6)
    
    static let backstab: Ability = Ability(name: "Backstab", descricao: "The Rogue applies backstabs his enemy.", imagePath: "Pikes_2", cooldown: 0, targets: Target.singleEnemy, debuffs: [], dmgAttr: Attribute.Agility, dmgScaling: 3.0, dmgFlat: 0)
    
    static let poisonedDagger: Ability = Ability(name: "Poisoned Dagger", descricao: "The Rogue applies poison to the daggers blade and stabs the target.", imagePath: "_RS_POISONDAGGER", cooldown: 0, targets: Target.singleEnemy, debuffs: [Debuff.poison(dmgFlat: 1, duration: 3)], dmgAttr: Attribute.Agility, dmgScaling: 1.0, dmgFlat: 1)
    
    
    
    // Mark: - Enemy Abilities
    
    static let goblinDagger: Ability = Ability(name: "Dagger", descricao: "The goblin attacks with his tiny dagger.", imagePath: "_ES_GOBLIN", cooldown: 0, targets: Target.singleEnemy, debuffs: [], dmgAttr: Attribute.Level, dmgScaling: 1.0, dmgFlat: 2)
    
    
    // Mark: - Classes
    static let classWarrior: CharacterClass = CharacterClass(name: "Warrior", description: "A powerful and sturdy fighter.", imagePath: "_CHAR_WARRIOR", str: 6, agi: 6, int: 4, vit: 8, abilities: [GameData.shieldBash, GameData.cleave])
    static let classRogue: CharacterClass = CharacterClass(name: "Rogue", description: "An agile and dexterous combatant.", imagePath: "_CHAR_ROGUE", str: 4, agi: 8, int: 6, vit: 6, abilities: [GameData.backstab, GameData.poisonedDagger])
    static let classMage: CharacterClass = CharacterClass(name: "Mage", description: "An cunning and flexible spellcaster", imagePath: "_CHAR_MAGE", str: 4, agi: 6, int: 8, vit: 6, abilities: [GameData.magicMissile, GameData.fireWave])
    
    static let classes: [String: CharacterClass] = ["Warrior": GameData.classWarrior, "Rogue": GameData.classRogue, "Mage": GameData.classMage]
    static let allClasses: [CharacterClass] = [GameData.classWarrior, GameData.classRogue, GameData.classMage]
    
    
    // Mark: - Enemy Data
    static let goblinData = EnemyData(name: "Goblin", imagePath: "_ENEMY_GOBLIN", abilities: [GameData.goblinDagger])
    
    // Mark: - Debug Data
    static let debugWarriorChar = PlayerCharacter(characterClass: GameData.classWarrior, bonusStr: 1, bonusAgi: 0, bonusInt: 0, bonusVit: 1)
    static let debugRogueChar = PlayerCharacter(characterClass: GameData.classRogue, bonusStr: 0, bonusAgi: 2, bonusInt: 0, bonusVit: 0)
    static let debugMageChar = PlayerCharacter(characterClass: GameData.classMage, bonusStr: 0, bonusAgi: 0, bonusInt: 1, bonusVit: 1)
    static let debugGoblin = Enemy(stats: goblinData, initiative: Int.randomBetween(min: 3, max: 8), maxHealth: 10)
    
}
