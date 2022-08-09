//
//  NetworkManager.swift
//  Network Project
//
//  Created by Алия Тлеген on 09.08.2022.
//

import Foundation

enum ObtainPostResult {
    case success(posts: [Post])
    case failure(error: Error)
}

class NetworkManager {
    
    // MARK: - Public Variables -
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    // MARK: - Actions -
    
    func obtainPosts(completion: @escaping (ObtainPostResult) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return
        }
        
        session.dataTask(with: url) { [weak self](data, response, error)  in
            
            var result:  ObtainPostResult
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard let strongSelf = self else {
                result = .failure(error: error!)
                return
            }
            
            if error == nil, let parseData = data {
                guard let posts = try? strongSelf.decoder.decode([Post].self, from: parseData) else {
                    result = .failure(error: error!)
                    return
                }
                    result = .success(posts: posts)
                } else {
                    result = .failure(error: error!)
            }
        }.resume()
    }
}
