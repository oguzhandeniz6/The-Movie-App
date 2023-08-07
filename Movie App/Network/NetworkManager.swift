//
//  NetworkManager.swift
//  Movie App
//
//  Created by oguzhan.deniz on 24.07.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared: NetworkManager = NetworkManager()
    
    func fetchDataObject <T: Codable> (urlString url: URL, dataType type: T.Type, completion: @escaping (T) -> Void){
        
        AF.request(url, method: .get).responseDecodable(of: T.self) { response in
            
            switch response.result {
            case let .success(data):
                completion(data)
            case let .failure(error):
                
                switch error {
                case .invalidURL(let url):
                    print("Invalid URL: \(url) - \(error.localizedDescription)")
                case .parameterEncodingFailed(let reason):
                    print("Parameter encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .multipartEncodingFailed(let reason):
                    print("Multipart encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .responseValidationFailed(let reason):
                    print("Response validation failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                    
                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        print("Downloaded file could not be read")
                    case .missingContentType(let acceptableContentTypes):
                        print("Content Type Missing: \(acceptableContentTypes)")
                    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                        print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                    case .unacceptableStatusCode(let code):
                        print("Response status code was unacceptable: \(code)")
                    default:
                        print("Unknown error: \(error)")
                    }
                case .responseSerializationFailed(let reason):
                    print("Response serialization failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                default:
                    print("Unknown error: \(error)")
                }

            }
        }
    }
    
    func cancelAllRequests() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        })
    }
}
