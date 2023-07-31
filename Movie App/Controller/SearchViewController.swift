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
        searchTableView.delegate = self
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
    
    @objc func loadData() {
//        Make network call
        NetworkService.getSearchResults(pageNumber: currentPage, searchKey: self.searchKey, searchVC: self)
        
        searchTableView.refreshControl?.endRefreshing()
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
//        Scroll back to top and clear the TableView
        if !movies.isEmpty {
            searchTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: false)
            movies.removeAll()
            searchTableView.reloadData()
        }
        currentPage = 1
        
        searchKey = searchTextLabel.text ?? ""
        loadData()
        searchTextLabel.endEditing(true)
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

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1, currentPage < totalPages {
            loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
            
            nextVC.movieID = movies[indexPath.row].id ?? 0
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
    
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
}

//MARK: - SearchViewController Extension

extension SearchViewController {
    
    func appendMovies(newMovies: [Results]) {
        self.movies += newMovies
    }
    
    func setTotalPages(maxPage: Int) {
        self.totalPages = maxPage
    }
    
    func incrementCurrentPage() {
        self.currentPage += 1
    }
    
}
