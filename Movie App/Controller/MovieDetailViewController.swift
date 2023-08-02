//
//  MovieDetailViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 26.07.2023.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    private var isFavorite: Bool = false
    
    private var posterPath: String = ""
    private var releaseDate: String = ""
    private var score: Double = 0.0
    
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
    @IBOutlet weak var budgetLabel: UIButton!
    @IBOutlet weak var revenueLabel: UIButton!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    
    @IBOutlet weak var castCollectionView: UICollectionView! {
        didSet {
            prepareCollectionView(collectionView: castCollectionView, cellName: ActorCell.getClassName(), width: ActorCell.actorCellWidth, height: ActorCell.actorCellHeight)
        }
    }
    @IBOutlet weak var recommendationsCollectionView: UICollectionView! {
        didSet {
            prepareCollectionView(collectionView: recommendationsCollectionView, cellName: RecommendationCell.getClassName(), width: RecommendationCell.recommendationCellWidth, height: RecommendationCell.recommendationCellHeight)
        }
    }
    @IBOutlet weak var companiesTableView: UITableView!
    @IBOutlet weak var detailsView: UIView! {
        didSet {
            detailsView.layer.cornerRadius = 30
        }
    }
    
    @IBOutlet weak var favoriteIcon: UIImageView! {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteIconTapped(tapGestureRecognizer:)))
            tapGestureRecognizer.delegate = self
            favoriteIcon.isUserInteractionEnabled = true
            favoriteIcon.addGestureRecognizer(tapGestureRecognizer)
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
    
    func prepareCollectionView(collectionView: UICollectionView, cellName: String, width: CGFloat, height: CGFloat) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellName: cellName)
        collectionView.collectionViewLayout = flowLayout
        
    }
    
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
//        Favorite System
        
        posterPath = movieDetail.poster_path ?? ""
        releaseDate = movieDetail.release_date ?? ""
        score = movieDetail.vote_average ?? 0.0
        
        if CoreDataFunctions.checkMovie(id: movieID) {
            self.favoriteIcon.image = UIImage(systemName: Utilities.favoriteIcon)
            self.isFavorite = true
        } else {
            self.favoriteIcon.image = UIImage(systemName: Utilities.unfavoriteIcon)
            self.isFavorite = false
        }
        
    }
    
}

//MARK: - UICollectionViewDataSource

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.castCollectionView:
            
            if cast.count == 0 {
                castCollectionView.isHidden = true
            } else {
                castCollectionView.isHidden = false
            }
            
            return cast.count
        case self.recommendationsCollectionView:
            
            if recommendations.count == 0 {
                recommendationsCollectionView.isHidden = true
            } else {
                recommendationsCollectionView.isHidden = false
            }
            
            return recommendations.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.castCollectionView:
            
            guard let cell = castCollectionView.dequeueReusableCell(withReuseIdentifier: ActorCell.getClassName(), for: indexPath) as? ActorCell else {
                return UICollectionViewCell()
            }
            let actor = cast[indexPath.row]
            cell.fillCell(actor)
            
            return cell
            
        case self.recommendationsCollectionView:
            
            guard let cell = recommendationsCollectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCell.getClassName(), for: indexPath) as? RecommendationCell else {
                return UICollectionViewCell()
            }
            let movie = recommendations[indexPath.row]
            cell.fillCell(movie)
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
}

//MARK: - UICollectionViewDelegate

extension MovieDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case self.castCollectionView:
            
            if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: CastViewController.self)) as? CastViewController {
                
                nextVC.actorID = cast[indexPath.row].id ?? 0
                
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
        case self.recommendationsCollectionView:
            
            if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
                
                nextVC.movieID = recommendations[indexPath.row].id ?? 0
                
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
        default:
            break
        }
        
    }
    
}

//MARK: - UIGestureRecognizerDelegate

extension MovieDetailViewController: UIGestureRecognizerDelegate {
    
    @objc func favoriteIconTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        if isFavorite {
            CoreDataFunctions.deleteMovie(id: self.movieID)
            isFavorite = false
            favoriteIcon.image = UIImage(systemName: Utilities.unfavoriteIcon)
        } else {
            CoreDataFunctions.saveMovie(id: self.movieID, score: self.score, title: self.titleLabel.text ?? "", poster_path: self.posterPath, releaseDate: self.releaseDate)
            isFavorite = true
            favoriteIcon.image = UIImage(systemName: Utilities.favoriteIcon)
        }
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
