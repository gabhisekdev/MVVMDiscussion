//
//  ImageAndLabelCollectionCellVM.swift
//  Nearby
//
//  Created by Abhisek on 20/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

struct ImageAndLabelCollectionCellModel {
    var name: String = ""
    var imageUrl: String = ""
}

class ImageAndLabelCollectionCellVM {
    
    private var dataModel: ImageAndLabelCollectionCellModel!
    
    // Output
    var imageURL: String!
    var text: String!
    
    init(dataModel: ImageAndLabelCollectionCellModel) {
        self.dataModel = dataModel
        configureOutput()
    }
    
    private func configureOutput() {
        imageURL = dataModel.imageUrl
        text = dataModel.name
    }
    
}
