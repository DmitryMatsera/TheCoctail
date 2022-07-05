//
//  CoctailsDetailListCell.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 19.04.2022.
//

import UIKit

class CoctailsDetailListCell: UITableViewCell{
   
    lazy var coctailInstructions: UILabel = {
        let coctailInstructions = UILabel()
        coctailInstructions.translatesAutoresizingMaskIntoConstraints = false
        coctailInstructions.font = .systemFont(ofSize: 18)
        coctailInstructions.numberOfLines = 0
        coctailInstructions.textColor = .black
        return coctailInstructions
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(coctailInstructions)
        addCoctailDescription()
        
    }
    
    func addCoctailDescription() {
        let padding: CGFloat = 15
        
        let topDescription = NSLayoutConstraint(item: coctailInstructions, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 10)
        
        let leftDescription = NSLayoutConstraint(item: coctailInstructions, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: padding)
        
        let rightDescription = NSLayoutConstraint(item: coctailInstructions, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -padding)
        
        let bottomDescription = NSLayoutConstraint(item: coctailInstructions, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        contentView.addConstraints([topDescription, leftDescription, rightDescription, bottomDescription])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
