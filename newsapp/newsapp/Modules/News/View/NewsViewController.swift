//
//  ViewController.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import UIKit

final class NewsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // View Model
    var viewModel: NewsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()

        self.navigationItem.title = "News App"

        // viewModel
        self.viewModel.delegate = self

        // searchbar
        self.searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        visibleTabBar(isVisible: true)
    }

    func registerTableView() {
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - Helpers
private extension NewsViewController {

    @objc func fetchMedia(_ sender: UISearchBar) {
        guard let searchTerm = sender.text else { return }
        self.viewModel.searchService(with: searchTerm, page: 1)
    }
}

// MARK: - UISearchBarDelegate
extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(fetchMedia(_:)), object: searchBar)
            perform(#selector(fetchMedia(_:)), with: searchBar, afterDelay: 0.75)
        } else {
            self.tableView.reloadData()
        }
    }
}

// MARK: NewsViewModelDelegate
extension NewsViewController: NewsViewModelDelegate {

    func successSearchService() {
        self.tableView.reloadData()
    }

    func failSearchService(error: ApiError) {
        AlertManager.shared.showAlert(with: error)
    }
}

// MARK: UITableViewDataSource & UITableViewDelegate
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.newsNumberOfItemsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else { fatalError("NewsCell not found") }

        cell.configureCell(with: self.viewModel.newsCellForItemAt(index: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(NewsDetailBuilder.build(item: self.viewModel.newsDidSelectItemAt(indexPath: indexPath)), animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let searchText = searchBar.searchTextField.text, searchText.count > 2,
            indexPath.row == self.viewModel.news.count - 1 else { return }

        self.viewModel.getSearchServiceWithPagination(term: searchText) {
            self.scrollToTopOfTableView()
        }
    }

    func scrollToTopOfTableView() {
        let indexPath = IndexPath(row: 0, section: 0) // İlk satırın indeksi
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
}
