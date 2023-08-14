//
//  PersonViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/14.
//

import UIKit
import RxSwift

class PersonViewModel: ViewModelType {
    var title: String
    var service: Service
    
    var contents: [ContentsInfo] = []
    var contentsSubject: BehaviorSubject<[ContentsInfo]> = BehaviorSubject<[ContentsInfo]>(value: [])
    
    
    init(title: String, service: Service) {
        self.title = title
        self.service = service
    }
    
    
    func fetchPersonContents() {
        contents.append(contentsOf: [
            ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(),
            ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo(), ContentsInfo()
        ])
        
        contentsSubject.onNext(self.contents)
    }
}
