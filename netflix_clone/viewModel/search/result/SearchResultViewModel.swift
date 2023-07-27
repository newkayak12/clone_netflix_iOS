//
//  SearchResultViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/20.
//

import Foundation
import RxSwift
import NSObject_Rx

class SearchResultViewModel: ViewModelType {
    var title: String
    var service: Service
    
    var searchText = PublishSubject<String>()
    var text = ""
    var segmentIndex = PublishSubject<Int>()
    var nowIndex: Int = 0
    
    private  var popuplar: [ContentsInfo] = [ContentsInfo()]
    private  var movie: [ContentsInfo] = [ContentsInfo()]
    private  var tag: [ContentsInfo] = [ContentsInfo()]
    private  var person: [Person] = [Person()]
    
    let popularSubject: BehaviorSubject<[ContentsInfo]> = BehaviorSubject(value: [])
    let movieSubject: BehaviorSubject<[ContentsInfo]> = BehaviorSubject(value: [])
    let tagSubject: BehaviorSubject<[ContentsInfo]> = BehaviorSubject(value: [])
    let personSubject: BehaviorSubject<[Person]> = BehaviorSubject(value: [])
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
   
    
    func fetchPopular () {
        popuplar.append(contentsOf: [ContentsInfo(), ContentsInfo()])
        popularSubject.onNext(popuplar)
    }
    
    func fetchMovie () {
        movie.append(contentsOf: [ContentsInfo(), ContentsInfo()])
        movieSubject.onNext(movie)
    }
    
    func fetchTag () {
        tag.append(contentsOf: [ContentsInfo(), ContentsInfo()])
        tagSubject.onNext(tag)
    }
    
    func fetchPerson () {
        person.append(contentsOf: [Person(), Person()])
        personSubject.onNext(person)
    }
}
