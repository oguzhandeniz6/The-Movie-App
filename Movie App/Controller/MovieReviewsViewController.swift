//
//  MovieReviewsViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 22.08.2023.
//

import UIKit

class MovieReviewsViewController: UIViewController {
    
    var movieID: Int = 0
    
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var reviewList: [Review] = []
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setTitle(LocalizationHelper.backName.localizeString(), for: .normal)
            
            backButton.layer.cornerRadius = UIConstants.buttonCornerRadius
        }
    }
    
    @IBOutlet weak var reviewsTableView: UITableView! {
        didSet {
            prepareTableView()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @objc func loadData() {
        NetworkService.getMovieReviews(movieID: movieID, pageNumber: currentPage) { reviews, maxPage in
            self.reviewsNetworkHandle(reviews: reviews, maxPage: maxPage)
        }
    }

}

//MARK: - UITableViewDataSource

extension MovieReviewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.getClassName(), for: indexPath) as? ReviewCell else {
            return ReviewCell()
        }
        
        let review = reviewList[indexPath.row]
        reviewCell.fillCell(review)
        
        return reviewCell
    }
}

//MARK: - UITableViewDelegate

extension MovieReviewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == reviewList.count - 1, currentPage <= totalPages {
            loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = reviewList[indexPath.row].url?.toURL() {
            UIApplication.shared.open(url)
        }
    }
}

//MARK: - MovieReviewsViewController Extension

extension MovieReviewsViewController {
    
    func appendMovies(newMovies: [Review]) {
        self.reviewList += newMovies
    }
    
    func setTotalPages(maxPage: Int) {
        self.totalPages = maxPage
    }
    
    func incrementCurrentPage() {
        self.currentPage += 1
    }
    
    private func prepareTableView() {
        reviewsTableView.dataSource = self
        reviewsTableView.delegate = self
        reviewsTableView.register(cell: ReviewCell.self)
        
//        Prepare Pagination
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        reviewsTableView.refreshControl = refreshControl
    }
    
    private func reviewsNetworkHandle(reviews: [Review], maxPage: Int) {
        self.setTotalPages(maxPage: maxPage)
        self.appendMovies(newMovies: reviews)
        self.incrementCurrentPage()
        self.reviewsTableView.reloadData()
        self.reviewsTableView.refreshControl?.endRefreshing()
    }

}
