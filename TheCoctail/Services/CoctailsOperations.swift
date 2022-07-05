//
//  CoctailsOperations.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 02.07.2022.
//

import Foundation

class CoctailsOperations {
    private let database: CoctailsDatabaseManagerAbstract
    
    init(database: CoctailsDatabaseManagerAbstract) {
        self.database = database
    }

    func addToFavorite(coctail: Coctail) {
        database.addToFavorite(coctail: coctail)
    }
    
    func removeFromFavorite(coctail: Coctail) {
        database.removeFromFavorite(coctail: coctail)
    }
}
