//
//  NoticeDetailViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/27.
//

import Foundation
import RxSwift
import RxDataSources
import NSObject_Rx

class NoticeDetailViewModel: ViewModelType {
    var title: String
    var service: Service
    var notice: Notice?
    
    init(title: String, service: Service) {
        self.title = title
        self.service = service
    }
    
    
    
}
