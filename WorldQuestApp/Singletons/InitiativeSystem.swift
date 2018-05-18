//
//  InitiativeSystem.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 18/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

let singleton = InitiativeSystem()

class InitiativeSystem {
    
    var initiativeOrder = [InitiativeMember]()
    var sideA = [InitiativeMember]() // usar tuplas e identificar tipo de jogador
    var sideB = [InitiativeMember]()
    
    func startCombat (sideA: [InitiativeMember], sideB: [InitiativeMember]) {
        for i in sideA {
            self.sideA.append(i)
        }
        
        for i in sideB {
            self.sideB.append(i)
        }
    }
    
    func endCombat () {
        
    }
}


