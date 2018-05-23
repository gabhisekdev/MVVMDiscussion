//
//  HomeViewModel.swift
//  Nearby
//
//  Created by Abhisek on 13/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

/// Enum to distinguish different home cell types
enum HomeTableCellType {
    case pagingCell(model: PaginationCellVM)
    case categoriesCell(model: TableCollectionCellVMRepresentable)
    case placesCell(model: TableCollectionCellVMRepresentable)
}

class HomeViewModel {
    
    private var tableDataSource: [HomeTableCellType] = [HomeTableCellType]()
    var viewDidLoad: ()->() = {}
    var placeSelected: (Place)->() = { _ in }
    var categorySelected: (PlaceType)->() = { _ in }
    var reloadTable: ()->() = { }
    var numberOfRows = 0
    
    init() {
        viewDidLoad = { [weak self] in
            self?.getAppData(completion: {
                self?.prepareTableDataSource()
                self?.reloadTable()
            })
        }
    }
    
    func refreshScreen() {
        tableDataSource.removeAll()
        self.getAppData(completion: { [weak self] in
            self?.prepareTableDataSource()
            self?.reloadTable()
        })
    }
    
    private func getAppData(completion: @escaping ()->()) {
        //Show the loader
        let allPlaces = PlaceType.allPlaceType()
        var dataReceivedCount = 0
        for placeType in allPlaces {
            PlaceWebService().getPlaceList(placeType: placeType) { (placeList, error) in
                if placeList != nil { AppData.sharedData.allPlaces+=placeList! }
                dataReceivedCount+=1
                if dataReceivedCount == allPlaces.count { completion() }
            }
        }
    }
    
    private func prepareTableDataSource() {
        tableDataSource.append(viewModelForPagingCell())
        tableDataSource.append(viewModelForCategoriesCell())
        tableDataSource.append(contentsOf: viewModelForPlaces())
        numberOfRows = tableDataSource.count
    }
    
    private func viewModelForPagingCell()->HomeTableCellType {
        var places = [Place]()
        places.append(contentsOf: Helper.getTopPlace(paceType: .resturant, topPlacesCount: 1))
        places.append(contentsOf: Helper.getTopPlace(paceType: .cafe, topPlacesCount: 1))
        places.append(contentsOf: Helper.getTopPlace(paceType: .nightClub, topPlacesCount: 1))
        places.append(contentsOf: Helper.getTopPlace(paceType: .atm, topPlacesCount: 1))
        let placeSelected: (Place)->() = { [weak self] place in
            // Show place detail
            self?.placeSelected(place)
        }
        return HomeTableCellType.pagingCell(model: PaginationCellVM(data: places, placeSelected: placeSelected))
    }
    
    private func viewModelForCategoriesCell()->HomeTableCellType {
        let categorieVM = CategoriesCollectionCellVM()
        categorieVM.cellSelected = { [weak self] indexPath in
            self?.categorySelected(PlaceType.allPlaceType()[indexPath.row])
        }
        return HomeTableCellType.categoriesCell(model: categorieVM)
    }
    
    private func viewModelForPlaces()->[HomeTableCellType] {
        var cellTypes = [HomeTableCellType]()
        for type in PlaceType.allPlaceType() {
            let topPlaces = Helper.getTopPlace(paceType: type, topPlacesCount: 3)
            let resturantCollectionCellVM = PlacesCollectionCellVM(dataModel: PlacesCollectionCellModel(places: topPlaces, title: type.homeCellTitleText()))
            resturantCollectionCellVM.cellSelected = { [weak self] indexPath in
                self?.placeSelected(topPlaces[indexPath.item])
            }
            cellTypes.append(HomeTableCellType.placesCell(model: resturantCollectionCellVM))
        }
        return cellTypes
    }
    
    func cellType(forIndex indexPath: IndexPath)->HomeTableCellType {
        return tableDataSource[indexPath.row]
    }
    
}
