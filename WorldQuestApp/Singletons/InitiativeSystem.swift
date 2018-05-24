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
    
    
    // Mark: - Initiative Sequence
    func startCombat (sideA: [InitiativeMember], sideB: [InitiativeMember]) {
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
        } else {
            next()
        }
    }
    
    func usedAbility (caster: InitiativeMember, ability: Ability/*, targets: [InitiativeMember]*/) {
        if caster.side == Side.A {
            for i in sideB {
                i.takeDamage(amount: Int.randomBetween(min: 1, max: 10), source: ability, caster: caster)
            }
        } else {
            for i in sideA {
                i.takeDamage(amount: Int.randomBetween(min: 1, max: 10), source: ability, caster: caster)
            }
        }
    }
}


