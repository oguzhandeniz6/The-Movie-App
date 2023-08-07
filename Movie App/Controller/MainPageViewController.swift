//
//  MainPageViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 7.08.2023.
//

import UIKit

class MainPageViewController: UIViewController {
    
    private var genresList: [Genre] = []
    private var chosenGenres: [Genre] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStartGenres()

    }
    
    func getStartGenres() {
        NetworkService.getGenres(mainVC: self)
    }

}

//MARK: - MainPageViewController Extension

extension MainPageViewController {
    
    func setGenresList(genres: [Genre]) {
        self.genresList = genres
    }
    
    func setChosenGenres(genres: [Genre]) {
        self.chosenGenres = genres
    }
}
