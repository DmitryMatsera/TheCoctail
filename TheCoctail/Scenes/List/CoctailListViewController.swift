//
//  ViewController.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 19.04.2022.
//

import UIKit
import Kingfisher
import RealmSwift

protocol CoctailsViewProtocol: AnyObject {
    
    func refreshView()
}

class CoctailListViewController: UIViewController {
    
    lazy var presenter: CoctailPresenterProtocol = {
        let database = CoctailsRealmDatabase()
        let coctailOperations = CoctailsOperations(database: database)
        let coctailsProvider = CoctailsProvider(requestManager: RequestManager(), database: database)
        return CoctailsListPresenter(coctailsProvider: coctailsProvider,coctailOperations: coctailOperations,  showFavoriteButton: true, title: "Coctails", showSearch: true)
    }()
    
    var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.tintColor = .lightGray
        return rc
    }()
    
    let rootView = CoctailsListView(frame: UIScreen.main.bounds)
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        rootView.coctailListTableView.refreshControl = refreshControl
        rootView.coctailListTableView.delegate = self
        rootView.coctailListTableView.dataSource = self
        rootView.coctailListTableView.separatorStyle = .none
        rootView.coctailListTableView.backgroundColor = UIColor.white
        
        presenter.view = self
        
        if presenter.showFavoriteButton {
            
            let favBtn = UIButton(type: .custom)
            favBtn.setImage(UIImage(named:"favorite"), for: .normal)
            favBtn.addTarget(self, action: #selector(openFavoritesAction), for: .touchUpInside)
            
            
            let menuBarItem = UIBarButtonItem(customView: favBtn)
            let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
            currWidth?.isActive = true
            let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
            currHeight?.isActive = true
            self.navigationItem.rightBarButtonItem = menuBarItem
            menuBarItem.tintColor = .white

        }
        if presenter.search != nil {
            addSearch()
        }
        navigationItem.title = presenter.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadData()
    }
    
    @objc func refresh() {
        presenter.loadData()
    }
    
    private func addSearch() {
        let searching = UISearchController(searchResultsController: nil)
        searching.searchResultsUpdater = self
        searching.obscuresBackgroundDuringPresentation = false
        searching.searchBar.placeholder = "Click to search for a cocktail...."
        navigationItem.searchController = searching
    }
    
    @objc func openFavoritesAction() {
        let viewController = CoctailListViewController()
        let database = CoctailsRealmDatabase()
        let coctailOperations = CoctailsOperations(database: database)
        let coctailsProvider = CoctailsProvider(requestManager: RequestManager(), database: database)
        viewController.presenter = CoctailsFavoritesPresenter(coctailsProvider: coctailsProvider, coctailOperations: coctailOperations)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openDetail(coctail: Coctail) {
        let presenter = CoctailsDetailPresenter(coctail: coctail)
        let coctailsInfo = CoctailsDetailViewController(presenter: presenter)
        navigationController?.pushViewController(coctailsInfo, animated: true)
    }
}

extension CoctailListViewController : UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCoctails
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoctailListCell", for: indexPath) as! CoctailListCell
        let coctail = presenter.getCoctail(index: indexPath.row)
        cell.coctailName.text = coctail.name
        cell.coctailDescription.text = coctail.coctailDescription
        let url = URL(string: coctail.photoUrlString)!
        cell.coctailImage.kf.setImage(with: url)
        cell.index = indexPath.row
        cell.delegate = self
        let isFavorite = presenter.isCoctailFavorite(coctail: coctail)
        cell.setupFavorite(isFavorite: isFavorite)
        cell.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coctail = presenter.getCoctail(index:indexPath.row)
        openDetail(coctail: coctail)
    }
}

extension CoctailListViewController: CoctailsListDelegate {
    func tapOnFavorireButton(index: Int) {
        presenter.tapOnFavorite(index: index)
    }
}

extension CoctailListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            presenter.loadData()
        }
        guard let text = searchController.searchBar.text, text.count > 3 else { return }
        print(text)
        presenter.search?.search(text: text)
    }
    
}

extension CoctailListViewController: CoctailsViewProtocol {
    func refreshView() {
        rootView.coctailListTableView.reloadData()
        refreshControl.endRefreshing()
    }
}
