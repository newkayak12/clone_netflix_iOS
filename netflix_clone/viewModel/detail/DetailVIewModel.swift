//
//  DetailVIewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/02.
//

import Foundation
import RxSwift

class DetailViewModel: ViewModelType {
    var title: String
    var service: Service
    var segmentIndex: BehaviorSubject<Int> = BehaviorSubject(value: 0)
    
    var persons: [Person] = []
    var personSubject: BehaviorSubject<[Person]> = BehaviorSubject(value: [])
    
    var reviews: [Comment] = []
    var reviewSubject: BehaviorSubject<[Comment]> = BehaviorSubject(value: [])
    
    var contentsDetails: [ContentDetail] = []
    var contentDetailSubject: BehaviorSubject<[ContentDetail]> = BehaviorSubject(value: [])
    
    var contentsNo: Int?
    
    init(title: String, service: Service) {
        self.title = title
        self.service = service
    }
    
    func fetchPerson () {
        persons.append(contentsOf: [Person(), Person(), Person(), Person(), Person(), Person(), Person()])
        personSubject.onNext(persons)
    }
    
    func fetchReview () {
        reviews.append(contentsOf: [
            Comment(), Comment(), Comment(), Comment(), Comment(),
            Comment(), Comment(), Comment(), Comment(), Comment(),
        ])
        reviewSubject.onNext(reviews)
    }
    
    func fetchContentsDetail () {
        contentsDetails.append(contentsOf: [ContentDetail(), ContentDetail(), ContentDetail(), ContentDetail(), ContentDetail()])
        contentDetailSubject.onNext(contentsDetails)
    }
    
    
}
