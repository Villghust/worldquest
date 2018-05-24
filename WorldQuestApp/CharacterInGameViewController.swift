//
//  CharacterInGameViewController.swift
//  WorldQuestApp
//
//  Created by Fernando Locatelli Maioli on 23/05/18.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CharacterInGameViewController: UIViewController {
    
    
    var ref: DatabaseReference!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var vitalityLabel: UILabel!
    @IBOutlet weak var agilityLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var distributionLabel: UILabel!
    var initialSTR: String!
    var initialVIT: String!
    var initialAGI: String!
    var initialINT: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.ref.child("usuarios").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let char = value?["personagem"] as? NSObject
            
            self.nameLabel.text = char?.value(forKey: "nome") as? String
            self.classLabel.text = char?.value(forKey: "classe") as? String
            self.initialSTR = char?.value(forKey: "forca") as! String
            self.strengthLabel.text = char?.value(forKey: "forca") as? String
            self.initialVIT = char?.value(forKey: "vitalidade") as! String
            self.vitalityLabel.text = char?.value(forKey: "vitalidade") as? String
            self.initialAGI = char?.value(forKey: "agilidade") as! String
            self.agilityLabel.text = char?.value(forKey: "agilidade") as? String
            self.initialINT = char?.value(forKey: "inteligencia") as! String
            self.intelligenceLabel.text = char?.value(forKey: "inteligencia") as? String
            self.distributionLabel.text = "5"
            self.loadImages()
        })
        
    }
   
    @IBAction func btnMinusAttribute(_ sender: UIButton) {
        
        if sender.tag == 0 {
            if Int(initialSTR)! < Int(strengthLabel.text!)! {
                strengthLabel.text = "\(Int(strengthLabel.text!)! -  1)"
                distributionLabel.text = "\(Int(distributionLabel.text!)! + 1)"
            }
        }
        else if sender.tag == 1 {
            if Int(initialVIT)! < Int(vitalityLabel.text!)! {
                vitalityLabel.text = "\(Int(vitalityLabel.text!)! -  1)"
                distributionLabel.text = "\(Int(distributionLabel.text!)! + 1)"
            }
        }
        else if sender.tag == 2 {
            if Int(initialAGI)! < Int(agilityLabel.text!)! {
                agilityLabel.text = "\(Int(agilityLabel.text!)! -  1)"
                distributionLabel.text = "\(Int(distributionLabel.text!)! + 1)"
            }
        }
        else if sender.tag == 3 {
            if Int(initialINT)! < Int(intelligenceLabel.text!)! {
                intelligenceLabel.text = "\(Int(intelligenceLabel.text!)! -  1)"
                distributionLabel.text = "\(Int(distributionLabel.text!)! + 1)"
            }
        }
    }
    
    @IBAction func btnPlusAttribute(_ sender: UIButton) {
        let contribution = Int(distributionLabel.text!)!
        if(contribution > 0){
            if sender.tag == 0 {
                strengthLabel.text = "\(Int(strengthLabel.text!)! +  1)"
                distributionLabel.text = "\(Int(distributionLabel.text!)! - 1)"
            }
            else if sender.tag == 1 {
                vitalityLabel.text = "\(Int(vitalityLabel.text!)! +  1)"
                distributionLabel.text = "\(Int(distributionLabel.text!)! - 1)"
            }
            else if sender.tag == 2 {
                agilityLabel.text = "\(Int(agilityLabel.text!)! +  1)"
                distributionLabel.text = "\(Int(distributionLabel.text!)! - 1)"
            }
            else if sender.tag == 3 {
                intelligenceLabel.text = "\(Int(intelligenceLabel.text!)! +  1)"
                distributionLabel.text = "\(Int(distributionLabel.text!)! - 1)"
            }
        }
    }
    
    @IBAction func saveAttributes(_ sender: UIButton) {
        initialSTR = strengthLabel.text!
        initialVIT = vitalityLabel.text!
        initialAGI = agilityLabel.text!
        initialINT = intelligenceLabel.text!
        
        let personagem = [
            "nome": nameLabel.text,
            "classe": classLabel.text,
            "forca": strengthLabel.text,
            "agilidade": agilityLabel.text,
            "inteligencia": intelligenceLabel.text,
            "vitalidade": vitalityLabel.text
        ] as [String : Any]
        self.ref.child("usuarios/\(Auth.auth().currentUser!.uid)/personagem")
            .setValue(personagem)
        
    }
    
    
    
    @IBOutlet weak var treeAskill1: UIImageView!
    @IBOutlet weak var treeAname1: UILabel!
    @IBOutlet weak var treeAskill2: UIImageView!
    @IBOutlet weak var treeAname2: UILabel!
    @IBOutlet weak var treeAskill3: UIImageView!
    @IBOutlet weak var treeBskill1: UIImageView!
    @IBOutlet weak var treeBskill2: UIImageView!
    @IBOutlet weak var treeBskill3: UIImageView!
    @IBOutlet weak var charIMG: UIImageView!
    @IBOutlet weak var treeAname3: UILabel!
    @IBOutlet weak var treeBname1: UILabel!
    @IBOutlet weak var treeBname2: UILabel!
    @IBOutlet weak var treeBname3: UILabel!

    
    func loadImages(){
        if(classLabel.text == "Warrior") {

            charIMG.image = UIImage(named: "_CHAR_WARRIOR")
            treeAskill1.image = UIImage(named: "_WS_SHIELDBASH")
            treeAskill2.image = UIImage(named: "_WS_KICK")
            treeAskill3.image = UIImage(named: "_WS_CLEAVE")
            treeBskill1.image = UIImage(named: "_WS_TAUNT")
            treeBskill2.image = UIImage(named: "_WS_COUNTER")
            treeBskill3.image = UIImage(named: "_WS_WARCRY")
            treeAname1.text = "Shieldbash"
            treeAname2.text = "Kick"
            treeAname3.text = "Cleave"
            treeBname1.text = "Taunt"
            treeBname2.text = "Counter"
            treeBname3.text = "Warcry"
        }
        else if(classLabel.text == "Mage") {
            charIMG.image = UIImage(named: "_CHAR_MAGE")
            treeAskill1.image = UIImage(named: "_MS_MAGICMISSILE")
            treeAskill2.image = UIImage(named: "_MS_FIREWAVE")
            treeAskill3.image = UIImage(named: "_MS_DRAINLIFE")
            treeBskill1.image = UIImage(named: "_MS_SLEEP")
            treeBskill2.image = UIImage(named: "_MS_HOLYLIGHT")
            treeBskill3.image = UIImage(named: "_MS_EMPOWER")
            treeAname1.text = "Magic Missile"
            treeAname2.text = "Firewave"
            treeAname3.text = "Drainlife"
            treeBname1.text = "Sleep"
            treeBname2.text = "Holylight"
            treeBname3.text = "Empower"
        }
        else if(classLabel.text == "Rogue") {
            charIMG.image = UIImage(named: "_CHAR_ROGUE")
            treeAskill1.image = UIImage(named: "_RS_BACKSTAB")
            treeAskill2.image = UIImage(named: "_RS_THROWDAGGERS")
            treeAskill3.image = UIImage(named: "_RS_CRITICALSTRIKE")
            treeBskill1.image = UIImage(named: "_RS_PASSIVECRITICALHIT")
            treeBskill2.image = UIImage(named: "_RS_POISONSTAB")
            treeBskill3.image = UIImage(named: "_RS_DOUBLESLASH")
            treeAname1.text = "Backstab"
            treeAname2.text = "Throw Daggers"
            treeAname3.text = "Critical Strike"
            treeBname1.text = "Critical Hit(passive)"
            treeBname2.text = "Poisonstab"
            treeBname3.text = "Multiple Slashes"
        }
    }
    
    
    
    
    
    
}
