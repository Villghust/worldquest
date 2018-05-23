//
//  AbilityCollectionViewDatasource.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 23/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

class AbilityCollectionViewDatasource: NSObject, UICollectionViewDataSource {
    
    var playerCharacter: PlayerCharacter!
    
    init(playerCharacter: PlayerCharacter) {
        super.init()
        self.playerCharacter = playerCharacter
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerCharacter.characterClass.abilities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AbilityCell", for: indexPath) as! AbilityCollectionViewCell
        
        return cell
    }
    
    // MARK: - Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let invisibleScrollView = scrollView as? ScalingCarouselView {
            invisibleScrollView.didScroll() //
            
//            if let vc = viewController as? CombatViewController {
//
//            }
        }
    }
}

