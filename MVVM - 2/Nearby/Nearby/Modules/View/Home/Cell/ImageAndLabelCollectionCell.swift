//
//  ImageAndLabelCollectionCell.swift
//  Nearby
//
//  Created by Abhisek on 20/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit

class ImageAndLabelCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    var viewModel: ImageAndLabelCollectionCellVM! {
        didSet {
            setUpUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setUpUI() {
        textLabel.text = viewModel.text
        imageView.kf.setImage(with: URL(string: viewModel.imageURL), placeholder: UIImage(named : "resturantPlaceHolder"), options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
        })
    }
    
}
