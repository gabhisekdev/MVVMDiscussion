//
//  PaginationCell.swift
//  Nearby
//
//  Created by Abhisek on 13/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit

class PaginationCell: ReusableTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pagingScrollView: UIScrollView!
    @IBOutlet weak var paginationIndicator: UIPageControl!
    
    private var viewModel: PaginationCellVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareCell(viewModel: PaginationCellVM) {
        self.viewModel = viewModel
        setUpUI()
    }
    
    private func setUpUI() {
        configureScrollView()
        configurePaginationIndicator()
        titleLabel.text = viewModel.title
    }
    
    private func configureScrollView() {
        pagingScrollView.isPagingEnabled = true
        pagingScrollView.isScrollEnabled = true
        pagingScrollView.contentSize = CGSize(width: pagingScrollView.frame.size.width * CGFloat(viewModel.numberOfPages), height: pagingScrollView.frame.size.height)

        for i in 0..<viewModel.numberOfPages {
            let placeView = PlaceView()
            placeView.frame = CGRect(x: CGFloat(i)*pagingScrollView.frame.width, y: 0, width: pagingScrollView.frame.width, height: pagingScrollView.frame.height)
            placeView.preparePlaceView(viewModel: viewModel.viewModelForPlaceView(position: i))
            pagingScrollView.addSubview(placeView)
        }
    }
    
    private func configurePaginationIndicator() {
        paginationIndicator.numberOfPages = viewModel.numberOfPages
    }
    
}

// MARK: UIScrollViewDelegate
extension PaginationCell: UIScrollViewDelegate {
    
}
