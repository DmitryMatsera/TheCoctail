//
//  CoctailListCell.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 19.04.2022.
//

import UIKit

protocol CoctailsListDelegate: AnyObject {
    func tapOnFavorireButton(index: Int)
}

class CoctailListCell: UITableViewCell{
    
    weak var delegate: CoctailsListDelegate?
    var index: Int = 0
        
    @objc func handleMarkAsFavorite() {
        delegate?.tapOnFavorireButton(index: index)
    }

    let starButton = UIButton(type: .system)
    
    lazy var coctailImage: UIImageView = {
        let coctailImage = UIImageView()
        coctailImage.translatesAutoresizingMaskIntoConstraints = false
        coctailImage.contentMode = .scaleToFill
        coctailImage.layer.cornerRadius = 70
        coctailImage.layer.masksToBounds = true
        coctailImage.layer.borderWidth = 1
        return coctailImage
    }()
    
    lazy var coctailName: UILabel = {
        let coctailName = UILabel()
        coctailName.translatesAutoresizingMaskIntoConstraints = false
        coctailName.numberOfLines = 0
        coctailName.font = .systemFont(ofSize: 20)
        coctailName.textColor = .black
        return coctailName
    }()
    
    lazy var coctailDescription: UILabel = {
        let coctailDescription = UILabel()
        coctailDescription.translatesAutoresizingMaskIntoConstraints = false
        coctailDescription.numberOfLines = 0
        coctailDescription.font = .systemFont(ofSize: 20)
        coctailDescription.textColor = .black
        return coctailDescription
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
       
        starButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
     
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
        accessoryView = starButton
        
        contentView.addSubview(coctailImage)
        addCoctailImage()
        
        contentView.addSubview(coctailName)
        addCoctailName()
        
        contentView.addSubview(coctailDescription)
        addCoctailDescription()
        
    }
    
    func setupFavorite(isFavorite: Bool) {
        if isFavorite {
            starButton.setImage(UIImage(named: "favoriteOn"), for: .normal)
        } else {
            starButton.setImage(nil, for: .normal)
        }
        
    }
    
    func addCoctailImage() {
        
        let top = NSLayoutConstraint(item: coctailImage, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 10)
        
        let left = NSLayoutConstraint(item: coctailImage, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 10)
        
        let  height = NSLayoutConstraint(item: coctailImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 150)
        
        let  width = NSLayoutConstraint(item: coctailImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 150)
        
        let bottom = NSLayoutConstraint(item: coctailImage, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        contentView.addConstraints([top, left, height, width, bottom])
    }
    
    func addCoctailName() {
        
        let top = NSLayoutConstraint(item: coctailName, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 20)
        
        let left = NSLayoutConstraint(item: coctailImage, attribute: .right, relatedBy: .equal, toItem: coctailName, attribute: .left, multiplier: 1.0, constant: -10)
        
        let right = NSLayoutConstraint(item: coctailName, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: 0)
        
        contentView.addConstraints([top, left, right])
    }
    
    func addCoctailDescription() {
        
        let top = NSLayoutConstraint(item: coctailName, attribute: .bottom, relatedBy: .equal, toItem: coctailDescription, attribute: .top, multiplier: 1.0, constant: -5)

        let left = NSLayoutConstraint(item: coctailImage, attribute: .right, relatedBy: .equal, toItem: coctailDescription, attribute: .left, multiplier: 1.0, constant: -10)
        
        let right = NSLayoutConstraint(item: coctailDescription, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: 0)
        
        let bottom = NSLayoutConstraint(item: coctailDescription, attribute: .bottom, relatedBy: .equal, toItem: coctailDescription, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        
        contentView.addConstraints([top, left, right, bottom])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
         
    }
}
