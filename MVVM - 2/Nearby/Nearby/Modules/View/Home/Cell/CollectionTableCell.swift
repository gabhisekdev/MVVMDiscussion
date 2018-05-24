//
//  CollectionTableCell.swift
//  Nearby
//
//  Created by Abhisek on 13/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit

class CollectionTableCell: ReusableTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: TableCollectionCellVMRepresentable!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    func prepareCell(viewModel: TableCollectionCellVMRepresentable) {
        self.viewModel = viewModel
        setUpUI()
    }
    
    private func prepareCollectionView() {
        ImageAndLabelCollectionCell.registerWithCollectionView(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setUpUI() {
        guard let viewModel = self.viewModel else { return }
        titleLabel.text = viewModel.title
    }
    
}

// MARK: UICollectionViewDelegate and UICollectionViewDatasource
extension CollectionTableCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageAndLabelCollectionCell", for: indexPath) as! ImageAndLabelCollectionCell
        cell.prepareCell(viewModel: viewModel.viewModelForCell(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.cellSelected(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 120)/CGFloat(viewModel.numberOfItems), height: collectionView.frame.size.height)
    }
    
}
