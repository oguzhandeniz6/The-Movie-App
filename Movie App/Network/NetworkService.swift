//
//  NetworkService.swift
//  Movie App
//
//  Created by oguzhan.deniz on 31.07.2023.
//

import Foundation

class NetworkService {
    
    static func getPopularMovies(pageNumber: Int, popularVC: PopularMoviesViewController) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getPopularMoviesURL(pageNumber: pageNumber), dataType: APIResults.self) { result in
            if let fetchedMovies = result.results, let maxPage = result.total_pages {
                popularVC.appendMovies(newMovies: fetchedMovies)
                popularVC.setTotalPages(maxPage: maxPage)
                popularVC.incrementCurrentPage()
                popularVC.moviesTableView.reloadData()
            }
        }
    }
    
    static func getSearchResults(pageNumber: Int, searchKey: String,searchVC: SearchViewController) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getSearchURL(searchKey: searchKey, pageNumber: pageNumber), dataType: APIResults.self) { result in
            if let fetchedMovies = result.results, let maxPage = result.total_pages {
                searchVC.appendMovies(newMovies: fetchedMovies)
                searchVC.setTotalPages(maxPage: maxPage)
                searchVC.searchTableView.reloadData()
            }
        }
    }
    
    static func getMovie(movieID: Int, mdetailVC: MovieDetailViewController) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getMovieURL(movieID: movieID), dataType: MovieDetail.self) { result in
            mdetailVC.preparePage(movieDetail: result)
        }
    }
    
    static func getCast(movieID: Int, mdetailVC: MovieDetailViewController) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getMovieCreditsURL(movieID: movieID), dataType: Credits.self) { result in
            if let credits = result.cast {
                mdetailVC.setCast(cast: credits)
                mdetailVC.castCollectionView.reloadData()
            }
        }
    }
    
    static func getRecommendations(movieID: Int, mdetailVC: MovieDetailViewController) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getMovieRecommendationsURL(movieID: movieID), dataType: APIResults.self) { result in
            if let fetchedMovies = result.results {
                mdetailVC.setRecommendations(recommendations: fetchedMovies)
                mdetailVC.recommendationsCollectionView.reloadData()
            }
        }
    }
    
    static func getActorDetails(actorID: Int, castVC: CastViewController) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getPersonDetailsURL(personID: actorID), dataType: Actor.self) { result in
            castVC.preparePage(actor: result)
        }
    }
    
    static func getNowPlayingMovies(pageNumber:Int, mainVC: MainPageViewController) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getNowPlaying(pageNumber: pageNumber), dataType: APIResults.self) { result in
            if let nowplayingList = result.results {
                mainVC.appendNowPlayingList(movies: nowplayingList)
                mainVC.setNpMaxPage(maxPage: result.total_pages ?? 0)
                mainVC.nowPlayingCollectionView.reloadData()
            }
        }
    }
    
    static func getUpcomingMovies(pageNumber: Int, mainVC: MainPageViewController) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getUpcoming(pageNumber: pageNumber), dataType: APIResults.self) { result in
            if let upcomingList = result.results {
                mainVC.appendUpcomingList(movies: upcomingList)
                mainVC.setUpMaxPage(maxPage: result.total_pages ?? 0)
                mainVC.upcomingCollectionView.reloadData()
            }
        }
    }
    
    static func getGenres(mainVC: MainPageViewController) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getGenres(), dataType: Genres.self) { result in
            if let genresList = result.genres {
                mainVC.setGenresList(genres: genresList)
                
                let randomGenresList = Utilities.getRandomNElement(source: genresList, numOfElms: 3)
                mainVC.setChosenGenres(genres: randomGenresList)
                
                for i in 0 ..< randomGenresList.count {
                    NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getDiscover(pageNumber: 1, genreid: randomGenresList[i].id ?? 0), dataType: APIResults.self) { result in
                        if let genreMovieList = result.results {
                            switch i {
                            case 0:
                                mainVC.genre1Label.text = randomGenresList[i].name ?? ""
                                mainVC.appendGenre1List(movies: genreMovieList)
                                mainVC.setG1MaxPage(maxPage: result.total_pages ?? 0)
                                mainVC.genre1CollectionView.reloadData()
                            case 1:
                                mainVC.genre2Label.text = randomGenresList[i].name ?? ""
                                mainVC.appendGenre2List(movies: genreMovieList)
                                mainVC.setG2MaxPage(maxPage: result.total_pages ?? 0)
                                mainVC.genre2CollectionView.reloadData()
                            case 2:
                                mainVC.genre3Label.text = randomGenresList[i].name ?? ""
                                mainVC.appendGenre3List(movies: genreMovieList)
                                mainVC.setG3MaxPage(maxPage: result.total_pages ?? 0)
                                mainVC.genre3CollectionView.reloadData()
                            default:
                                break
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func getGenreMovies(pageNumber: Int, mainVC: MainPageViewController, genre: Genre) {
        
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getDiscover(pageNumber: pageNumber, genreid: genre.id ?? 0), dataType: APIResults.self) { result in
            
            if let genreMovieList = result.results {
                switch genre {
                case mainVC.getChosenGenres()[0]:
                    mainVC.appendGenre1List(movies: genreMovieList)
                    mainVC.genre1CollectionView.reloadData()
                case mainVC.getChosenGenres()[1]:
                    mainVC.appendGenre2List(movies: genreMovieList)
                    mainVC.genre2CollectionView.reloadData()
                case mainVC.getChosenGenres()[2]:
                    mainVC.appendGenre3List(movies: genreMovieList)
                    mainVC.genre3CollectionView.reloadData()
                default:
                    break
                }
            }
        }
    }
    
    static func clearRequests() {
        NetworkManager.shared.cancelAllRequests()
    }
    
}
