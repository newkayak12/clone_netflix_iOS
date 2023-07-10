//
//  NoticeViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/09.
//

import Foundation
import RxSwift
import NSObject_Rx

class NoticeViewModel: ViewModelType {
    var title: String
    var service: Service
    var pageRequest: PageRequest = PageRequest()
    public lazy var loading = PublishSubject<Bool>()
    public lazy var notice = PublishSubject<[Notice]>()
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
    func fetchNotice ( page: Int = 1 ){
        self.loading.onNext(true)
        
        notice.onNext([
                            Notice(),Notice(),Notice(),Notice(),Notice(),
                            Notice(),Notice(),Notice(),Notice(),Notice(),
                            Notice(),Notice(),Notice(),Notice(),Notice(),
                            Notice(),Notice(),Notice(),Notice(),Notice(),
                      ])
        
        
        
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(5)
            .debug()
            .delay(.seconds(5), scheduler: MainScheduler.instance)
            .subscribe { _ in self.loading.onNext(false) }
    }
    
}
