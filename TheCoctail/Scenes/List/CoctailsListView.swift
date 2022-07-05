//
//  CoctailsListView.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 02.07.2022.
//

import Foundation
import UIKit

class CoctailsListView: UIView {
    
    lazy var coctailListTableView: UITableView = {
        let coctailListTableView = UITableView(frame: frame)
        coctailListTableView.register(CoctailListCell.self, forCellReuseIdentifier: "CoctailListCell")
        coctailListTableView.rowHeight = UITableView.automaticDimension
        return coctailListTableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        addSubview(coctailListTableView)
    }
    
}
