//
//  InitiativeMember.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 18/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

protocol InitiativeMember {
    func onStartOfEachTurn()
    func onEndOfEachTurn()
    func endTurn()
    func isMyTurn() -> Bool
    func turnActivator() -> User?
}
