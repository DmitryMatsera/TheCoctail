//
//  Coctail.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 02.07.2022.
//

import Foundation

struct Coctail {
    let name: String
    let coctailDescription: String
    let photoUrlString: String
    let instructionsUrlString: String
    
    init(responce: CurrentCoctailsDataResponce) {
        self.name = responce.strDrink
        self.coctailDescription = responce.strAlcoholic
        self.photoUrlString = responce.strDrinkThumb
        self.instructionsUrlString =  responce.strInstructions
    }
    
    init(object: CoctailObject) {
        self.name = object.name
        self.photoUrlString = object.photoUrlString
        self.coctailDescription = object.coctailDescription
        self.instructionsUrlString = object.strInstructions
    }
}
