//
//  MainPageViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 7.08.2023.
//

import UIKit

class MainPageViewController: UIViewController {
    
    var npCallObject: PaginationCallObject?
    var upCallObject: PaginationCallObject?
    var g1CallObject: GenreCallObject?
    var g2CallObject: GenreCallObject?
    var g3CallObject: GenreCallObject?
    
    private var genresList: [Genre] = []
    
    private var nowPlayingList: [Movie] = []
    private var upcomingList: [Movie] = []
    private var genre1List: [Movie] = []
    private var genre2List: [Movie] = []
    private var genre3List: [Movie] = []
    
    private var npCurrentPage: Int = 1 {
        didSet {
            npCallObject?.pageNumber = npCurrentPage
        }
    }
    private var upCurrentPage: Int = 1 {
        didSet {
            upCallObject?.pageNumber = upCurrentPage
        }
    }
    private var g1CurrentPage: Int = 1 {
        didSet {
            g1CallObject?.pageNumber = g1CurrentPage
        }
    }
    private var g2CurrentPage: Int = 1 {
        didSet {
            g2CallObject?.pageNumber = g2CurrentPage
        }
    }
    private var g3CurrentPage: Int = 1 {
        didSet {
            g3CallObject?.pageNumber = g3CurrentPage
        }
    }
    
    private var npMaxPage: Int = 1
    private var upMaxPage: Int = 1
    private var g1MaxPage: Int = 1
    private var g2MaxPage: Int = 1
    private var g3MaxPage: Int = 1
    
    
    @IBOutlet weak var homepageTabBar: UITabBarItem! {
        didSet {
            homepageTabBar.title = LocalizationHelper.homepageTabBarName.localizeString()
        }
    }
    
    
    @IBOutlet weak var nowPlayingLabel: UILabel! {
        didSet {
            nowPlayingLabel.text = LocalizationHelper.nowPlayingName.localizeString()
        }
    }
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView! {
        didSet {
            nowPlayingCollectionView.delegate = self
            nowPlayingCollectionView.dataSource = self
            nowPlayingCollectionView.prepareCollectionView(cell: MoviePosterCell.self, width: MoviePosterCell.recommendationCellWidth, height: MoviePosterCell.movieCellHeight)
        }
    }
    
    @IBOutlet weak var upcomingLabel: UILabel! {
        didSet {
            upcomingLabel.text = LocalizationHelper.upcomingName.localizeString()
        }
    }
    @IBOutlet weak var upcomingCollectionView: UICollectionView! {
        didSet {
            upcomingCollectionView.delegate = self
            upcomingCollectionView.dataSource = self
            upcomingCollectionView.prepareCollectionView(cell: MoviePosterCell.self, width: MoviePosterCell.recommendationCellWidth, height: MoviePosterCell.movieCellHeight)
        }
    }
    
    @IBOutlet weak var genre1Label: UILabel!
    @IBOutlet weak var genre1CollectionView: UICollectionView! {
        didSet {
            genre1CollectionView.delegate = self
            genre1CollectionView.dataSource = self
            genre1CollectionView.prepareCollectionView(cell: MoviePosterCell.self, width: MoviePosterCell.recommendationCellWidth, height: MoviePosterCell.movieCellHeight)
        }
    }
    
    @IBOutlet weak var genre2Label: UILabel!
    @IBOutlet weak var genre2CollectionView: UICollectionView! {
        didSet {
            genre2CollectionView.delegate = self
            genre2CollectionView.dataSource = self
            genre2CollectionView.prepareCollectionView(cell: MoviePosterCell.self, width: MoviePosterCell.recommendationCellWidth, height: MoviePosterCell.movieCellHeight)
        }
    }
    
    @IBOutlet weak var genre3Label: UILabel!
    @IBOutlet weak var genre3CollectionView: UICollectionView! {
        didSet {
            genre3CollectionView.delegate = self
            genre3CollectionView.dataSource = self
            genre3CollectionView.prepareCollectionView(cell: MoviePosterCell.self, width: MoviePosterCell.recommendationCellWidth, height: MoviePosterCell.movieCellHeight)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    @objc func loadData(callType: NetworkCallType = .all) {
        
        switch callType {
            
        case .nowPlaying:
            if let callObject = npCallObject {
                NetworkService.getMovieList(callType: callType, callObject: callObject) { npList, maxPage in
                    
                    self.nowPlayingNetworkHandle(npList: npList, maxPage: maxPage)
                }
            }
        case .upcoming:
            if let callObject = upCallObject {
                NetworkService.getMovieList(callType: callType, callObject: callObject) { upList, maxPage in
                    
                    self.upcomingNetworkHandle(upList: upList, maxPage: maxPage)
                }
            }
        case .genre1:
            if let callObject = g1CallObject {
                NetworkService.getMovieList(callType: callType, callObject: callObject) { g1List, maxPage in
                    
                    self.genre1NetworkHandle(g1List: g1List, maxPage: maxPage)
                }
            }
        case .genre2:
            if let callObject = g2CallObject {
                NetworkService.getMovieList(callType: callType, callObject: callObject) { g2List, maxPage in
                    
                    self.genre2NetworkHandle(g2List: g2List, maxPage: maxPage)
                }
            }
        case .genre3:
            if let callObject = g3CallObject {
                NetworkService.getMovieList(callType: callType, callObject: callObject) { g3List, maxPage in
                    
                    self.genre3NetworkHandle(g3List: g3List, maxPage: maxPage)
                }
            }
            
        case .all:
            
            npCallObject = PaginationCallObject(pageNumber: npCurrentPage)
            upCallObject = PaginationCallObject(pageNumber: upCurrentPage)
            
            if let callObject = npCallObject {
                NetworkService.getMovieList(callType: .nowPlaying, callObject: callObject) { npList, maxPage in
                    self.nowPlayingNetworkHandle(npList: npList, maxPage: maxPage)
                }
            }
            
            if let callObject = upCallObject {
                NetworkService.getMovieList(callType: .upcoming, callObject: callObject) { upList, maxPage in
                    self.upcomingNetworkHandle(upList: upList, maxPage: maxPage)
                }
            }
            
            NetworkService.getAllGenres { allGenres in
                self.selectGenresHandle(genresList: allGenres)
                
                self.g1CallObject = GenreCallObject(pageNumber: self.g1CurrentPage, genreId: self.genresList[0].id ?? 0)
                self.g2CallObject = GenreCallObject(pageNumber: self.g2CurrentPage, genreId: self.genresList[1].id ?? 0)
                self.g3CallObject = GenreCallObject(pageNumber: self.g3CurrentPage, genreId: self.genresList[2].id ?? 0)

                if let callObject = self.g1CallObject {
                    NetworkService.getMovieList(callType: .genre1, callObject: callObject) { g1List, maxPage in
                        
                        self.genre1NetworkHandle(g1List: g1List, maxPage: maxPage)
                    }
                }
                
                if let callObject = self.g2CallObject {
                    NetworkService.getMovieList(callType: .genre2, callObject: callObject) { g2List, maxPage in
                        
                        self.genre2NetworkHandle(g2List: g2List, maxPage: maxPage)
                    }
                }
                
                if let callObject = self.g3CallObject {
                    NetworkService.getMovieList(callType: .genre3, callObject: callObject) { g3List, maxPage in
                        
                        self.genre3NetworkHandle(g3List: g3List, maxPage: maxPage)
                    }
                }
            }
            
        default:
            break
        }
    }

}

//MARK: - UICollectionViewDataSource

extension MainPageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.nowPlayingCollectionView:
            return nowPlayingCollectionView.updateVisibilityAndGetItemCount(list: nowPlayingList)
            
        case self.upcomingCollectionView:
            return upcomingCollectionView.updateVisibilityAndGetItemCount(list: upcomingList)
            
        case self.genre1CollectionView:
            return genre1CollectionView.updateVisibilityAndGetItemCount(list: genre1List)
            
        case self.genre2CollectionView:
            return genre2CollectionView.updateVisibilityAndGetItemCount(list: genre2List)
            
        case self.genre3CollectionView:
            return genre3CollectionView.updateVisibilityAndGetItemCount(list: genre3List)
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.getClassName(), for: indexPath) as? MoviePosterCell else {
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case self.nowPlayingCollectionView:
            if indexPath.row == nowPlayingList.count - 1, npCurrentPage < npMaxPage {
                loadData(callType: .nowPlaying)
            }

        case self.upcomingCollectionView:
            if indexPath.row == upcomingList.count - 1, upCurrentPage < upMaxPage {
                loadData(callType: .upcoming)
            }
        
        case self.genre1CollectionView:
            if indexPath.row == genre1List.count - 1, g1CurrentPage < g1MaxPage {
                loadData(callType: .genre1)
            }
            
        case self.genre2CollectionView:
            if indexPath.row == genre2List.count - 1, g2CurrentPage < g2MaxPage {
                loadData(callType: .genre2)
            }
            
        case self.genre3CollectionView:
            if indexPath.row == genre3List.count - 1, g3CurrentPage < g3MaxPage {
                loadData(callType: .genre3)
            }
            
        default:
            break
        }
    }
    
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
    
//    Getters
    
    func getGenresList() -> [Genre] {
        return self.genresList
    }
    
//    Setters
    
    func setG1LabelText(text: String) {
        self.genre1Label.text = text
    }
    
    func setG2LabelText(text: String) {
        self.genre2Label.text = text
    }
    
    func setG3LabelText(text: String) {
        self.genre3Label.text = text
    }
    
    func setNpMaxPage(maxPage: Int) {
        self.npMaxPage = maxPage
    }
    
    func setUpMaxPage(maxPage: Int) {
        self.upMaxPage = maxPage
    }
    
    func setG1MaxPage(maxPage: Int) {
        self.g1MaxPage = maxPage
    }
    
    func setG2MaxPage(maxPage: Int) {
        self.g2MaxPage = maxPage
    }
    
    func setG3MaxPage(maxPage: Int) {
        self.g3MaxPage = maxPage
    }
    
    func setGenresList(genres: [Genre]) {
        self.genresList = genres
    }
    
//    Append
    
    func appendNowPlayingList(movies: [Movie]) {
        self.nowPlayingList += movies
    }
    
    func appendUpcomingList(movies: [Movie]) {
        self.upcomingList += movies
    }
    
    func appendGenre1List(movies: [Movie]) {
        self.genre1List += movies
    }
    
    func appendGenre2List(movies: [Movie]) {
        self.genre2List += movies
    }
    
    func appendGenre3List(movies: [Movie]) {
        self.genre3List += movies
    }
    
//    Increment
    
    func incrementNpCurrent() {
        self.npCurrentPage += 1
    }
    
    func incrementUpCurrent() {
        self.upCurrentPage += 1
    }
    
    func incrementG1Current() {
        self.g1CurrentPage += 1
    }
    
    func incrementG2Current() {
        self.g2CurrentPage += 1
    }
    
    func incrementG3Current() {
        self.g3CurrentPage += 1
    }
}
