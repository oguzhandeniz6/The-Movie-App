//
//  MovieDetailViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 26.07.2023.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    private var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                favoriteIcon.image = UIImage(systemName: UIConstants.favoriteIcon)
            } else {
                favoriteIcon.image = UIImage(systemName: UIConstants.unfavoriteIcon)
            }
        }
    }
    
    private var posterPath: String = ""
    private var releaseDate: String = ""
    private var score: Double = 0.0
    
    var movieID: Int = 0
    private var cast: [Cast] = []
    private var recommendations: [Movie] = []
    private var companies: [ProductionCompany] = []
    private var homepageURL: URL?
    
    
    //    IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var orgTitleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var budgetLabel: UIButton!
    @IBOutlet weak var revenueLabel: UIButton!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var movieHomepage: UIButton! {
        didSet {
            movieHomepage.setTitle(LocalizationHelper.movieHomepageName.localizeString(), for: .normal)
        }
    }
    
    
    @IBOutlet weak var castCollectionView: UICollectionView! {
        didSet {
            castCollectionView.delegate = self
            castCollectionView.dataSource = self
            castCollectionView.prepareCollectionView(cell: ActorCell.self, width: ActorCell.actorCellWidth, height: ActorCell.actorCellHeight)
        }
    }
    @IBOutlet weak var recommendationsCollectionView: UICollectionView! {
        didSet {
            recommendationsCollectionView.delegate = self
            recommendationsCollectionView.dataSource = self
            recommendationsCollectionView.prepareCollectionView(cell: MoviePosterCell.self, width: MoviePosterCell.recommendationCellWidth, height: MoviePosterCell.recommendationCellHeight)
        }
    }
    @IBOutlet weak var companiesTableView: UITableView! {
        didSet {
            companiesTableView.dataSource = self
            companiesTableView.register(cell: CompanyTableViewCell.self)
        }
    }
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
    
    @IBOutlet weak var companiesTableViewHeightConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    @IBAction func homepageButtonPressed(_ sender: UIButton) {
        if let url = homepageURL {
            print(url)
            UIApplication.shared.open(url)
        }
    }
    
    func loadData() {
        
        NetworkService.getMovie(movieID: movieID) { movie in
            self.preparePage(movieDetail: movie)
        }
        
        NetworkService.getCast(movieID: movieID) { cast in
            self.castNetworkHandle(cast: cast)
        }
        
        NetworkService.getMovieList(callType: .recommendationMovies, movieId: movieID) { recommendationList, _ in
            self.recommendationsNetworkHandle(recommendations: recommendationList)
        }
    }
    
    
}

//MARK: - Prepare Extensions

extension MovieDetailViewController {
    
    func preparePage(movieDetail: MovieDetail) {
        titleLabel.text = movieDetail.title
        orgTitleLabel.text = movieDetail.original_title
        taglineLabel.text = movieDetail.tagline
        genresLabel.text = FormatChangers.genresFormatToStr(gen: movieDetail.genres)
        runtimeLabel.text = "\(movieDetail.runtime ?? 0) \(LocalizationHelper.minuteName.localizeString())"
        scoreLabel.text = String(format: "%.1f" , movieDetail.vote_average ?? 0.0)
        overviewLabel.text = movieDetail.overview
        budgetLabel.setTitle(FormatChangers.moneyFormatChanger(amount: movieDetail.budget ?? 0), for: .normal)
        revenueLabel.setTitle(FormatChangers.moneyFormatChanger(amount: movieDetail.revenue ?? 0), for: .normal)
        releaseDateLabel.text = FormatChangers.dateFormatChanger(str: movieDetail.release_date ?? "")
        homepageURL = NetworkConstants.getHomepage(homepage: movieDetail.homepage)
        
        if let posterPath = movieDetail.poster_path {
            posterImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: posterPath, imageSize: PosterSize.original.rawValue))
        }
        
        companies = movieDetail.production_companies ?? []
        
//        Favorite System
        
        posterPath = movieDetail.poster_path ?? ""
        releaseDate = movieDetail.release_date ?? ""
        score = movieDetail.vote_average ?? 0.0
        
        if CoreDataFunctions.checkMovie(id: movieID) {
            self.isFavorite = true
        } else {
            self.isFavorite = false
        }
        
        companiesTableView.reloadData()
        
    }
    
}

//MARK: - UICollectionViewDataSource

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.castCollectionView:
            return castCollectionView.updateVisibilityAndGetItemCount(list: cast)
        case self.recommendationsCollectionView:
            return recommendationsCollectionView.updateVisibilityAndGetItemCount(list: recommendations)
            
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
            
            guard let cell = recommendationsCollectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.getClassName(), for: indexPath) as? MoviePosterCell else {
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

//MARK: - UITableViewDataSource

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        companiesTableViewHeightConstraint.constant = CompanyTableViewCell.companyCellHeight * CGFloat(companies.count)
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let companyCell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.getClassName(), for: indexPath) as? CompanyTableViewCell else {
            return CompanyTableViewCell()
        }
        
        let company = companies[indexPath.row]
        companyCell.fillCell(company)
        
        return companyCell
    }
    
    
}

//MARK: - UIGestureRecognizerDelegate

extension MovieDetailViewController: UIGestureRecognizerDelegate {
    
    @objc func favoriteIconTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        if isFavorite {
            CoreDataFunctions.deleteMovie(id: self.movieID)
            isFavorite = false

        } else {
            CoreDataFunctions.saveMovie(id: self.movieID, score: self.score, title: self.titleLabel.text ?? "", poster_path: self.posterPath, releaseDate: self.releaseDate)
            isFavorite = true
        }
    }
}


//MARK: - MovieDetailViewController Extension

extension MovieDetailViewController {
    
//    Setters
    
    func setCast(cast: [Cast]) {
        self.cast = cast
    }
    
    func setRecommendations(recommendations: [Movie]) {
        self.recommendations = recommendations
    }
    
//    Network Handlers
    
    func castNetworkHandle(cast: [Cast]) {
        self.setCast(cast: cast)
        self.castCollectionView.reloadData()
    }
    
    func recommendationsNetworkHandle(recommendations: [Movie]) {
        self.setRecommendations(recommendations: recommendations)
        self.recommendationsCollectionView.reloadData()
    }
    
}
