//
//  CoctailsFavoritesPresenter.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 22.04.2022.
//

import Foundation


class CoctailsFavoritesPresenter: CoctailPresenterProtocol {
    
    var search: SearchSupportProtocol? = nil
    
    let coctailsProvider: CoctailsProvider
    let coctailOperations: CoctailsOperations
    
    init(coctailsProvider: CoctailsProvider, coctailOperations: CoctailsOperations) {
        self.coctailsProvider = coctailsProvider
        self.coctailOperations = coctailOperations
    }
    
    var coctailList: [Coctail] = [] {
        didSet {
            view?.refreshView()
        }
    }

    var view: CoctailsViewProtocol?
    
    var showFavoriteButton: Bool = false
    
    var showSearch: Bool = false
    
    var title: String = "Favorite"
    
    var numberOfCoctails: Int {
        coctailList.count
    }
    
    func loadData() {
        let allFavoriteCoctails = coctailsProvider.getAllFavoriteCoctails()
        coctailList = allFavoriteCoctails
        view?.refreshView()
    }
    
    func getCoctail(index: Int) -> Coctail {
        coctailList[index]
    }
    
    func isCoctailFavorite(coctail: Coctail) -> Bool {
        coctailsProvider.isCoctailFavorite(coctail: coctail)
    }
    
    func tapOnFavorite(index: Int) {
        let coctail = coctailList[index]
        
        let isFavorite = coctailsProvider.isCoctailFavorite(coctail: coctail)
        
        if isFavorite {
            coctailOperations.removeFromFavorite(coctail: coctail)
        } else {
            coctailOperations.addToFavorite(coctail: coctail)
        }
        loadData()
    }
    
}

