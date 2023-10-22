//
//  FavoritesViewController.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 21.10.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private var savedNewsArray: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Favorites"
        
        setupTableView()

        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }

    //MARK: - Functions
    private func updateUI() {
        visibleTabBar(isVisible: true)
        savedNewsArray = FavoriteNewsManager.shared.getFavoriteNews()
        tableView.reloadData()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoritesCell", bundle: nil), forCellReuseIdentifier: "FavoritesCell")
        tableView.separatorColor = .clear
        tableView.reloadData()
    }
}

//MARK: - TableView Delegates
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedNewsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as? FavoritesCell else { fatalError("FavoritesCell not found") }
        let news = savedNewsArray[indexPath.row]
        cell.configureCell(with: news)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = savedNewsArray[indexPath.row]
        self.navigationController?.pushViewController(NewsDetailBuilder.build(item: news), animated: true)
    }
}
