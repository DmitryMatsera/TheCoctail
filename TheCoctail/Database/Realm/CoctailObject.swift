//
//  CoctailObject.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 22.04.2022.
//

import Foundation
import RealmSwift

class CoctailObject: Object {
    @objc dynamic var name = ""
    @objc dynamic var coctailDescription: String = ""
    @objc dynamic var photoUrlString: String = ""
    @objc dynamic var strInstructions: String = ""
}

