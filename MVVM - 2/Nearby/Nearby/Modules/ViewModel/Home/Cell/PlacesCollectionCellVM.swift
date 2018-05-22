//
//  PlacesCollectionCellVM.swift
//  Nearby
//
//  Created by Abhisek on 14/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

protocol TableCollectionCellVMRepresentable {
    // Output
    var numberOfItems: Int { get }
    func viewModelForCell(indexPath: IndexPath) -> ImageAndLabelCollectionCellVM
    
    //Input
    func cellPressed(indexPath: IndexPath)
    
    // Event
    var cellTapped: (IndexPath)->() { get }
 }

class PlacesCollectionCellVM: TableCollectionCellVMRepresentable {
    
    var numberOfItems: Int = 0
    var cellTapped: (IndexPath)->() = { _ in }
    private var dataModel: [Place]!
    private var dataSource: [ImageAndLabelCollectionCellVM] = [ImageAndLabelCollectionCellVM]()
    
    init(dataModel: [Place]) {
        self.dataModel = dataModel
        configureOutput()
    }
    
    private func configureOutput() {
        numberOfItems = dataSource.count
    }
    
    private func prepareCollectionDataSource() {
        // We took 3 iterations as our requirement is to have top 3 places.
        for i in 0..<3 {
            let place = dataModel[i]
            let imageAndLabelDm = ImageAndLabelCollectionCellDataModel(name: place.name ?? "", imageUrl: place.imageURL ?? "")
            dataSource.append(ImageAndLabelCollectionCellVM(dataModel: imageAndLabelDm))
        }
    }
    
    func viewModelForCell(indexPath: IndexPath) -> ImageAndLabelCollectionCellVM {
        return dataSource[indexPath.row]
    }
    
    func cellPressed(indexPath: IndexPath) {
        cellTapped(indexPath)
    }
    
}
