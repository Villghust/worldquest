//
//  CharacterCreationViewController.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 14/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CharacterCreationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    //uicollectionview carousel swift
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // Mark: - Class Handling
    
    func createClassInCoreData(/*classId: Int64, */className: String, baseStr: Int, baseAgi: Int, baseInt: Int, baseVit: Int, classAbilities: [Abilities])
    {
        let new = Class(context: AppDelegate.persistentContainer.viewContext)
//        new.class_id = Int64(classId)
        new.name = className
        new.baseStr = Int64(baseStr)
        new.baseAgi = Int64(baseAgi)
        new.baseInt = Int64(baseInt)
        new.baseVit = Int64(baseVit)
        for ability in classAbilities {
            ability.abilityClass = new
        }
        let abilitiesSet = NSSet(array: classAbilities)
        new.classAbilities = abilitiesSet
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch(indexPath.row) {
        case 0:
            cell = self.tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
            break
        case 1:
            cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassSelectionCell", for: indexPath)
            break
//        case 2:
//            cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassAbilitiesCell", for: indexPath)
//            break
        case 2:
            cell = self.tableView.dequeueReusableCell(withIdentifier: "AttributesCell", for: indexPath) as! CharacterCreationAttributesTableViewCell
            break
        default:
            cell = self.tableView.dequeueReusableCell(withIdentifier: "CreateButtonCell", for: indexPath)
            break
        }
        

        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
