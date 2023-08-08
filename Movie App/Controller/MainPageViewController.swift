//
//  MainPageViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 7.08.2023.
//

import UIKit

class MainPageViewController: UIViewController {
    
    private var genresList: [Genre] = []
    private var chosenGenres: [Genre] = []
    
    private var nowPlayingList: [Movie] = []
    private var upcomingList: [Movie] = []
    private var genre1List: [Movie] = []
    private var genre2List: [Movie] = []
    private var genre3List: [Movie] = []
    
    
    @IBOutlet weak var homepageTabBar: UITabBarItem! {
        didSet {
            homepageTabBar.title = "homepageTabBar".localizeString(lang: NSLocale.current.languageCode ?? "en")
        }
    }
    
    
    @IBOutlet weak var nowPlayingLabel: UILabel! {
        didSet {
            nowPlayingLabel.text = "nowPlaying".localizeString(lang: NSLocale.current.languageCode ?? "en")
        }
    }
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView! {
        didSet {
            nowPlayingCollectionView.delegate = self
            nowPlayingCollectionView.dataSource = self
            nowPlayingCollectionView.prepareCollectionView(cellName: RecommendationCell.getClassName(), width: RecommendationCell.recommendationCellWidth, height: RecommendationCell.movieCellHeight)
        }
    }
    
    @IBOutlet weak var upcomingLabel: UILabel! {
        didSet {
            upcomingLabel.text = "upcoming".localizeString(lang: NSLocale.current.languageCode ?? "en")
        }
    }
    @IBOutlet weak var upcomingCollectionView: UICollectionView! {
        didSet {
            upcomingCollectionView.delegate = self
            upcomingCollectionView.dataSource = self
            upcomingCollectionView.prepareCollectionView(cellName: RecommendationCell.getClassName(), width: RecommendationCell.recommendationCellWidth, height: RecommendationCell.movieCellHeight)
        }
    }
    
    @IBOutlet weak var genre1Label: UILabel!
    @IBOutlet weak var genre1CollectionView: UICollectionView! {
        didSet {
            genre1CollectionView.delegate = self
            genre1CollectionView.dataSource = self
            genre1CollectionView.prepareCollectionView(cellName: RecommendationCell.getClassName(), width: RecommendationCell.recommendationCellWidth, height: RecommendationCell.movieCellHeight)
        }
    }
    
    @IBOutlet weak var genre2Label: UILabel!
    @IBOutlet weak var genre2CollectionView: UICollectionView! {
        didSet {
            genre2CollectionView.delegate = self
            genre2CollectionView.dataSource = self
            genre2CollectionView.prepareCollectionView(cellName: RecommendationCell.getClassName(), width: RecommendationCell.recommendationCellWidth, height: RecommendationCell.movieCellHeight)
        }
    }
    
    @IBOutlet weak var genre3Label: UILabel!
    @IBOutlet weak var genre3CollectionView: UICollectionView! {
        didSet {
            genre3CollectionView.delegate = self
            genre3CollectionView.dataSource = self
            genre3CollectionView.prepareCollectionView(cellName: RecommendationCell.getClassName(), width: RecommendationCell.recommendationCellWidth, height: RecommendationCell.movieCellHeight)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkCalls()
    }
    
    func networkCalls() {
        NetworkService.getNowPlayingMovies(mainVC: self)
        NetworkService.getUpcomingMovies(mainVC: self)
        NetworkService.getGenres(mainVC: self)
    }

}

//MARK: - UICollectionViewDataSource

extension MainPageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.nowPlayingCollectionView:
            return nowPlayingCollectionView.getNumberOfItems(list: nowPlayingList)
            
        case self.upcomingCollectionView:
            return upcomingCollectionView.getNumberOfItems(list: upcomingList)
            
        case self.genre1CollectionView:
            return genre1CollectionView.getNumberOfItems(list: genre1List)
            
        case self.genre2CollectionView:
            return genre2CollectionView.getNumberOfItems(list: genre2List)
            
        case self.genre3CollectionView:
            return genre3CollectionView.getNumberOfItems(list: genre3List)
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCell.getClassName(), for: indexPath) as? RecommendationCell else {
            return UICollectionViewCell()
        }
        
        switch collectionView {
        case self.nowPlayingCollectionView:
            cell.fillCell(nowPlayingList[indexPath.row])

        case self.upcomingCollectionView:
            cell.fillCell(upcomingList[indexPath.row])

        case self.genre1CollectionView:
            cell.fillCell(genre1List[indexPath.row])

            
        case self.genre2CollectionView:
            cell.fillCell(genre2List[indexPath.row])
            
        case self.genre3CollectionView:
            cell.fillCell(genre3List[indexPath.row])
            
        default:
            return UICollectionViewCell()
        }
        
        cell.setForHomepage()
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate

extension MainPageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController else {
            return
        }
        
        switch collectionView {
        case self.nowPlayingCollectionView:
            nextVC.movieID = nowPlayingList[indexPath.row].id ?? 0

        case self.upcomingCollectionView:
            nextVC.movieID = upcomingList[indexPath.row].id ?? 0

        case self.genre1CollectionView:
            nextVC.movieID = genre1List[indexPath.row].id ?? 0

            
        case self.genre2CollectionView:
            nextVC.movieID = genre2List[indexPath.row].id ?? 0
            
        case self.genre3CollectionView:
            nextVC.movieID = genre3List[indexPath.row].id ?? 0
            
        default:
            break
        }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}

//MARK: - MainPageViewController Extension

extension MainPageViewController {
    
    func getChosenGenres() -> [Genre] {
        return chosenGenres
    }
    
    func setGenresList(genres: [Genre]) {
        self.genresList = genres
    }
    
    func setChosenGenres(genres: [Genre]) {
        self.chosenGenres = genres
    }
    
    func setNowPlayingList(movies: [Movie]) {
        self.nowPlayingList = movies
    }
    
    func setUpcomingList(movies: [Movie]) {
        self.upcomingList = movies
    }
    
    func setGenre1List(movies: [Movie]) {
        self.genre1List = movies
    }
    
    func setGenre2List(movies: [Movie]) {
        self.genre2List = movies
    }
    
    func setGenre3List(movies: [Movie]) {
        self.genre3List = movies
    }
}
