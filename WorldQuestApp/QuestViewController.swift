//
//  GroupViewController.swift
//  
//
//  Created by Guilherme Piccoli on 21/05/2018.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class QuestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference!
    var questsTotais: [Quest] = [Quest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        questsTotais.removeAll()
        
        ref = Database.database().reference()
        
        self.ref.child("usuarios").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: {snapshot in
            let value = snapshot.value as? NSDictionary
            guard let quests = value?["quests"] as? [String] else {return}
            
            for nome in quests {
                self.ref.child("quests").child(nome).observeSingleEvent(of: .value, with: {snap in
                    let value = snap.value as? NSDictionary
                    let q = Quest()
                    q.id = nome
                    q.subtitulo = value?["subtitulo"] as! String
                    self.questsTotais.append(q)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Quests", image: UIImage(named: "_TAB_QUEST"), tag: 2)
    }
   
    //MARK: - DataSource
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questsTotais.count
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quests", for: indexPath) as! QuestCell
        cell.quest = questsTotais[indexPath.row]
        
        return cell
    }
    
}
