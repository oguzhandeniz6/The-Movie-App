//
//  MovieDetailViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 26.07.2023.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    private var rawMovie: Movie?
    
    private var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                favoriteIcon.image = UIImage(systemName: UIConstants.favoriteIcon)
            } else {
                favoriteIcon.image = UIImage(systemName: UIConstants.unfavoriteIcon)
            }
        }
    }
    
    var movieID: Int = 0
    private var cast: [Cast] = []
    private var recommendations: [Movie] = []
    private var companies: [ProductionCompany] = []
    private var homepageURL: URL?
    
    
    //    IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var orgTitleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.superview?.sendSubviewToBack(posterImageView)
        }
    }
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
    @IBOutlet weak var reviewsPage: UIButton! {
        didSet {
            let insetAmount = 25.0;
            reviewsPage.setTitle(LocalizationHelper.reviewPageName.localizeString(), for: .normal)
            
            reviewsPage.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            reviewsPage.layer.cornerRadius = UIConstants.buttonCornerRadius
        }
    }
    
    
    
    @IBOutlet weak var movieDetailScrollView: UIScrollView! {
        didSet {
            movieDetailScrollView.contentInset = UIEdgeInsets(top: UIConstants.scrollViewTopInset, left: 0.0, bottom: 0.0, right: 0.0)
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
        
        let notificationCenter: NotificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(changeFavoriteStatus), name: .favoriteNotification, object: nil)
        
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        companiesTableViewHeightConstraint.constant = companiesTableView.contentSize.height
    }
    
    func loadData() {
        
        NetworkService.getMovie(movieID: movieID) { movie in
            self.preparePage(movieDetail: movie)
        }
    }
    
    @IBAction func homepageButtonPressed(_ sender: UIButton) {
        if let url = homepageURL {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func reviewButtonPressed(_ sender: UIButton) {
        
        if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieReviewsViewController.self)) as? MovieReviewsViewController {
            
            nextVC.movieID = self.movieID
            self.present(nextVC, animated: true)
        }
    }
    
}

//MARK: - Prepare Extensions

extension MovieDetailViewController {
    
    func preparePage(movieDetail: MovieDetail) {
        
//        Prepare Details
        
        self.detailsNetworkHandle(movieDetail: movieDetail)
        
//        Prepare Poster Image
        
        if let posterPath = movieDetail.posterPath {
            posterImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: posterPath, imageSize: PosterSize.original.rawValue))
        }
        
//        Prepare Cast and Recommendations
        
        if let credits = movieDetail.credits, let cast = credits.cast {
            self.castNetworkHandle(cast: cast)
        }
        
        if let recommendationResults = movieDetail.recommendations, let recommendations = recommendationResults.results {
            self.recommendationsNetworkHandle(recommendations: recommendations)
        }
        
//        Prepare Production Companies
        
        if let productionCompanies = movieDetail.productionCompanies {
            self.companiesNetworkHandle(companies: productionCompanies)
        }
        
//        Prepare Favorite System
        
        self.rawMovie = Movie(id: self.movieID, title: movieDetail.title, releaseDate: movieDetail.releaseDate, posterPath: movieDetail.posterPath, voteAverage: movieDetail.voteAverage)
        
        if CoreDataFunctions.checkMovie(id: movieID) {
            self.isFavorite = true
        } else {
            self.isFavorite = false
        }
        
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
        
        if let mov = self.rawMovie {
            if isFavorite {
                CoreDataFunctions.deleteMovie(id: self.movieID)
                isFavorite = false

            } else {
                CoreDataFunctions.saveMovie(movie: mov)
                isFavorite = true
            }
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
    
    private func detailsNetworkHandle(movieDetail: MovieDetail) {
        titleLabel.text = movieDetail.title
        orgTitleLabel.text = movieDetail.originalTitle
        taglineLabel.text = movieDetail.tagline
        genresLabel.text = FormatChangers.genresFormatToStrWithNames(gen: movieDetail.genres)
        runtimeLabel.text = "\(movieDetail.runtime ?? 0) \(LocalizationHelper.minuteName.localizeString())"
        scoreLabel.text = String(format: "%.1f" , movieDetail.voteAverage ?? 0.0)
        overviewLabel.text = movieDetail.overview
        budgetLabel.setTitle(FormatChangers.moneyFormatChanger(amount: movieDetail.budget ?? 0), for: .normal)
        revenueLabel.setTitle(FormatChangers.moneyFormatChanger(amount: movieDetail.revenue ?? 0), for: .normal)
        releaseDateLabel.text = FormatChangers.dateFormatChanger(str: movieDetail.releaseDate ?? "")
        homepageURL = NetworkConstants.getHomepage(homepage: movieDetail.homepage)
    }
    
    private func castNetworkHandle(cast: [Cast]) {
        self.setCast(cast: cast)
        self.castCollectionView.reloadData()
    }
    
    private func recommendationsNetworkHandle(recommendations: [Movie]) {
        self.setRecommendations(recommendations: recommendations)
        self.recommendationsCollectionView.reloadData()
    }
    
    private func companiesNetworkHandle(companies: [ProductionCompany]) {
        self.companies = companies
        self.companiesTableView.reloadData()
    }
    
//    Favorite System
    
    @objc private func changeFavoriteStatus() {
        self.isFavorite = !(self.isFavorite)
    }
    
}
