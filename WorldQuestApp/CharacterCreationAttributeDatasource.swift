//
//  WarriorDatasource.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 17/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CharacterCreationAttributeDatasource: NSObject, UITableViewDataSource {
    
    var characterClass: CharacterClass!
    
    init(characterClass: CharacterClass) {
        self.characterClass = characterClass
    } //tableView.reloadData
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "AttrCell", for: indexPath) as! AttributeTableViewCell
        
        switch(indexPath.row) {
        case 0:
            cell.attribute = ("Strength", characterClass.str)
            break
        case 1:
            cell.attribute = ("Agility", characterClass.agi)
            break
        case 2:
            cell.attribute = ("Intelligence", characterClass.int)
            break
        default:
            cell.attribute = ("Vitality", characterClass.vit)
            break
        }
        
        return cell
    }

}
