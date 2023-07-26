//
//  MovieDetailViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 26.07.2023.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieID: Int = 0
    var posterPath: String = ""
    private var cast: [Cast] = []
    private var recommendations: [Results] = []
    private var homepageURL: URL?
    
    
//    IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var castScrollView: UIScrollView!
    @IBOutlet weak var budgetLabel: UIButton!
    @IBOutlet weak var revenueLabel: UIButton!
    @IBOutlet weak var companyLogoImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    
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
        overviewLabel.text = movieDetail.overview
        budgetLabel.titleLabel?.text = " \(movieDetail.budget ?? 0)$"
        revenueLabel.titleLabel?.text = " \(movieDetail.revenue ?? 0)$"
        homepageURL = Utilities.stringToURL(movieDetail.homepage ?? "")
    }
    
    

}
