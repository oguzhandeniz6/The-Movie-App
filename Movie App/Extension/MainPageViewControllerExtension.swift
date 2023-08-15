//
//  MainPageViewControllerExtension.swift
//  Movie App
//
//  Created by oguzhan.deniz on 15.08.2023.
//

import Foundation

//MARK: - Network Handlers

extension MainPageViewController {
    
    func selectGenresHandle(genresList: [Genre]) {
        var selectedGenres = genresList
        selectedGenres.getRandomNElement(numOfElms: 3)
        self.setGenresList(genres: selectedGenres)
        
        self.setG1LabelText(text: selectedGenres[0].name ?? "")
        self.incrementG1Current()
        
        self.setG2LabelText(text: selectedGenres[1].name ?? "")
        self.incrementG2Current()
        
        self.setG3LabelText(text: selectedGenres[2].name ?? "")
        self.incrementG3Current()
    }
    
    func nowPlayingNetworkHandle(npList: [Movie], maxPage: Int) {
        self.setNpMaxPage(maxPage: maxPage)
        self.appendNowPlayingList(movies: npList)
        self.incrementNpCurrent()
        self.nowPlayingCollectionView.reloadData()
    }
    
    func upcomingNetworkHandle(upList: [Movie], maxPage: Int) {
        self.setUpMaxPage(maxPage: maxPage)
        self.appendUpcomingList(movies: upList)
        self.incrementUpCurrent()
        self.upcomingCollectionView.reloadData()
    }
    
    func genre1NetworkHandle(g1List: [Movie], maxPage: Int) {
        self.setG1MaxPage(maxPage: maxPage)
        self.appendGenre1List(movies: g1List)
        self.incrementG1Current()
        self.genre1CollectionView.reloadData()
    }
    
    func genre2NetworkHandle(g2List: [Movie], maxPage: Int) {
        self.setG2MaxPage(maxPage: maxPage)
        self.appendGenre2List(movies: g2List)
        self.incrementG2Current()
        self.genre2CollectionView.reloadData()
    }
    
    func genre3NetworkHandle(g3List: [Movie], maxPage: Int) {
        self.setG3MaxPage(maxPage: maxPage)
        self.appendGenre3List(movies: g3List)
        self.incrementG3Current()
        self.genre3CollectionView.reloadData()
    }
}
