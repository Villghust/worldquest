//
//  CharacterCreationAttributesTableViewCell.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 14/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CharacterCreationAttributesTableViewCell: UITableViewCell {

    @IBOutlet weak var atrTableView: UITableView!
    lazy var attributeDatasource = CharacterCreationAttributeDatasource(characterClass: GameData.classWarrior)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.atrTableView.dataSource = attributeDatasource
    }
    
}

