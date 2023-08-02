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
    
    var contentsNo: Int?
    
    init(title: String, service: Service) {
        self.title = title
        self.service = service
    }
    
    
}
