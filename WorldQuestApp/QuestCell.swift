//
//  GroupCell.swift
//  WorldQuestApp
//
//  Created by Guilherme Piccoli on 22/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class QuestCell: UITableViewCell {
    
    var quest: Quest! {
        didSet {
            if self.quest.subtitulo == "quest" {
                self.titleLabel.text = "Mate 5 Inimigos"
                self.locationLabel.text = "Obtida em \(quest.id)"
                self.rewardLabel.text = "5 XP"
            } else {
                self.titleLabel.text = "Inimigos: 1 Goblin"
                self.locationLabel.text = "Obtida em \(quest.id)"
                self.rewardLabel.text = "2 XP e 1 Gold"
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
}
