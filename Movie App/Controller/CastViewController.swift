//
//  CastViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 28.07.2023.
//

import UIKit

class CastViewController: UIViewController {
    
    private var relatedMovies: [Movie] = []
    
    var actorID: Int = 0
    
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var actorPhotoImageView: UIImageView! {
        didSet {
            actorPhotoImageView.superview?.sendSubviewToBack(actorPhotoImageView)
        }
    }
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var deathdayLabel: UILabel!
    @IBOutlet weak var birthPlaceLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    
    @IBOutlet weak var bioView: UIView! {
        didSet {
            bioView.layer.cornerRadius = 30
        }
    }
    
    @IBOutlet weak var castScrollView: UIScrollView! {
        didSet {
            castScrollView.contentInset = UIEdgeInsets(top: UIConstants.scrollViewTopInset, left: 0.0, bottom: 0.0, right: 0.0)
        }
    }
    
    @IBOutlet weak var relatedMoviesCollectionView: UICollectionView! {
        didSet {
            relatedMoviesCollectionView.delegate = self
            relatedMoviesCollectionView.dataSource = self
            relatedMoviesCollectionView.prepareCollectionView(cell: MoviePosterCell.self, width: MoviePosterCell.recommendationCellWidth, height: MoviePosterCell.recommendationCellHeight)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.getActorDetails(actorID: actorID) { person in
            self.preparePage(actor: person)
        }
    }
    
    func preparePage(actor: Actor) {
        
//        Prepare Details

        self.detailsNetworkHandle(actor: actor)
        
//        Prepare Poster Image
        
        if let posterPath = actor.profilePath {
            actorPhotoImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: posterPath, imageSize: ProfileSize.original.rawValue))
        }
        
//        Prepare Related Movies
        
        if let relatedMovies = actor.relatedMovies, let movies = relatedMovies.cast {
            self.relatedMoviesNetworkHandle(relatedMovies: movies)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension CastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedMoviesCollectionView.updateVisibilityAndGetItemCount(list: relatedMovies)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = relatedMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.getClassName(), for: indexPath) as? MoviePosterCell else {
            return UICollectionViewCell()
        }
        
        let movie = relatedMovies[indexPath.row]
        cell.fillCell(movie)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension CastViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
            
            nextVC.movieID = relatedMovies[indexPath.row].id ?? 0
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

//MARK: - CastViewControllerExtension

extension CastViewController {
    
    func setRelatedMovies(movies: [Movie]) {
        self.relatedMovies = movies
    }
    
    private func detailsNetworkHandle(actor: Actor) {
        actorNameLabel.text = actor.name
        birthdayLabel.text = FormatChangers.dateFormatChanger(str: actor.birthday ?? "")
        
        if actor.deathday != nil {
            deathdayLabel.text = FormatChangers.dateFormatChanger(str: actor.deathday ?? "")
        } else {
            deathdayLabel.text = ""
        }
        
        birthPlaceLabel.text = actor.placeOfBirth
        bioLabel.text = "\n\(actor.biography ?? "")\n"
    }
    
    private func relatedMoviesNetworkHandle(relatedMovies: [Movie]) {
        self.setRelatedMovies(movies: relatedMovies)
        self.relatedMoviesCollectionView.reloadData()
    }
}
