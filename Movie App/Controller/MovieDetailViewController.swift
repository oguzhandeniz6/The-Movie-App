//
//  MovieDetailViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 26.07.2023.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    var movieID: Int = 0
    private var cast: [Cast] = []
    private var recommendations: [Results] = []
    private var homepageURL: URL?
    
    
//    IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var castScrollView: UIScrollView!
    @IBOutlet weak var budgetLabel: UIButton!
    @IBOutlet weak var revenueLabel: UIButton!
    @IBOutlet weak var recommendationsScrollView: UIScrollView!
    @IBOutlet weak var companiesTableView: UITableView!
    
    @IBOutlet weak var detailsView: UIView! {
        didSet {
            detailsView.layer.cornerRadius = 30
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        networkCall()
    }
    
    @IBAction func homepageButtonPressed(_ sender: UIButton) {
        if let url = homepageURL {
            UIApplication.shared.open(url)
        }
    }
    
    func networkCall() {
        NetworkManager.shared.fetchDataObject(
            urlString: NetworkConstants.shared.getMovie(movieID: movieID),
            dataType: MovieDetail.self, completion: { result in
                self.preparePage(movieDetail: result)
            })
        NetworkManager.shared.fetchDataObject(
            urlString: NetworkConstants.shared.getMovieCredits(movieID: movieID),
            dataType: Credits.self, completion: { result in
                if let credits = result.cast {
                    self.cast = credits
                }
            })
        NetworkManager.shared.fetchDataObject(
            urlString: NetworkConstants.shared.getMovieRecommendations(movieID: movieID),
            dataType: APIResults.self, completion: { result in
                if let fetchedMovies = result.results {
                    self.recommendations = fetchedMovies
                }
            })
    }
    
    func preparePage(movieDetail: MovieDetail) {
        titleLabel.text = movieDetail.title
        taglineLabel.text = movieDetail.tagline
        genresLabel.text = Utilities.genresArrayToStr(gen: movieDetail.genres)
        runtimeLabel.text = "\(movieDetail.runtime ?? 0) min"
        scoreLabel.text = String(format: "%.1f" , movieDetail.vote_average ?? 0.0)
        overviewLabel.text = movieDetail.overview
        budgetLabel.setTitle(" \(movieDetail.budget ?? 0)$", for: .normal)
        revenueLabel.setTitle(" \(movieDetail.revenue ?? 0)$", for: .normal)
        homepageURL = Utilities.stringToURL(movieDetail.homepage ?? "")
        
        if let posterPath = movieDetail.poster_path {
            posterImageView.kf.setImage(with: NetworkConstants.shared.getMoviePoster(posterPath: posterPath))
        }
        
    }
    
    

}
