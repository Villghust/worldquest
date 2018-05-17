//
//  CharacterSelectionTableViewCell.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 15/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CharacterCreationClassSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var classCollection: ScalingCarouselView!
    lazy var classDatasource = CharacterCreationClassDatasource(characterClass: GameData.classWarrior)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.classCollection.delegate = classDatasource
        self.classCollection.dataSource = classDatasource
    }
}
