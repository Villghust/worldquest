//
//  Debuff.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 18/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

enum Debuff {
    case stun (duration: Int)
    case blind (duration: Int)
    case taunted (at: InitiativeMember, duration: Int)
    case poison (dmgFlat: Int, duration: Int)
}
