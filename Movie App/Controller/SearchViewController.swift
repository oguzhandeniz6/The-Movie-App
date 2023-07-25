//
//  SearchViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 25.07.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var currentPage = 1
    private var totalPages = 1

    private var searchResults = APIResults()
    private var movies: [Results] = []
    private var searchKey: String = ""
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTextLabel: UITextField!
    
    func prepareTableView() {
        searchTableView.dataSource = self
//        searchTableView.delegate = self
        searchTableView.register(cellName: MovieCell.getClassName())
        
//        Prepare Pagination
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        searchTableView.refreshControl = refreshControl
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextLabel.delegate = self
        prepareTableView()
    }
    
    func networkCall(_ movieName: String) {
        NetworkManager.shared.fetchDataObject(
            urlString: NetworkConstants.shared.getSearch(searchKey: movieName, pageNumber: currentPage),
            dataType: APIResults.self, completion: { result in
                if let fetchedMovies = result.results, let maxPage = result.total_pages {
                    self.movies += fetchedMovies
                    self.totalPages = maxPage
//                    Increment current page by 1
                    self.currentPage += 1
                }
                self.searchTableView.reloadData()
            })
    }
    
    @objc func loadData() {
//        Make network call
        networkCall(searchKey)
        
        searchTableView.refreshControl?.endRefreshing()
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
//        Clear the TableView
        movies.removeAll()
        currentPage = 1
//        If textLabel is not empty
        if let movieName = searchTextLabel.text {
            networkCall(movieName)
            searchTextLabel.endEditing(true)
        }
    }
    

}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.getClassName(), for: indexPath) as? MovieCell else {
            return MovieCell()
        }
        
        let movie = movies[indexPath.row]
        movieCell.fillCell(movie)
        
        return movieCell
    }
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
}
