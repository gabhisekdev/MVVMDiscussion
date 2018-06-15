//
//  CategoriesTableCollectionCellViewModel.swift
//  Nearby
//
//  Created by Abhisek on 21/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

class CategoriesTableCollectionCellViewModel: TableCollectionCellViewModelRepresentable {
    
    // Output
    var title: String = ""
    var numberOfItems: Int = 0
    
    // Events
    var cellSelected: (IndexPath)->() = { _ in }
    
    private var dataSource: [ImageAndLabelCollectionCellViewModel] = [ImageAndLabelCollectionCellViewModel]()
    
    init() {
        prepareDataSource()
        configureOutput()
    }
    
    private func prepareDataSource() {
        for type in PlaceType.allPlaceType() {
            dataSource.append(ImageAndLabelCollectionCellViewModel(dataModel: ImageAndLabelCollectionCellModel(name: type.displayText(), imageUrl: type.iconUrl())))
        }
    }
    
    private func configureOutput() {
        title = "Want to be more specific"
        numberOfItems = dataSource.count
    }
    
    func viewModelForCell(indexPath: IndexPath) -> ImageAndLabelCollectionCellViewModel {
       return dataSource[indexPath.item]
    }
    
    func cellSelected(indexPath: IndexPath) {
        cellSelected(indexPath)
    }
    
}
