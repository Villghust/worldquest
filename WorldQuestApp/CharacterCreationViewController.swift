//
//  CharacterCreationViewController.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 14/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CharacterCreationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var character = PlayerCharacter(attrPoints: GameData.initialAttrPoints, player: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // Mark: - Class Handling
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch(indexPath.row) {
        case 0:
            cell = self.tableView.dequeueReusableCell(withIdentifier: "CharacterCreationCell", for: indexPath) as! CharacterCreationTableViewCell
            break
        default:
            cell = self.tableView.dequeueReusableCell(withIdentifier: "CreateButtonCell", for: indexPath)
            break
//        default:
//            break
        }

        return cell
    }
}
