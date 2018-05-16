//
//  CharacterSelectionTableViewCell.swift
//  WorldQuestApp
//
//  Created by Leonardo Marcelino Vieira  on 15/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit

class CharacterSelectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var classCollection: ScalingCarouselView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.classCollection.delegate = self
        self.classCollection.dataSource = self
    }

    // MARK: - Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let invisibleScrollView = scrollView as? ScalingCarouselView {
            invisibleScrollView.didScroll()
        }
    }
    
    // MARK: - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        
        switch (indexPath.row) {
        case 0 :
            cell = self.classCollection.dequeueReusableCell(withReuseIdentifier: "WarriorCell", for: indexPath) as! CharacterSelectionScalingCarouselCell
            break
        case 1 :
            cell = self.classCollection.dequeueReusableCell(withReuseIdentifier: "WarriorCell", for: indexPath) as! CharacterSelectionScalingCarouselCell
            break
        default :
            cell = self.classCollection.dequeueReusableCell(withReuseIdentifier: "WarriorCell", for: indexPath) as! CharacterSelectionScalingCarouselCell
            break
        }
        
        return cell
    }
    
    // MARK: - Selection
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
