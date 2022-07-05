//
//  CurrentCoctailsData.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 19.04.2022.
//

import Foundation


struct ImagesSecionsDataResponce: Decodable {
    let drinks: [CurrentCoctailsDataResponce]?
}

struct CurrentCoctailsDataResponce: Decodable {
    let strDrink: String
    let strCategory: String
    let strAlcoholic: String
    let strDrinkThumb: String
    let strInstructions: String
}
