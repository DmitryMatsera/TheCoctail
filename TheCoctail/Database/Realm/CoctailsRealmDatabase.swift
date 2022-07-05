//
//  CoctailsRealmDatabase.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 02.07.2022.
//

import Foundation
import RealmSwift

class CoctailsRealmDatabase {
    let realm = try! Realm()
}

extension CoctailsRealmDatabase: CoctailsDatabaseManagerAbstract {
    
    func getAllFavoriteCoctails() -> [Coctail] {
        let favoriteEntities = realm.objects(CoctailObject.self)
        return favoriteEntities.compactMap { Coctail(object: $0) }
    }
    
    func addToFavorite(coctail: Coctail) {
        try! realm.write {
            let object = CoctailObject()
            object.name = coctail.name
            object.coctailDescription = coctail.coctailDescription
            object.photoUrlString = coctail.photoUrlString
            realm.add(object)
        }
    }
    
    func removeFromFavorite(coctail: Coctail) {
        let favoriteEntities = realm.objects(CoctailObject.self)
        try! realm.write {
            if let object = favoriteEntities.filter({ $0.name == coctail.name }).first {
                self.realm.delete(object)
            }
        }
    }
}
