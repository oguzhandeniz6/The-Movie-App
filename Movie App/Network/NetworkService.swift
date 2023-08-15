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
    
    static func getMovie(movieID: Int, completion: @escaping (MovieDetail) -> Void) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getMovieURL(movieID: movieID), dataType: MovieDetail.self) { result in
            completion(result)
        }
    }
    
    static func getCast(movieID: Int, completion: @escaping ([Cast]) -> Void) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getMovieCreditsURL(movieID: movieID), dataType: Credits.self) { result in
            if let credits = result.cast {
                completion(credits)
            }
        }
    }
    
    static func getActorDetails(actorID: Int, completion: @escaping (Actor) -> Void) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getPersonDetailsURL(personID: actorID), dataType: Actor.self) { result in
            completion(result)
        }
    }
    
    static func selectGenres(completion: @escaping ([Genre]) -> Void) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getGenres(), dataType: Genres.self) { result in
            if let genresList = result.genres {
                completion(genresList)
            }
        }
    }
    
    static func clearRequests() {
        NetworkManager.shared.cancelAllRequests()
    }
    
}
