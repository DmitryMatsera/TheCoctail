//
//  CoctailsDatabaseManager.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 02.07.2022.
//

import Foundation

protocol CoctailsDatabaseManagerAbstract {
    func getAllFavoriteCoctails() -> [Coctail]
    func addToFavorite(coctail: Coctail)
    func removeFromFavorite(coctail: Coctail)
}
