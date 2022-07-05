//
//  RequestManager.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 19.04.2022.
//

import Foundation

class RequestManager {
        
    let session: URLSession = .shared
    var task: URLSessionDataTask?
        
    func load<T: Decodable>(url: URL, response: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                guard error == nil else { return }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        task?.resume()
    }
}
