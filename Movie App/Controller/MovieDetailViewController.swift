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
    @IBOutlet weak var castView: UIView!
    @IBOutlet weak var budgetLabel: UIButton!
    @IBOutlet weak var revenueLabel: UIButton!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var recommendationsView: UIView!
    
    
    @IBOutlet weak var castScrollView: UIScrollView!
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
                    self.prepareCastScrollView()
                }
            })
        NetworkManager.shared.fetchDataObject(
            urlString: NetworkConstants.shared.getMovieRecommendations(movieID: movieID),
            dataType: APIResults.self, completion: { result in
                if let fetchedMovies = result.results {
                    self.recommendations = fetchedMovies
                    self.prepareRecommendationScrollView()
                }
            })
    }

    
}

//MARK: - Prepare Extensions

extension MovieDetailViewController {
    
    func preparePage(movieDetail: MovieDetail) {
        titleLabel.text = movieDetail.title
        taglineLabel.text = movieDetail.tagline
        genresLabel.text = Utilities.genresArrayToStr(gen: movieDetail.genres)
        runtimeLabel.text = "\(movieDetail.runtime ?? 0) min"
        scoreLabel.text = String(format: "%.1f" , movieDetail.vote_average ?? 0.0)
        overviewLabel.text = movieDetail.overview
        budgetLabel.setTitle(Utilities.moneyFormatChanger(amount: movieDetail.budget ?? 0), for: .normal)
        revenueLabel.setTitle(Utilities.moneyFormatChanger(amount: movieDetail.revenue ?? 0), for: .normal)
        releaseDateLabel.text = Utilities.dateFormatChanger(str: movieDetail.release_date ?? "")
        homepageURL = Utilities.stringToURL(movieDetail.homepage ?? "")
        
        if let posterPath = movieDetail.poster_path {
            posterImageView.kf.setImage(with: NetworkConstants.shared.getMoviePoster(posterPath: posterPath))
        }
        
    }
    
    func prepareCastScrollView() {
        for i in 0..<cast.count {
            let personView = CastView(frame: CGRect(x: CGFloat(i) * (CastView.castViewWidth), y: 0, width: CastView.castViewWidth, height: CastView.castViewHeight))
            personView.fillView(person: cast[i])
            castView.addSubview(personView)
        }
        
        castScrollView.contentSize = CGSize(width: CGFloat(cast.count) * (CastView.castViewWidth), height: CastView.castViewHeight)
    }
    
    func prepareRecommendationScrollView() {
        for i in 0..<recommendations.count {
            let movieView = RecommendationView(frame: CGRect(x: CGFloat(i) * (RecommendationView.recommendationViewWidth), y: 0, width: RecommendationView.recommendationViewWidth, height: RecommendationView.recommendationViewHeight))
            movieView.fillView(movie: recommendations[i])
            recommendationsView.addSubview(movieView)
        }
        
        recommendationsScrollView.contentSize = CGSize(width: CGFloat(recommendations.count) * (RecommendationView.recommendationViewWidth), height: RecommendationView.recommendationViewHeight)
    }
    
}
