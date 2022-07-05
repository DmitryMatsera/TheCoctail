//
//  CoctailsDetailViewController.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 19.04.2022.
//

import UIKit

class CoctailsDetailViewController: UIViewController {
    
    lazy var coctailDetailTableView = UITableView(frame: view.frame) ~> {
        $0.registerClassCell(CoctailsDetailListCell.self)
        $0.registerClassCell(CoctailPhotoListCell.self)
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = UIColor.white
        $0.rowHeight = UITableView.automaticDimension
        let refreshControl = UIRefreshControl()
    }
    
    let presenter: CoctailsDetailPresenterAbstract
    
    init(presenter: CoctailsDetailPresenterAbstract) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = presenter.title
        view.addSubview(coctailDetailTableView)
        
    }
}
    

extension CoctailsDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: CoctailPhotoListCell.self)
            let coctail = presenter.coctail
            let url = URL(string: coctail.photoUrlString)!
            cell.coctailsImage.kf.setImage(with: url)
            cell.backgroundColor = UIColor.white
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableTypedCell(for: indexPath, cellType: CoctailsDetailListCell.self)
            cell.coctailInstructions.text = presenter.instructionsUrlString
            cell.backgroundColor = UIColor.white
            cell.selectionStyle = .none
            return cell
        }
    }
}

