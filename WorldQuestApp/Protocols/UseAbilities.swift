//
//  UseAbilities.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 18/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

protocol UseAbilities {
    func availableAbilities() -> [Ability]
    func useAbility (ability: Ability)
}
