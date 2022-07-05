//
//  CoctailsListPresenter.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 22.04.2022.
//

import Foundation

class CoctailsListPresenter: CoctailPresenterProtocol {
    var search: SearchSupportProtocol? {
        return self
    }
    
    weak var view: CoctailsViewProtocol?
    
    let coctailsProvider: CoctailsProvider
    let coctailOperations: CoctailsOperations
    var coctailList: [Coctail] = [] {
        didSet {
            view?.refreshView()
        }
    }
    
    var showFavoriteButton: Bool
    var title: String
    var showSearch: Bool
    
    init(coctailsProvider: CoctailsProvider, coctailOperations: CoctailsOperations, showFavoriteButton: Bool, title: String, showSearch: Bool) {
        self.coctailsProvider = coctailsProvider
        self.coctailOperations = coctailOperations
        self.showFavoriteButton = showFavoriteButton
        self.title = title
        self.showSearch = showSearch
    }
        
    func loadData() {
        coctailsProvider.getCoctailsList { result in
            switch result {
            case .success(let data):
                self.coctailList = data
            case .failure(let erorr):
                print(erorr)
            }
        }
    }
}

extension CoctailsListPresenter: SearchSupportProtocol {
    func search(text: String) {
        coctailsProvider.searchData(data: text) { result in
            switch result {
            case .success(let data):
                self.coctailList = data
            case .failure(let erorr):
                print(erorr)
            }
        }
    }

    func isCoctailFavorite(coctail: Coctail) -> Bool {
        let allFavoriteCoctails = coctailsProvider.getAllFavoriteCoctails()
        return allFavoriteCoctails.contains(where: {$0.name == coctail.name} )
    }
        
    func tapOnFavorite(index: Int) {
        let coctail = coctailList[index]
        
        let isFavorite = isCoctailFavorite(coctail: coctail)
        
        if isFavorite {
            coctailOperations.removeFromFavorite(coctail: coctail)
        } else {
            coctailOperations.addToFavorite(coctail: coctail)
        }
        view?.refreshView()
    }
    
    func getCoctail(index: Int) -> Coctail {
        coctailList[index]
    }
    
    var numberOfCoctails: Int {
        coctailList.count
    }
}

