//
//  CollectionTableCell.swift
//  Nearby
//
//  Created by Abhisek on 13/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit

class CollectionTableCell: ReusableTableViewCell {
    
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: TableCollectionCellVMRepresentable!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareCell(viewModel: TableCollectionCellVMRepresentable) {
        self.viewModel = viewModel
        setUpUI()
    }
    
    private func setUpUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

// MARK: UICollectionViewDelegate and UICollectionViewDatasource
extension CollectionTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageAndLabelCollectionCell", for: indexPath) as! ImageAndLabelCollectionCell
        cell.viewModel = viewModel.viewModelForCell(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.cellPressed(indexPath: indexPath)
    }
    
}
