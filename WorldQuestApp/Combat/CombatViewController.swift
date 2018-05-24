//
//  CombatViewController.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 21/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CombatViewController: UIViewController, UICollectionViewDelegate, UIScrollViewDelegate {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var enemyCollectionView: ScalingCarouselView!
    @IBOutlet weak var abilityCollectionView: ScalingCarouselView!
    @IBOutlet weak var playerCharacterNameLabel: UILabel!
    @IBOutlet weak var playerCharacterHealthLabel: UILabel!
    
    var playerCharacter: PlayerCharacter! = GameData.debugWarriorChar // no prepare tem que setar
    var allies: [InitiativeMember]! = [InitiativeMember]()
    var enemies: [InitiativeMember]! = [InitiativeMember]() // no prepare tem que setar
    
    var selectedAbility: Ability?
    var selectedEnemy: InitiativeMember?
    
    lazy var enemyDatasource = EnemyCollectionViewDatasource(enemies: enemies)
    lazy var abilityDatasource = AbilityCollectionViewDatasource(playerCharacter: playerCharacter)
    
    let goblin1 = Enemy(stats: GameData.goblinData, initiative: Int.randomBetween(min: 4, max: 12), maxHealth: 10)
    let goblin2 = Enemy(stats: GameData.goblinData, initiative: Int.randomBetween(min: 4, max: 12), maxHealth: 10)
    let goblin3 = Enemy(stats: GameData.goblinData, initiative: Int.randomBetween(min: 4, max: 12), maxHealth: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        let usuarioId = Auth.auth().currentUser?.uid
        startCombat(uid: usuarioId!)
    }
    
    func startCombat(uid: String) {
        ref.child("usuarios").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let personagem = value?["personagem"] as? NSObject
            
            // Se existe personagem, vai para a criação, senão vai para o mapa
            if personagem == nil {
                //self.goToMap()
            } else {
                let pc = PlayerCharacter(name: personagem!.value(forKey: "nome") as! String, str: personagem!.value(forKey: "forca") as! Int, agi: personagem!.value(forKey: "agilidade") as! Int, int: personagem!.value(forKey: "inteligencia") as! Int, vit: personagem!.value(forKey: "vitalidade") as! Int, attrPoints: 0, characterClass: GameData.classes[personagem!.value(forKey: "classe") as! String]!, player: nil)
                self.playerCharacter = pc
                self.allies.append(self.playerCharacter) // temporario
                self.enemies = [self.goblin1, self.goblin2, self.goblin3] // temporario
                
                self.playerCharacterNameLabel.text = self.playerCharacter.name

                
                self.enemyCollectionView.delegate = self
                self.abilityCollectionView.delegate = self
                
                self.abilityDatasource = AbilityCollectionViewDatasource(playerCharacter: self.playerCharacter)
                self.enemyDatasource = EnemyCollectionViewDatasource(enemies: self.enemies)
                self.enemyCollectionView.dataSource = self.enemyDatasource
                self.abilityCollectionView.dataSource = self.abilityDatasource
                
                InitiativeSystem.singleton.startCombat(sideA: self.allies, sideB: self.enemies, viewController: self)
                InitiativeSystem.singleton.reloadCharacterHealth()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func goToMap() {
        self.performSegue(
            withIdentifier: "CombatToMap",
            sender: nil)
        print ("Going to map")
    }
    
    // MARK: - Scroll View delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let invisibleScrollView = scrollView as? ScalingCarouselView {
            invisibleScrollView.didScroll()
            if invisibleScrollView == abilityCollectionView {
                if let selectedAbilityCell =  abilityCollectionView.currentCenterCell as? AbilityCollectionViewCell {
                    selectedAbility = selectedAbilityCell.ability
                    print ("Selected Ability: \(String(describing: selectedAbility))")
                }
            } else {
                if let selectedEnemyCell = enemyCollectionView.currentCenterCell as? EnemyCollectionViewCell {
                    selectedEnemy = selectedEnemyCell.enemy
                    print ("Selected Enemy: \(String(describing: selectedEnemy))")
                }
            }
        }
    }
}

/*
 var goblin1 = Enemy(stats: GameData.goblinData, initiative: Int.randomBetween(min: 1, max: 3), maxHealth: 10)
 var goblin2 = Enemy(stats: GameData.goblinData, initiative: Int.randomBetween(min: 2, max: 4), maxHealth: 10)
 
 InitiativeSystem.singleton.startCombat(sideA: [goblin1, goblin2], sideB: [])
 */
