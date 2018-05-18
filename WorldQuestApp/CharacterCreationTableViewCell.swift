//
//  CharacterSelectionTableViewCell.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 15/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CharacterCreationTableViewCell: UITableViewCell, UICollectionViewDelegate, UIScrollViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var classCollection: ScalingCarouselView!
    @IBOutlet weak var atrTableView: UITableView!
    
    lazy var attributeDatasource = CharacterCreationAttributeDatasource(characterClass: GameData.classWarrior)
    lazy var classDatasource = CharacterCreationClassDatasource()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameLabel.delegate = self
        self.classCollection.delegate = self
        self.classCollection.dataSource = classDatasource
        self.atrTableView.dataSource = attributeDatasource
        self.nameLabel.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - TextField delegate
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let vc = viewController as? CharacterCreationViewController {
            vc.character.name = textField.text
            print (vc.character.name)
        }
    }
    
    // MARK: - Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let invisibleScrollView = scrollView as? ScalingCarouselView {
            invisibleScrollView.didScroll()
            
            if let currentSelectedClass = classCollection.currentCenterCell as? ClassSelectionScalingCarouselCell {
                if let vc = viewController as? CharacterCreationViewController {
                    attributeDatasource.characterClass = currentSelectedClass.characterClass
                    let cells = self.atrTableView.visibleCells
                    for cell in cells {
                        if let c = cell as? AttributeTableViewCell {
                            if c.toggleButton.isChecked {
                                c.toggleButton.buttonClicked(sender: c.toggleButton)
                            }
                        }
                    }
                    vc.character.attrPoints = GameData.initialAttrPoints
                    atrTableView.reloadData()
                    print ("Selected: \(currentSelectedClass.characterClass.name)");
                }
            }
        }
    }
}
    
    // MARK: - Collection view delegate

extension UIResponder {
    var viewController: UIViewController? {
        if let vc = self as? UIViewController {
            return vc
        }
        
        return next?.viewController
    }
}
