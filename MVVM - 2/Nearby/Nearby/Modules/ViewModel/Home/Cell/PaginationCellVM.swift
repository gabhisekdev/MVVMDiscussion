//
//  PaginationCellViewModel.swift
//  Nearby
//
//  Created by Abhisek on 14/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

class PaginationCellVM {
    
    private var dataSource = [Place]()
    var numberOfPages = 0
    var placeTapped: (Place)->()?
    
    init(data: [Place], placeTapped: @escaping (Place)->()) {
        dataSource = data
        self.placeTapped = placeTapped
    }
    
    private func configureOutput() {
        numberOfPages = dataSource.count
    }
    
    func viewModelForPlaceView(position: Int)->PlaceViewVM {
        let place = dataSource[position]
        let placeViewVM = PlaceViewVM(place: place)
        placeViewVM.placesViewTapped = { [weak self] in
            self?.placeTapped(place)
        }
        return placeViewVM
    }
    
}
