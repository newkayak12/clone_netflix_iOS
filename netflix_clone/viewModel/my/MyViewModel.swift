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
    
    var watchSubject = PublishSubject<[Watched]>()
    var favoriteSubject = PublishSubject<[Favorite]>()
    
    var segmentIndex = BehaviorSubject<Int>(value: 0);
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
    func fetchWatched () {
        Log.debug("FETCH", "WATCHED")
        watched.append(contentsOf: [Watched(), Watched(), Watched()])
        watchSubject.onNext(watched)
    }
    func resetWatched() {
        watched = []
    }
    func fetchFavorite () {
        Log.debug("FETCH", "FAV")
        favorite.append(contentsOf: [Favorite(), Favorite(), Favorite(),
                                     Favorite()])
        favoriteSubject.onNext(favorite)
    }
    func resetFavorite() {
        favorite = []
    }
    
}
