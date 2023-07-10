//
//  MainViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/01.
//

import Foundation
import RxSwift
import NSObject_Rx

class HomeViewModel: ViewModelType {
    var title: String
    var service: Service
    var bag: DisposeBag = DisposeBag()
    
    
    public lazy var banners = PublishSubject<[Banner]>()
    public lazy var analyze = PublishSubject<[Analyze]>()
    public lazy var rank = PublishSubject<[ContentsInfo]>()
    public lazy var watched = PublishSubject<[Watched]>()
    public lazy var newEpisode = PublishSubject<[ContentsInfo]>()
    public lazy var category = PublishSubject<[Category]>()
    
    func fetchBanner() {
        banners.onNext([Banner(),Banner()])
    }
    func fetchAnalyze() {
        analyze.onNext([Analyze(), Analyze(), Analyze(), Analyze(), Analyze()])
    }
    func fetchRank() {
        rank.onNext([
            ContentsInfo(), ContentsInfo(), ContentsInfo(),
            ContentsInfo(), ContentsInfo(), ContentsInfo(),
            ContentsInfo(), ContentsInfo(), ContentsInfo(),
            ContentsInfo()
        ])
    }
    func fetchWatched(){
        watched.onNext([
                        Watched(), Watched(), Watched(), Watched(),
                        Watched(), Watched(), Watched(), Watched()
                       ])
    }
    func fetchNewEpisode() {
        newEpisode.onNext([
            ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(),
            ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo()
        ])
    }
    func fetchCategory() {
        category.onNext([
            Category(), Category(), Category(), Category(), Category(),
            Category(), Category(), Category(), Category(), Category()
        ])
    }
    
  
        
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
}
