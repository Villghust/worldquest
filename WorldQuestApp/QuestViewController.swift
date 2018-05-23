//
//  GroupViewController.swift
//  
//
//  Created by Guilherme Piccoli on 21/05/2018.
//

import UIKit

class QuestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let sections = ["In progress", "Done"]
    let progress = ["quest1", "quest2"]
    let done = ["quest3", "quest4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    //MARK: - DataSource
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return progress.count
        } else {
            return done.count
        }
        
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "quests", for: indexPath)
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "completeQuests", for: indexPath)
        }
        
        return cell
    }
    
}
