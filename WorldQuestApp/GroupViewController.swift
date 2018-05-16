//
//  GroupViewController.swift
//  WorldQuestApp
//
//  Created by Guilherme Piccoli on 15/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell = self.tableView.dequeueReusableCell(withIdentifier: "Party Leader", for: indexPath) //as! PartyLeaderCell
            break
            
        default:
            cell = self.tableView.dequeueReusableCell(withIdentifier: "Party Member", for: indexPath)
            break
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
