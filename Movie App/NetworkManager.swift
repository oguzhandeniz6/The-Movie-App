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
                print(error)
            }
        }
    }
}
