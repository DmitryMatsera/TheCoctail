//
//  CoctailsMemoryStorage.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 02.07.2022.
//

import Foundation

class LocalStorage {
    var data: [Coctail] = []
    static let shared = LocalStorage()
}

class CoctailsMemoryStorage {
    let localStorage = LocalStorage.shared
}

extension CoctailsMemoryStorage: CoctailsDatabaseManagerAbstract {
    func getAllFavoriteCoctails() -> [Coctail] {
        localStorage.data
    }
    
    func addToFavorite(coctail: Coctail) {
        localStorage.data.append(coctail)
    }
    
    func removeFromFavorite(coctail: Coctail) {
        localStorage.data.removeAll(where: { $0.name == coctail.name } )
    }
}
