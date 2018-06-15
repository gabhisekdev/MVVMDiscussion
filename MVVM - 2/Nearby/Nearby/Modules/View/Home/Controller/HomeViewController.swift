//
//  HomeViewController.swift
//  Nearby
//
//  Created by Abhisek on 07/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = HomeViewModel()
    /// Flag to safeguard an one time refresh of screen in case of location update.
    var isRefreshInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        observeEvents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Prepare the table view.
    private func prepareTableView() {
        tableView.dataSource = self
        PaginationCell.registerWithTable(tableView)
        CollectionTableCell.registerWithTable(tableView)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    /// Function to observe various event call backs from the viewmodel as well as Notifications.
    private func observeEvents() {
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.isRefreshInProgress = false
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
        
        viewModel.placeSelected = { [weak self] place in
            DispatchQueue.main.async {
                self?.navigateToPlaceDetailScreenWithPlace(place)
            }
        }
        
        viewModel.categorySelected = { [weak self] type in
            DispatchQueue.main.async {
                self?.navigateToPlaceListWithPlaceType(type)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.locationAvailable(notification:)), name: Notification.Name("LocationAvailable"), object: nil)
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        refreshScreen()
    }
    
    /// Refresh the screen when refresh button is pressed.
    private func refreshScreen() {
        isRefreshInProgress = true
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        viewModel.refreshScreen()
    }
    
    /// Provides a paging cell.
    private func cellForPagingCell(indexPath: IndexPath, viewModel: PaginationCellViewModel)->PaginationCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaginationCell.reuseIdentifier, for: indexPath) as! PaginationCell
        cell.selectionStyle = .none
        cell.prepareCell(viewModel: viewModel)
        return cell
    }
    
    /// Provides a category cell.
    private func cellForCategoriesCell(indexPath: IndexPath, viewModel: TableCollectionCellViewModelRepresentable)->CollectionTableCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableCell.reuseIdentifier, for: indexPath) as! CollectionTableCell
        cell.selectionStyle = .none
        cell.prepareCell(viewModel: viewModel)
        return cell
    }
    
    /// Provides a places cell.
    private func cellForPlacesCell(indexPath: IndexPath, viewModel: TableCollectionCellViewModelRepresentable)->CollectionTableCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableCell.reuseIdentifier, for: indexPath) as! CollectionTableCell
        cell.selectionStyle = .none
        cell.prepareCell(viewModel: viewModel)
        return cell
    }
    
    /// Handler to observe notification events from LocationManager.
    @objc private func locationAvailable(notification: Notification) {
        // No need to refresh the screen automatically if data is already present.
        guard AppData.sharedData.allPlaces.isEmpty, !isRefreshInProgress else { return }
        refreshScreen()
    }
    
}

// MARK: Routing
extension HomeViewController {
    
    private func navigateToPlaceListWithPlaceType(_ placeType: PlaceType) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "PlaceListController") as! PlaceListController
        let placeViewViewModel = PlaceListViewModel(placeType: placeType)
        controller.prepareView(viewModel: placeViewViewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func navigateToPlaceDetailScreenWithPlace(_ place: Place) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "PlaceDetailController") as! PlaceDetailController
        let placeViewViewModel = PlaceDetailViewModel(place: place)
        controller.prepareView(viewModel: placeViewViewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

//MARK: UITableViewDatasource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.cellType(forIndex: indexPath)
        switch cellType {
        case .pagingCell(let model):
            return cellForPagingCell(indexPath: indexPath, viewModel: model)
        case .categoriesCell(model: let model):
            return cellForCategoriesCell(indexPath: indexPath, viewModel: model)
        case .placesCell(model: let model):
            return cellForPlacesCell(indexPath: indexPath, viewModel: model)
        }
    }
    
}

