//
//  MoviewDetailVM.swift
//  SimpleMVVM
//
//  Created by Abhisek on 06/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

class MovieDetailVM {
    
    //Outputs
    private (set) var movieName, movieImageName, director, releaseDate, income, rating: String!
    private (set) var isFavourite: Bool!
    
    //Data Model of the ViewModel
    private var dataModel: Movie! = nil
    
    //Input to View Model
    var markFavouriteButtonPressed: () -> () = { }
    
    func viewDidLoad() {
        configureDataModel(data: movieData())
        configureOutput()
        markFavouriteButtonPressed = { [weak self] in
            guard let _self = self else { return }
            _self.isFavourite = !_self.isFavourite
        }
    }
    
    
    //Consider this as a data providing API request in general app environment.
    private func movieData() -> [String: Any] {
        return DataGenerator.randomMovie()
    }
    
    //Configure the data model required for the UI population.
    private func configureDataModel(data: [String: Any]) {
        dataModel = Movie(data: data)
    }
    
    //Configure the output properties that are to be accessed by the view.
    private func configureOutput() {
        movieName = dataModel.movieName
        movieImageName = dataModel.movieImageName
        director = dataModel.director
        isFavourite = dataModel.isFavourite
        income = dataModel.income
        releaseDate = releaseDisplayDataForMovie()
        rating = ratingDisplayDataForMovie()
    }
    
    //Process raw date data for output.
    private func releaseDisplayDataForMovie() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd,yyyy"
        return dateFormatter.string(from: dataModel.releaseDate)
    }
    
    //Process raw rating data for output.
    private func ratingDisplayDataForMovie() -> String {
        return "\(dataModel.rating)/10.0"
    }
    
}
