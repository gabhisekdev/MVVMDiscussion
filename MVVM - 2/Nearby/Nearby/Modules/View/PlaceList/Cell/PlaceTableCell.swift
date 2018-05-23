//
//  PlaceTableCell.swift
//  Nearby
//
//  Created by Kuliza-241 on 5/23/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit

class PlaceTableCellVM {
    
    private var place: Place!
    
    var placeViewVM: PlaceViewVM!
    var placeSelected: (Place)->() = { _ in }
    
    init(place: Place) {
        self.place = place
        preparePlaceViewVM()
    }
    
    private func preparePlaceViewVM() {
        placeViewVM = PlaceViewVM(place: place)
        placeViewVM.placesViewSelected = { [weak self] in
            guard let _self = self else { return }
            _self.placeSelected(_self.place)
        }
    }
    
}

class PlaceTableCell: ReusableTableViewCell {

    @IBOutlet weak var placeView: PlaceView!    
    
    var viewModel: PlaceTableCellVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareCell(viewModel: PlaceTableCellVM) {
        self.viewModel = viewModel
        placeView.preparePlaceView(viewModel: viewModel.placeViewVM)
    }
    
}
