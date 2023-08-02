//
//  MyViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
import RxSwift

class MyViewModel: ViewModelType {
    var title: String
    var service: Service
    private var watched: [Watched] = []
    private var favorite: [Favorite] = []
    
    var watchSubject = BehaviorSubject<[Watched]>(value: [])
    var favoriteSubject = BehaviorSubject<[Favorite]>(value: [])
    
    var segmentIndex = PublishSubject<Int>();
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
    func fetchWatched () {
        Log.debug("FETCH", "WATCHED")
        watched.append(contentsOf: [Watched(), Watched(), Watched(), Watched(), Watched(), Watched(), Watched(), Watched(), Watched()])
        watchSubject.onNext(watched)
    }
    func resetWatched() {
        watched = []
    }
    func fetchFavorite () {
        Log.debug("FETCH", "FAV")
        favorite.append(contentsOf: [Favorite(), Favorite(), Favorite(), Favorite(), Favorite(), Favorite(), Favorite(), Favorite(), Favorite(), Favorite()])
        favoriteSubject.onNext(favorite)
    }
    func resetFavorite() {
        favorite = []
    }
    
}
