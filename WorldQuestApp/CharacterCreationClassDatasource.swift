//
//  ClassDatasource.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 17/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CharacterCreationClassDatasource: NSObject, UICollectionViewDelegate,  UICollectionViewDataSource, UIScrollViewDelegate {
    
    var characterClass: CharacterClass!
    
    init(characterClass: CharacterClass) {
        self.characterClass = characterClass
    }
    
    // MARK: - Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let invisibleScrollView = scrollView as? ScalingCarouselView {
            invisibleScrollView.didScroll()
        }
    }
    
    // MARK: - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameData.allClasses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCell", for: indexPath) as! ClassSelectionScalingCarouselCell
        
        cell.characterClass = GameData.allClasses[indexPath.row]
        
        return cell
    }

}
