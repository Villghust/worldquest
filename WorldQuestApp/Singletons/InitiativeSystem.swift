//
//  InitiativeSystem.swift
//  WorldQuestApp/Users/leonardo.vieira/Documents/worldquest/WorldQuestApp/Base.lproj/Main.storyboard
//
//  Created by Leonardo Marcelino Vieira  on 18/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

class InitiativeSystem {
    
    static let singleton = InitiativeSystem()
    
    var initiativeOrder = [InitiativeMember]()
    var actor: Int = 0
    var sideA = [InitiativeMember]() // usar tuplas e identificar tipo de jogador
    var sideB = [InitiativeMember]()
    var combatVC: CombatViewController?
    
    
    // Mark: - Initiative Sequence
    func startCombat (sideA: [InitiativeMember], sideB: [InitiativeMember], viewController: CombatViewController) {
        
        combatVC = viewController
        
        for var member in sideA {
            member.side = .A
            self.sideA.append(member)
            self.initiativeOrder.append(member)
        }
        
        for var member in sideB {
            member.side = .B
            self.sideB.append(member)
            self.initiativeOrder.append(member)
        }
        
        initiativeOrder.sort(by: compareInitiatives)
        
        initiativeOrder[0].startTurn()
    }
    
    func losingSide () -> [Side] {
        var defeated = [Side]()
        
        if !sideIsAlive(side: sideA) {
            defeated.append(Side.A)
        }
        
        if !sideIsAlive(side: sideB) {
            defeated.append(Side.B)
        }
        
        return defeated
    }
    
    func next() {
        actor += 1
        if actor >= initiativeOrder.count {
            actor = 0
        }
        print("New turn is starting (index: \(actor) is playing)")
        initiativeOrder[actor].startTurn()
    }
    
    func isTurn(im: InitiativeMember) -> Bool {
        if let pim = im as? PlayerCharacter {
            return pim === initiativeOrder[actor] as? PlayerCharacter
        } else if let eim = im as? Enemy {
            return eim === initiativeOrder[actor] as? Enemy
        }
        return false
    }
    
    func endCombat () {
        initiativeOrder.removeAll() // temp
        combatVC?.goToMap()
    }
    
    // Mark: - Comparators
    func compareInitiatives(this: InitiativeMember, that: InitiativeMember) -> Bool {
        return this.initiative > that.initiative
    }
    
    func sideIsAlive(side: [InitiativeMember]) -> Bool {
        var someoneIsAlive = false
        
        for i in side {
            if i.health >= 0 {
                someoneIsAlive = true
            }
        }
        
        return someoneIsAlive
    }
    
    // Mark: - Triggers
    func onStartOfEachTurn () {
        for elem in initiativeOrder {
            elem.onStartOfEachTurn()
        }
    }
    
    func onEndOfEachTurn () {
        for elem in initiativeOrder {
            elem.onEndOfEachTurn()
        }
        
        if(losingSide().count != 0) {
            if losingSide().count == 2 {
                print ("Both sides lost")
            } else if losingSide().count == 1 && losingSide()[0] == Side.A {
                print ("Side B Won")
            } else if losingSide().count == 1 && losingSide()[0] == Side.B {
                print ("Side A Won")
            }
            endCombat()
        } else {
            next()
        }
    }
    
    func playerActed(character: InitiativeMember, ability: Ability, targets: [InitiativeMember]) {
        (character as! UseAbilities).useAbility(ability: ability, targets: targets)
        character.endTurn()
    }
    
    func getOpposingSide(side: Side) -> [InitiativeMember] {
        if side == .A {
            return sideB
        } else {
            return sideA
        }
    }
    
    func getSide(side: Side) -> [InitiativeMember] {
        if side == .A {
            return sideA
        } else {
            return sideB
        }
    }
    
    func usedAbility (caster: InitiativeMember, ability: Ability, targets: [InitiativeMember]) {
        for target in targets {
            var dmg = ability.dmgFlat
            if let pc = caster as? PlayerCharacter {
                switch ability.dmgAttr {
                case .Strength:
                    dmg += Int(Float(pc.str) * ability.dmgScaling)
                case .Agility:
                    dmg += Int(Float(pc.agi) * ability.dmgScaling)
                case .Intelligence:
                    dmg += Int(Float(pc.int) * ability.dmgScaling)
                case .Vitality:
                    dmg += Int(Float(pc.vit) * ability.dmgScaling)
                case .Level:
                    dmg += 0/*Int(Float(pc.level) * dmgScaling)*/
                case .None:
                    dmg += 0
                }
            }
            
            target.takeDamage(amount: dmg, source: ability, caster: caster)
        }
        reloadEnemies()
        reloadCharacterHealth()
    }
    
    // Mark: - Redraw
    
    func reloadAbilities() {
        if combatVC != nil {
            combatVC?.abilityCollectionView.reloadData()
        } else {
            print ("not in combat to update ability collection view")
        }
    }
    
    func reloadEnemies() {
        if combatVC != nil {
            combatVC?.enemyCollectionView.reloadData()
        } else {
            print ("not in combat to update enemy collection view")
        }
    }
    
    func reloadCharacterHealth() {
        if let hp = combatVC?.playerCharacter.health {
            if let maxhp = combatVC?.playerCharacter.maxHealth {
                combatVC?.playerCharacterHealthLabel.text = "\(hp)/\(maxhp)"
            }
        }
    }
    
    
}


