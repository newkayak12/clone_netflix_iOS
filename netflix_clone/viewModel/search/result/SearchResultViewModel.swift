//
//  SearchResultViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/20.
//

import Foundation
import RxSwift

class SearchResultViewModel: ViewModelType {
    var title: String
    var service: Service
    private  var popuplar: [ContentsInfo] = [ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo()]
    private  var movie: [ContentsInfo] = [ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo()]
    private  var tag: [ContentsInfo] = [ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo()]
    private  var person: [Person] = [Person(), Person(), Person(), Person(), Person(), Person()]
    
    let popularSubject: BehaviorSubject<[ContentsInfo]> = BehaviorSubject(value: [])
    let movieSubject: BehaviorSubject<[ContentsInfo]> = BehaviorSubject(value: [])
    let tagSubject: BehaviorSubject<[ContentsInfo]> = BehaviorSubject(value: [])
    let personSubject: BehaviorSubject<[Person]> = BehaviorSubject(value: [])
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
    func fetchPopular () {
        popularSubject.onNext(popuplar)
    }
    
    func fetchMovie () {
        movieSubject.onNext(movie)
    }
    
    func fetchTag () {
        tagSubject.onNext(tag)
    }
    
    func fetchPerson () {
        personSubject.onNext(person)
    }
}
