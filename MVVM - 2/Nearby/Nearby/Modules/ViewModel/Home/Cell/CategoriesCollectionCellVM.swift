//
//  CategoriesCollectionCellVM.swift
//  Nearby
//
//  Created by Abhisek on 21/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

class CategoriesCollectionCellVM: TableCollectionCellVMRepresentable {
    
    var numberOfItems: Int = 0
    var cellTapped: (IndexPath)->() = { _ in }
    private var dataSource: [ImageAndLabelCollectionCellVM] = [ImageAndLabelCollectionCellVM]()
    
    init() {
        prepareDataSource()
    }
    
    private func prepareDataSource() {
        for type in PlaceType.allPlaceType() {
            dataSource.append(ImageAndLabelCollectionCellVM(dataModel: ImageAndLabelCollectionCellDataModel(name: type.displayText(), imageUrl: type.iconUrl())))
        }
    }
    
    func viewModelForCell(indexPath: IndexPath) -> ImageAndLabelCollectionCellVM {
       return dataSource[indexPath.item]
    }
    
    func cellPressed(indexPath: IndexPath) {
        cellTapped(indexPath)
    }
    
}
