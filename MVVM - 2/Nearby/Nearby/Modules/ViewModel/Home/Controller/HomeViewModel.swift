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
    case pagingCell(model: PaginationCellViewModel)
    case categoriesCell(model: TableCollectionCellViewModelRepresentable)
    case placesCell(model: TableCollectionCellViewModelRepresentable)
}

class HomeViewModel {
    
    /// Data source for the home page table view.
    private var tableDataSource: [HomeTableCellType] = [HomeTableCellType]()
    
    // MARK: Input
    var viewDidLoad: ()->() = {}
    
    // MARK: Events
    
    /// Callback to pass the selected place.
    var placeSelected: (Place)->() = { _ in }
    /// Callback to pass the selected category.
    var categorySelected: (PlaceType)->() = { _ in }
    /// Callback to reload the table.
    var reloadTable: ()->() = { }
    
    // MARK: Output
    var numberOfRows = 0
    
    init() {
        viewDidLoad = { [weak self] in
            self?.getAppData(completion: {
                self?.prepareTableDataSource()
                self?.reloadTable()
            })
        }
    }
    
    /// Method call to inform the view model to refresh the data.
    func refreshScreen() {
        tableDataSource.removeAll() //
        self.getAppData(completion: { [weak self] in
            self?.prepareTableDataSource()
            self?.reloadTable()
        })
    }
    
    private func getAppData(completion: @escaping ()->()) {
        let allPlaces = PlaceType.allPlaceType()
        var dataReceivedCount = 0
        var places = [Place]()
        for placeType in allPlaces {
            
            PlaceWebService().getPlaceList(placeType: placeType) { (placeList, error) in
                if placeList != nil {
                    places+=placeList!
                }
                dataReceivedCount+=1
                if dataReceivedCount == allPlaces.count {
                    // Reset the app data and populate with new data.
                    AppData.sharedData.resetData()
                    AppData.sharedData.allPlaces = places
                    completion()
                }
            }
        }
    }
    
    /// Prepare the tableDataSource
    private func prepareTableDataSource() {
        tableDataSource.append(cellTypeForPagingCell())
        tableDataSource.append(cellTypeForCategoriesCell())
        tableDataSource.append(contentsOf: cellTypeForPlaces())
        numberOfRows = tableDataSource.count
    }
    
    /// Provides a pagination cell type for each place type.
    private func cellTypeForPagingCell()->HomeTableCellType {
        var places = [Place]()
        for placeType in PlaceType.allPlaceType() {
            places.append(contentsOf: Helper.getTopPlace(paceType: placeType, topPlacesCount: 1))
        }
        let placeSelected: (Place)->() = { [weak self] place in
            // Show place detail
            self?.placeSelected(place)
        }
        return HomeTableCellType.pagingCell(model: PaginationCellViewModel(data: places, placeSelected: placeSelected))
    }
    
    /// Provides a placesCell type.
    private func cellTypeForCategoriesCell()->HomeTableCellType {
        let categorieViewModel = CategoriesTableCollectionCellViewModel()
        categorieViewModel.cellSelected = { [weak self] indexPath in
            self?.categorySelected(PlaceType.allPlaceType()[indexPath.row])
        }
        return HomeTableCellType.categoriesCell(model: categorieViewModel)
    }
    
    /// Provides a placesCell type.
    private func cellTypeForPlaces()->[HomeTableCellType] {
        var cellTypes = [HomeTableCellType]()
        let allPlaceTypes = PlaceType.allPlaceType()
        for type in allPlaceTypes {
            let topPlaces = Helper.getTopPlace(paceType: type, topPlacesCount: 3)
            let placeCellViewModel = PlacesTableCollectionCellViewModel(dataModel: PlacesTableCollectionCellModel(places: topPlaces, title: type.homeCellTitleText()))
            placeCellViewModel.cellSelected = { [weak self] indexPath in
                self?.placeSelected(topPlaces[indexPath.item])
            }
            if topPlaces.count > 0 {
                cellTypes.append(HomeTableCellType.placesCell(model: placeCellViewModel))
            }
        }
        return cellTypes
    }
    
    /// Provides the view with appropriate cell type corresponding to an index.
    func cellType(forIndex indexPath: IndexPath)->HomeTableCellType {
        return tableDataSource[indexPath.row]
    }
    
}
