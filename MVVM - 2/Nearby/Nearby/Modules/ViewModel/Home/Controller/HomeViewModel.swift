//
//  HomeViewModel.swift
//  Nearby
//
//  Created by Abhisek on 13/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

enum HomeTableCellType {
    case pagingCell(model: PaginationCellVM)
    case categoriesCell(model: TableCollectionCellVMRepresentable)
    case placesCell(model: TableCollectionCellVMRepresentable)
}

class HomeViewModel {
    
    private var tableDataSource: [HomeTableCellType] = [HomeTableCellType]()
    var viewDidLoad: ()->() = {}
    var placeTapped: (Place)->() = { _ in }
    var categoryTapped: (PlaceType)->() = { _ in }
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
    
    private func getAppData(completion: @escaping ()->()) {
        //Show the loader
        let allPlaces = PlaceType.allPlaceType()
        for (index,placeType) in allPlaces.enumerated() {
            PlaceWebService().getPlaceList(placeType: placeType) { (resturantList, error) in
                if resturantList != nil { AppData.sharedData.appData+=resturantList! }
                if index == allPlaces.count - 1 {
                    //Hide the loader
                    completion()
                }
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
        let placeTapped: (Place)->() = { [weak self] place in
            // Show place detail
            self?.placeTapped(place)
        }
        return HomeTableCellType.pagingCell(model: PaginationCellVM(data: places, placeTapped: placeTapped))
    }
    
    private func viewModelForCategoriesCell()->HomeTableCellType {
        let categorieVM = CategoriesCollectionCellVM()
        categorieVM.cellTapped = { [weak self] indexPath in
            self?.categoryTapped(PlaceType.allPlaceType()[indexPath.row])
        }
        return HomeTableCellType.categoriesCell(model: CategoriesCollectionCellVM())
    }
    
    private func viewModelForPlaces()->[HomeTableCellType] {
        var cellTypes = [HomeTableCellType]()
        for type in PlaceType.allPlaceType() {
            let topPlaces = Helper.getTopPlace(paceType: type, topPlacesCount: 3)
            let resturantCollectionCellVM = PlacesCollectionCellVM(dataModel: topPlaces)
            resturantCollectionCellVM.cellTapped = { [weak self] indexPath in
                self?.placeTapped(topPlaces[indexPath.item])
            }
            cellTypes.append(HomeTableCellType.placesCell(model: resturantCollectionCellVM))
        }
        return cellTypes
    }
    
    func cellType(forIndex indexPath: IndexPath)->HomeTableCellType {
        return tableDataSource[indexPath.row]
    }
    
}
