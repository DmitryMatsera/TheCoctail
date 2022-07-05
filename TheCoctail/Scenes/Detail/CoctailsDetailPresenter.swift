//
//  CoctailsDetailPresenter.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 02.07.2022.
//

import Foundation

protocol CoctailsDetailPresenterAbstract {
    var title: String { get }
    var coctailDescription: String { get }
    var photoUrlString: String { get }
    var instructionsUrlString: String { get }
    
    
    var coctail: Coctail { get }
}

class CoctailsDetailPresenter: CoctailsDetailPresenterAbstract {
    
    var title: String {
        coctail.name
    }
    
    var coctailDescription: String {
        coctail.coctailDescription
    }
    
    var photoUrlString: String{
        coctail.photoUrlString
    }
    
    var instructionsUrlString: String{
        coctail.instructionsUrlString
    }
    
    var coctail: Coctail
 
    init(coctail: Coctail) {
        self.coctail = coctail
    }
}
