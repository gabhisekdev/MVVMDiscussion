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
    var title: String { get }
    var numberOfItems: Int { get }
    func viewModelForCell(indexPath: IndexPath) -> ImageAndLabelCollectionCellVM
    
    //Input
    func cellSelected(indexPath: IndexPath)
    
    // Event
    var cellSelected: (IndexPath)->() { get }
 }

struct PlacesCollectionCellModel {
    
    var places  = [Place]()
    var title = ""
    
}

class PlacesCollectionCellVM: TableCollectionCellVMRepresentable {
    
    var numberOfItems: Int = 0
    var title: String = ""
    var cellSelected: (IndexPath)->() = { _ in }
    private var dataModel: PlacesCollectionCellModel!
    private var dataSource: [ImageAndLabelCollectionCellVM] = [ImageAndLabelCollectionCellVM]()
    
    init(dataModel: PlacesCollectionCellModel) {
        self.dataModel = dataModel
        prepareCollectionDataSource()
        configureOutput()
    }
    
    private func configureOutput() {
        title = dataModel.title
        numberOfItems = dataSource.count
    }
    
    private func prepareCollectionDataSource() {
        if dataModel.places.count == 0 { return }
        let totalCount =  dataModel.places.count >= 3 ? 3 : dataModel.places.count
        for i in 0..<totalCount {
            let place = dataModel.places[i]
            let imageAndLabelDm = ImageAndLabelCollectionCellModel(name: place.name ?? "", imageUrl: place.imageURL ?? "")
            dataSource.append(ImageAndLabelCollectionCellVM(dataModel: imageAndLabelDm))
        }
    }
    
    func viewModelForCell(indexPath: IndexPath) -> ImageAndLabelCollectionCellVM {
        return dataSource[indexPath.row]
    }
    
    func cellSelected(indexPath: IndexPath) {
        cellSelected(indexPath)
    }
    
}
