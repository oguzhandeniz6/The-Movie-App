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

        networkCalls()
    }
    
    @IBAction func homepageButtonPressed(_ sender: UIButton) {
        if let url = homepageURL {
            UIApplication.shared.open(url)
        }
    }
    
    func networkCalls() {
        NetworkService.getMovie(movieID: movieID, mdetailVC: self)
        NetworkService.getCast(movieID: movieID, mdetailVC: self)
        NetworkService.getRecommendations(movieID: movieID, mdetailVC: self)
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
            posterImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: posterPath))
        }
        
    }
    
    func prepareCastScrollView() {
        
        if cast.count == 0 {
            castScrollView.isHidden = true
            return
        }
        
        for i in 0..<cast.count {
            let personView = CastView(frame: CGRect(x: CGFloat(i) * (CastView.castViewWidth), y: 0, width: CastView.castViewWidth, height: CastView.castViewHeight))
            personView.fillView(person: cast[i])
            castView.addSubview(personView)
        }
        
        castScrollView.contentSize = CGSize(width: CGFloat(cast.count) * (CastView.castViewWidth), height: CastView.castViewHeight)
    }
    
    func prepareRecommendationScrollView() {
        
        if recommendations.count == 0 {
            recommendationsScrollView.isHidden = true
            return
        }
        
        for i in 0..<recommendations.count {
            let movieView = RecommendationView(frame: CGRect(x: CGFloat(i) * (RecommendationView.recommendationViewWidth), y: 0, width: RecommendationView.recommendationViewWidth, height: RecommendationView.recommendationViewHeight))
            movieView.fillView(movie: recommendations[i])
            recommendationsView.addSubview(movieView)
        }
        
        recommendationsScrollView.contentSize = CGSize(width: CGFloat(recommendations.count) * (RecommendationView.recommendationViewWidth), height: RecommendationView.recommendationViewHeight)
    }
    
}

//MARK: - MovieDetailViewController Extension

extension MovieDetailViewController {
    
    func setCast(cast: [Cast]) {
        self.cast = cast
    }
    
    func setRecommendations(recommendations: [Results]) {
        self.recommendations = recommendations
    }
    
}
