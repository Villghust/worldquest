//
//  CharacterCreationViewController.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 14/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CharacterCreationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference!
    
    var character = PlayerCharacter(attrPoints: GameData.initialAttrPoints, player: nil, characterClass: GameData.classWarrior)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        ref = Database.database().reference()
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

    @IBAction func criarPersonagem(_ sender: UIButton) {
    
        if character.name == nil {
            character.name = "Não definido"
        }
        
        let personagem = [
            "nome": character.name,
            "classe": character.characterClass.name,
            "forca": character.str,
            "agilidade": character.agi,
            "inteligencia": character.int,
            "vitalidade": character.vit
            ] as [String : Any]
        
        if Auth.auth().currentUser != nil {
            self.ref.child("usuarios/\(Auth.auth().currentUser!.uid)/personagem")
                .setValue(personagem)

            self.performSegue(
                withIdentifier: "CharacterCreationToGame",
                sender: nil)
        } else {
            // Usuário não logado (????)
        }
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
