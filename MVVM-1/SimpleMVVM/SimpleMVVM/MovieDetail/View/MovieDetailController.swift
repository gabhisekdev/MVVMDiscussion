//
//  MovieDetailController.swift
//  SimpleMVVM
//
//  Created by Abhisek on 06/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    private var viewModel = MovieDetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpUI() {
        movieNameLabel.text = viewModel.movieName
        releaseDateLabel.text = viewModel.releaseDate
        directorNameLabel.text = viewModel.director
        incomeLabel.text = viewModel.income
        ratingLabel.text = viewModel.rating
        moviePosterImageView.image = UIImage(named: viewModel.movieImageName)
        setHeartButtonUI()
    }
    
    private func setHeartButtonUI() {
        let heartImage = viewModel.isFavourite ? #imageLiteral(resourceName: "selectedHeart") : #imageLiteral(resourceName: "unselectedHeart")
        heartButton.setImage(heartImage, for: .normal)
    }
    
    @IBAction func markMovieAsFav(_ sender: Any) {
        viewModel.markFavouriteButtonPressed()
        setHeartButtonUI()
    }
    
}

