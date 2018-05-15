//
//  CharacterCreationAttributesTableViewCell.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 14/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CharacterCreationAttributesTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var atrTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.atrTableView.delegate = self
        self.atrTableView.dataSource = self
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch(indexPath.row) {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "StrCell", for: indexPath)
            break
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "AgiCell", for: indexPath)
            break
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "IntCell", for: indexPath)
            break
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "VitCell", for: indexPath)
            break
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "PointsCell", for: indexPath)
            break
        }
        
        return cell
    }

}
