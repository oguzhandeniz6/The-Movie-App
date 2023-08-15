//
//  MainPageViewControllerExtension.swift
//  Movie App
//
//  Created by oguzhan.deniz on 15.08.2023.
//

import Foundation

//MARK: - Network Handlers

extension MainPageViewController {
    
    func nowPlayingNetworkHandle(npList: [Movie], maxPage: Int) {
        self.appendNowPlayingList(movies: npList)
        self.incrementNpCurrent()
        self.setNpMaxPage(maxPage: maxPage)
        self.nowPlayingCollectionView.reloadData()
    }
    
    func upcomingNetworkHandle(upList: [Movie], maxPage: Int) {
        self.appendUpcomingList(movies: upList)
        self.incrementUpCurrent()
        self.setUpMaxPage(maxPage: maxPage)
        self.upcomingCollectionView.reloadData()
    }
}
