//
//  CoctailsProvider.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 02.07.2022.
//

import Foundation

class CoctailsProvider {
    
    private let requestManager: RequestManager
    private let database: CoctailsDatabaseManagerAbstract
    
    init(requestManager:RequestManager, database: CoctailsDatabaseManagerAbstract) {
        self.database = database
        self.requestManager = requestManager
    }
   
    private let baseUrl = "https://www.thecocktaildb.com/api/json/v1/1"
    
    func getCoctailsList(completion: @escaping (Result<[Coctail], Error>) -> Void) {
        var coctails: [Coctail] = []
        let dispatchGroup = DispatchGroup()
        let numberCoctails = 10
        for _ in 0..<numberCoctails {
            dispatchGroup.enter()
            getRandomCoctail { result in
                if case .success(let responce) = result, let random = responce.first {
                    coctails.append(random)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if coctails.isEmpty {
                let error = NSError("Не удалось получить список коктелей", -1)
                completion(.failure(error))
            } else {
                completion(.success(coctails))
            }
        }
    }
    
    func getRandomCoctail(completion: @escaping (Result<[Coctail], Error>) -> Void) {
        let urlString = baseUrl + "/random.php"
        guard let url = URL(string: urlString) else { return }
        requestManager.load(url: url, response: ImagesSecionsDataResponce.self) { [weak self] data in
            guard let self = self else { return }
            self.handle(data: data, completion: completion)
        }
    }
    
    func searchData(data: String, completion: @escaping (Result<[Coctail], Error>) -> Void) {
        let urlString = baseUrl + "/search.php?s=\(data)"
        guard let url = URL(string: urlString) else { return }
        requestManager.load(url: url, response: ImagesSecionsDataResponce.self) { [weak self] data in
            guard let self = self else { return }
            self.handle(data: data, completion: completion)
        }
    }
    
    func handle(data: Result<ImagesSecionsDataResponce, Error>, completion: @escaping (Result<[Coctail], Error>) -> Void) {
        switch data {
        case .success(let responce):
            let coctails = responce.drinks?.compactMap { Coctail(responce: $0) } ?? []
            completion(.success(coctails))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func getAllFavoriteCoctails() -> [Coctail] {
        database.getAllFavoriteCoctails()
    }
    
    func isCoctailFavorite(coctail: Coctail) -> Bool {
        let allFavoriteCoctails = database.getAllFavoriteCoctails()
        return allFavoriteCoctails.contains(where: {$0.name == coctail.name} )
    }
}
