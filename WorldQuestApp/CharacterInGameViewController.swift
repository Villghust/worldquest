//
//  CharacterInGameViewController.swift
//  WorldQuestApp
//
//  Created by Fernando Locatelli Maioli on 23/05/18.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CharacterInGameViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var vitalityLabel: UILabel!
    @IBOutlet weak var agilityLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var distributionLabel: UILabel!
    var initialSTR: Int!
    var initialVIT: Int!
    var initialAGI: Int!
    var initialINT: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSTR = 10
        strengthLabel.text = "10"
        initialVIT = 10
        vitalityLabel.text = "10"
        initialAGI = 10
        agilityLabel.text = "10"
        initialINT = 10
        intelligenceLabel.text = "10"
        distributionLabel.text = "5"
        
    }
    
    @IBAction func btnMinusAttribute(_ sender: UIButton) {
        
        if sender.tag == 0 {
            if initialSTR < Int(strengthLabel.text!)! {
                strengthLabel.text = "\(Int(strengthLabel.text!)! -  1)"
                distributionLabel.text = "\(Int(distributionLabel.text!)! + 1)"
            }
        }
        else if sender.tag == 1 {
            if initialVIT < Int(vitalityLabel.text!)! {
                vitalityLabel.text = "\(Int(vitalityLabel.text!)! -  1)"
                distributionLabel.text = "\(Int(distributionLabel.text!)! + 1)"
            }
        }
        else if sender.tag == 2 {
            if initialAGI < Int(agilityLabel.text!)! {
                agilityLabel.text = "\(Int(agilityLabel.text!)! -  1)"
                distributionLabel.text = "\(Int(distributionLabel.text!)! + 1)"
            }
        }
        else if sender.tag == 3 {
            if initialINT < Int(intelligenceLabel.text!)! {
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
        initialSTR = Int(strengthLabel.text!)!
        initialVIT = Int(vitalityLabel.text!)!
        initialAGI = Int(agilityLabel.text!)!
        initialINT = Int(intelligenceLabel.text!)!
        
        
    }
    
    
    
    
    
    
}
