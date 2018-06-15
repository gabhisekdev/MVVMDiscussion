//
//  PlaceListViewModel.swift
//  Nearby
//
//  Created by Abhisek on 5/23/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

class PlaceListViewModel {
    
    // Output
    var numberOfRows = 0
    var title = ""
    
    private var placeType: PlaceType!
    private var dataSource = [PlaceTableCellViewModel]()
    
    // Event
    var placeSelected: (Place)->() = { _ in }
    
    init(placeType: PlaceType) {
        self.placeType = placeType
        prepareTableDataSource()
        configureOutput()
    }
    
    private func prepareTableDataSource() {
        dataSource = AppData.sharedData.allPlaces.filter { $0.type == placeType }.map {  return PlaceTableCellViewModel(place: $0) }
    }
    
    private func configureOutput() {
        title = placeType.displayText()
        numberOfRows = dataSource.count
    }
    
    func cellViewModel(indexPath: IndexPath)->PlaceTableCellViewModel {
        let cellViewModel = dataSource[indexPath.row]
        cellViewModel.placeSelected = placeSelected
        return cellViewModel
    }
    
}
