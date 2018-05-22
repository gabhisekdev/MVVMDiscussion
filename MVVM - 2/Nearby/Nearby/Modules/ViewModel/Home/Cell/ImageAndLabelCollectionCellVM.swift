//
//  ImageAndLabelCollectionCellVM.swift
//  Nearby
//
//  Created by Abhisek on 20/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

struct ImageAndLabelCollectionCellDataModel {
    var name: String = ""
    var imageUrl: String = ""
}

class ImageAndLabelCollectionCellVM {
    
    private var dataModel: ImageAndLabelCollectionCellDataModel!
    
    // Output
    var imageURL: String!
    var text: String!
    
    init(dataModel: ImageAndLabelCollectionCellDataModel) {
        self.dataModel = dataModel
        configureOutput()
    }
    
    private func configureOutput() {
        imageURL = dataModel.imageUrl
        text = dataModel.name
    }
    
}
