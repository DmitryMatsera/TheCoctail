//
//  CoctailPhotoListCell.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 05.07.2022.
//

import UIKit

class CoctailPhotoListCell: UITableViewCell{
    
    let gradientLayer = CAGradientLayer()
    
    lazy var coctailsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 60
        image.layer.masksToBounds = true
        image.layer.borderWidth = 1
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: frame.size)
        gradient.colors = [UIColor.green.cgColor, UIColor.red.cgColor]
        image.layer.addSublayer(gradientLayer)
        return image
    }()
    
    lazy var coctailsDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(coctailsImage)
        addCoctailImage()
        
    }
    
    func addCoctailImage(){
        
        let top = NSLayoutConstraint(item: coctailsImage, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 5)
        
        let left = NSLayoutConstraint(item: coctailsImage, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 10)
        
        let right = NSLayoutConstraint(item: coctailsImage, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -10)
        
        let  height = NSLayoutConstraint(item: coctailsImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 300)
        
        let  width = NSLayoutConstraint(item: coctailsImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 370)
        
        let bottom = NSLayoutConstraint(item: coctailsImage, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        contentView.addConstraints([top, left, right, height, width, bottom])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
