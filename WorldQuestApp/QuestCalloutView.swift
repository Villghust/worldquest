//
//  QuestCalloutView.swift
//  WorldQuestApp
//
//  Created by Guilherme Piccoli on 21/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class QuestCalloutView: UIView {
    
    var delegate: MyProtocol?
    var quest: Quest?

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var questLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var rewarddescLabel: UILabel!
    var isWithinRadius: Bool = true
    
    @IBOutlet weak var btn: UIButton!
    
    @IBAction func btnAccept(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.sendData(quest: self.quest!)
        }
    }
    
}

protocol MyProtocol {
    func sendData(quest: Quest)
}
