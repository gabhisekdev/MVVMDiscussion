//
//  PlaceTableCell.swift
//  Nearby
//
//  Created by Abhisek on 5/23/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit

class PlaceTableCellViewModel {
    
    private var place: Place!
    
    var placeViewViewModel: PlaceViewViewModel!
    var placeSelected: (Place)->() = { _ in }
    
    init(place: Place) {
        self.place = place
        preparePlaceViewViewModel()
    }
    
    private func preparePlaceViewViewModel() {
        placeViewViewModel = PlaceViewViewModel(place: place)
        placeViewViewModel.placesViewSelected = { [weak self] in
            guard let _self = self else { return }
            _self.placeSelected(_self.place)
        }
    }
    
}

class PlaceTableCell: ReusableTableViewCell {

    @IBOutlet weak var placeView: PlaceView!    
    
    var viewModel: PlaceTableCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareCell(viewModel: PlaceTableCellViewModel) {
        self.viewModel = viewModel
        placeView.preparePlaceView(viewModel: viewModel.placeViewViewModel)
    }
    
}
