//
//  MainViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/01.
//

import Foundation
import RxSwift

class HomeViewModel: ViewModelType {
    var title: String
    var service: Service
    var bag: DisposeBag = DisposeBag()
    
    
    public lazy var banners = PublishSubject<[Banner]>()
    
    func fetchBanner() {
        Log.warning("?", "?")
        banners.onNext([Banner(),Banner()])
    }
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
}
