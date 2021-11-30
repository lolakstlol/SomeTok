//
//  CategoryCollectionViewCell.swift
//  LikeTok
//
//  Created by Artem Holod on 28.11.21.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension CategoryCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    
}


extension CategoryCollectionViewCell: UICollectionViewDelegate {
    
}
