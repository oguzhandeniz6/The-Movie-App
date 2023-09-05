//
//  NetworkService.swift
//  Movie App
//
//  Created by oguzhan.deniz on 31.07.2023.
//

import Foundation

class NetworkService {
    
    static func getMovieList(callType: NetworkCallType, callObject: CallObject, completion: @escaping ([Movie], Int) -> Void) {
        
        switch callType {
            
        case .popularMovies:
            guard let paginationCallObject = callObject as? PaginationCallObject else {
                return
            }
            
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getPopularMoviesURL(pageNumber: paginationCallObject.pageNumber), dataType: APIMovieResults.self) { result in
                if let fetchedMovies = result.results, let maxPage = result.totalPages {
                    completion(fetchedMovies, maxPage)
                }
            }
            
        case .topRatedMovies:
            guard let paginationCallObject = callObject as? PaginationCallObject else {
                return
            }
            
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getTopRatedMoviesURL(pageNumber: paginationCallObject.pageNumber), dataType: APIMovieResults.self) { result in
                if let fetchedMovies = result.results, let maxPage = result.totalPages {
                    completion(fetchedMovies, maxPage)
                }
            }
            
        case .searchMovies:
            guard let searchCallObject = callObject as? SearchCallObject else {
                return
            }
            
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getSearchMovieURL(searchKey: searchCallObject.searchKey.percentEncode(), pageNumber: searchCallObject.pageNumber), dataType: APIMovieResults.self) { result in
                if let fetchedMovies = result.results, let maxPage = result.totalPages {
                    completion(fetchedMovies, maxPage)
                }
            }
            
        case .nowPlaying:
            guard let paginationCallObject = callObject as? PaginationCallObject else {
                return
            }
            
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getNowPlaying(pageNumber: paginationCallObject.pageNumber), dataType: APIMovieResults.self) { result in
                if let nowplayingList = result.results, let maxPage = result.totalPages {
                    completion(nowplayingList, maxPage)
                }
            }
            
        case .upcoming:
            guard let paginationCallObject = callObject as? PaginationCallObject else {
                return
            }
            
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getUpcoming(pageNumber: paginationCallObject.pageNumber), dataType: APIMovieResults.self) { result in
                if let upcomingList = result.results, let maxPage = result.totalPages {
                    completion(upcomingList, maxPage)
                }
            }
            
        case .genre1, .genre2, .genre3:
            guard let genreCallObject = callObject as? GenreCallObject else {
                return
            }
            
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getMoviesWithGenre(pageNumber: genreCallObject.pageNumber, genreid: genreCallObject.genreId), dataType: APIMovieResults.self) { result in
                if let genreList = result.results, let maxPage = result.totalPages {
                    completion(genreList, maxPage)
                }
            }
            
        case .discover:
            guard let discoverCallObject = callObject as? DiscoverCallObject else {
                return
            }
            
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getMoviesWithFilters(callObject: discoverCallObject), dataType: APIMovieResults.self) { result in
                if let movieList = result.results, let maxPage = result.totalPages {
                    completion(movieList, maxPage)
                }
            }
            
        default:
            break
        }
    }
    
    static func getPersonList(searchKey: String, pageNumber: Int, completion: @escaping ([Person], Int) -> Void) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getSearchPersonURL(searchKey: searchKey, pageNumber: pageNumber), dataType: APIPersonResults.self) { result in
            if let fetchedPersons = result.results, let maxPage = result.totalPages {
                completion(fetchedPersons, maxPage)
            }
        }
    }
    
    static func getMovie(movieID: Int, completion: @escaping (MovieDetail) -> Void) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getMovieWithCreditsAndRecommendationsURL(movieID: movieID), dataType: MovieDetail.self) { result in
            completion(result)
        }
    }
    
    static func getActorDetails(actorID: Int, completion: @escaping (Actor) -> Void) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getPersonDetailsWithMovieCreditsURL(personID: actorID), dataType: Actor.self) { result in
            completion(result)
        }
    }
    
    static func getAllGenres(completion: @escaping ([Genre]) -> Void) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getGenres(), dataType: Genres.self) { result in
            if let genresList = result.genres {
                completion(genresList)
            }
        }
    }
    
    static func getMovieReviews(movieID: Int, pageNumber: Int, completion: @escaping ([Review], Int) -> Void) {
        NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getMovieReviews(movieId: movieID, pageNumber: pageNumber), dataType: APIReviewResults.self) { result in
            if let reviewsList = result.results, let maxPage = result.totalPages {
                completion(reviewsList, maxPage)
            }
        }
    }
    
    static func clearRequests() {
        NetworkManager.shared.cancelAllRequests()
    }
    
}
