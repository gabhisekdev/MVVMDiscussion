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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        observeEvents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func prepareTableView() {
        tableView.dataSource = self
        PaginationCell.registerWithTable(tableView)
        CollectionTableCell.registerWithTable(tableView)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    private func observeEvents() {
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
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
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        viewModel.refreshScreen()
    }
    
    private func cellForPagingCell(indexPath: IndexPath, viewModel: PaginationCellVM)->PaginationCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaginationCell.reuseIdentifier, for: indexPath) as! PaginationCell
        cell.prepareCell(viewModel: viewModel)
        return cell
    }
    
    private func cellForCategoriesCell(indexPath: IndexPath, viewModel: CategoriesCollectionCellVM)->CollectionTableCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableCell.reuseIdentifier, for: indexPath) as! CollectionTableCell
        cell.prepareCell(viewModel: viewModel)
        return cell
    }
    
    private func cellForPlacesCell(indexPath: IndexPath, viewModel: PlacesCollectionCellVM)->CollectionTableCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableCell.reuseIdentifier, for: indexPath) as! CollectionTableCell
        cell.prepareCell(viewModel: viewModel)
        return cell
    }
    
}

// MARK: Routing
extension HomeViewController {
    
    private func navigateToPlaceListWithPlaceType(_ placeType: PlaceType) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "PlaceListController") as! PlaceListController
        let placeViewVM = PlaceListVM(placeType: placeType)
        controller.prepareView(viewModel: placeViewVM)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func navigateToPlaceDetailScreenWithPlace(_ place: Place) {
        
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
            return cellForCategoriesCell(indexPath: indexPath, viewModel: model as! CategoriesCollectionCellVM)
        case .placesCell(model: let model):
            return cellForPlacesCell(indexPath: indexPath, viewModel: model as! PlacesCollectionCellVM)
        }
    }
    
}

