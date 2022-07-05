//
//  CoctailPresenterProtocol.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 02.07.2022.
//

import Foundation

protocol CoctailPresenterProtocol {
    var view: CoctailsViewProtocol? { get set }
    var showFavoriteButton: Bool { get set }
    var search: SearchSupportProtocol? { get }
    var title: String { get set }
    var numberOfCoctails: Int { get  }
    func loadData()
    func getCoctail(index: Int) -> Coctail
    func isCoctailFavorite(coctail: Coctail) -> Bool
    func tapOnFavorite(index: Int)
}

protocol SearchSupportProtocol {
    func search(text: String)
}
