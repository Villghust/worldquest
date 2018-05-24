//
//  InitiativeMember.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 18/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

protocol InitiativeMember: Damageable {
    
    // Mark: - Combat Stats
    var initiative: Int { get set }
    var side: Side? { get set }
    var canUseAbilities: Bool { get set }
    var debuffs: [Debuff] { get set }
    
    // Mark: - Combat Funcs
    func startTurn()
    func onStartOfEachTurn()
    func act()
    func endTurn()
    func onEndOfEachTurn()
    
    // Mark: - Checking
    func isMyTurn() -> Bool
    func turnActivator() -> User?
    
    // Mark: - Redirection
    func endCombat()
}
