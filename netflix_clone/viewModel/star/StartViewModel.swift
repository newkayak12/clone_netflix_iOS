//
//  StartViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
import RxSwift

class StarViewModel: ViewModelType {
    var title: String
    var service: Service
    private var contentStar: [ContentsInfo] = []
    var starPublish: PublishSubject<[ContentsInfo]> = PublishSubject()
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
    func fetchStar() {
        self.contentStar.append(contentsOf: [ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo()])
        self.starPublish.onNext(self.contentStar)
    }
    
}
