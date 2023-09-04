//
//  NetworkService.swift
//  Movie App
//
//  Created by oguzhan.deniz on 31.07.2023.
//

import Foundation

class NetworkService {
    
    static func getMovieList(callType: NetworkCallType, pageNumber: Int = 0, movieId: Int = -1, searchKey: String = "", personId: Int = -1, genreId: Int = -1, callObject: DiscoverCallObject? = nil, completion: @escaping ([Movie], Int) -> Void) {
        
        switch callType {
            
        case .popularMovies:
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getPopularMoviesURL(pageNumber: pageNumber), dataType: APIMovieResults.self) { result in
                if let fetchedMovies = result.results, let maxPage = result.totalPages {
                    completion(fetchedMovies, maxPage)
                }
            }
            
        case .topRatedMovies:
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getTopRatedMoviesURL(pageNumber: pageNumber), dataType: APIMovieResults.self) { result in
                if let fetchedMovies = result.results, let maxPage = result.totalPages {
                    completion(fetchedMovies, maxPage)
                }
            }
            
        case .searchMovies:
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getSearchMovieURL(searchKey: searchKey, pageNumber: pageNumber), dataType: APIMovieResults.self) { result in
                if let fetchedMovies = result.results, let maxPage = result.totalPages {
                    completion(fetchedMovies, maxPage)
                }
            }
            
        case .nowPlaying:
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getNowPlaying(pageNumber: pageNumber), dataType: APIMovieResults.self) { result in
                if let nowplayingList = result.results, let maxPage = result.totalPages {
                    completion(nowplayingList, maxPage)
                }
            }
            
        case .upcoming:
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getUpcoming(pageNumber: pageNumber), dataType: APIMovieResults.self) { result in
                if let upcomingList = result.results, let maxPage = result.totalPages {
                    completion(upcomingList, maxPage)
                }
            }
            
        case .genre1, .genre2, .genre3:
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getMoviesWithGenre(pageNumber: pageNumber, genreid: genreId), dataType: APIMovieResults.self) { result in
                if let genreList = result.results, let maxPage = result.totalPages {
                    completion(genreList, maxPage)
                }
            }
            
        case .discover:
            guard let discoverCallObject = callObject else {
                return
            }
            
            NetworkManager.shared.fetchDataObject(urlString: NetworkConstants.getMoviesWithFilters(pageNumber: pageNumber, callObject: discoverCallObject), dataType: APIMovieResults.self) { result in
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
