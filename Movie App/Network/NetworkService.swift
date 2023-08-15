//
//  NetworkService.swift
//  Movie App
//
//  Created by oguzhan.deniz on 31.07.2023.
//

import Foundation

class NetworkService {
//    closure kullanarak viewcontroller ile coupling i azaltılabilir
    
    static func getMovieList(callType: NetworkCallType, pageNumber: Int = 0, movieId: Int = -1, genreId: Int = -1, completion: @escaping ([Movie], Int) -> Void) {
        
        switch callType {
            
        case .popularMovies:
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getPopularMoviesURL(pageNumber: pageNumber), dataType: APIResults.self) { result in
                if let fetchedMovies = result.results, let maxPage = result.total_pages {
                    completion(fetchedMovies, maxPage)
                }
            }
            
        case .searchMovies:
            print("b")
            
        case .recommendationMovies:
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getMovieRecommendationsURL(movieID: movieId), dataType: APIResults.self) { result in
                if let fetchedMovies = result.results {
                    completion(fetchedMovies, pageNumber)
                }
            }
            
        case .nowPlaying:
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getNowPlaying(pageNumber: pageNumber), dataType: APIResults.self) { result in
                if let nowplayingList = result.results, let maxPage = result.total_pages {
                    completion(nowplayingList, maxPage)
                }
            }
            
        case .upcoming:
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getUpcoming(pageNumber: pageNumber), dataType: APIResults.self) { result in
                if let upcomingList = result.results, let maxPage = result.total_pages {
                    completion(upcomingList, maxPage)
                }
            }
            
        case .genre1, .genre2, .genre3:
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getDiscover(pageNumber: pageNumber, genreid: genreId), dataType: APIResults.self) { result in
                if let genreList = result.results, let maxPage = result.total_pages {
                    completion(genreList, maxPage)
                }
            }

            
        default:
            break
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
    
    static func getGenres(mainVC: MainPageViewController) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getGenres(), dataType: Genres.self) { result in
            if var genresList = result.genres {
                genresList.getRandomNElement(numOfElms: 3)
                mainVC.setGenresList(genres: genresList)
                
                for i in 0 ..< genresList.count {
                    NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getDiscover(pageNumber: 1, genreid: genresList[i].id ?? 0), dataType: APIResults.self) { result in
                        if let genreMovieList = result.results {
                            switch i {
                            case 0:
                                mainVC.genre1Label.text = genresList[i].name ?? ""
                                mainVC.appendGenre1List(movies: genreMovieList)
                                mainVC.setG1MaxPage(maxPage: result.total_pages ?? 0)
                                mainVC.genre1CollectionView.reloadData()
                            case 1:
                                mainVC.genre2Label.text = genresList[i].name ?? ""
                                mainVC.appendGenre2List(movies: genreMovieList)
                                mainVC.setG2MaxPage(maxPage: result.total_pages ?? 0)
                                mainVC.genre2CollectionView.reloadData()
                            case 2:
                                mainVC.genre3Label.text = genresList[i].name ?? ""
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
    
    static func clearRequests() {
        NetworkManager.shared.cancelAllRequests()
    }
    
}
