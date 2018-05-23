//
//  AbilityCollectionViewDatasource.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 23/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import Foundation

class EnemyCollectionViewDatasource: NSObject, UICollectionViewDataSource {
    
    var enemies: [InitiativeMember]!
    
    init(enemies: [InitiativeMember]) {
        super.init()
        self.enemies = enemies
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return enemies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EnemyCell", for: indexPath) as! EnemyCollectionViewCell
        cell.enemy = enemies[indexPath.row]
        return cell
    }
    
    // MARK: - Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let invisibleScrollView = scrollView as? ScalingCarouselView {
            invisibleScrollView.didScroll()
        }
    }
    
}
