//
//  SearchViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
import RxSwift

class SearchViewModel: ViewModelType {
    var title: String
    var service: Service
    
    
    private var populars: [ContentsInfo] = []
    private var recommands: [ContentsInfo] = []
    private var categories: [Category] = []
    
    
    let popular = PublishSubject<[ContentsInfo]>()
    let recommand = PublishSubject<[ContentsInfo]>()
    let category = PublishSubject<[Category]>()
    var searchText: [String] = []
    var lastSearchText = BehaviorSubject<[String]>(value: ["Test", "Test"])
    
    
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
    func fetchPopular () {
        self.populars.append(contentsOf: [ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo()])
        popular.onNext(self.populars)
    }
    func fetchRecommand () {
        self.recommands.append(contentsOf: [ContentsInfo(), ContentsInfo(), ContentsInfo(),ContentsInfo(), ContentsInfo(), ContentsInfo()])
        recommand.onNext(self.recommands)
    }
    func fetchCategory () {
        self.categories.append(contentsOf: [Category(), Category(), Category(), Category(), Category(), Category()])
        category.onNext(self.categories)
    }
    
}
