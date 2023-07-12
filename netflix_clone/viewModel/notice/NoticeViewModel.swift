//
//  NoticeViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/09.
//

import Foundation
import RxSwift
import RxDataSources
import NSObject_Rx

class NoticeViewModel: ViewModelType {
    var title: String
    var service: Service
    var pageRequest: PageRequest = PageRequest()
    public lazy var loading = PublishSubject<Bool>()
    public var noticeArray: [Notice] = []
    public lazy var notice = PublishSubject<[Notice]>()

    public var dataSource: RxTableViewSectionedReloadDataSource<DataSection> = {
        let datasource =  RxTableViewSectionedReloadDataSource<DataSection> {
            _, tableView, indexPath, item in
            switch indexPath[0] {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: NoticeCell.cellId, for: indexPath) as! NoticeCell
                    cell.selectionStyle = .gray
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "INFINITE", for: indexPath)
                    cell.backgroundColor = .black
                    cell.selectionStyle = .none
                    return cell
            }
        }
        return datasource
    }()
        
     
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
        
    }
    
    func fetchNotice ( page: Int = 1 ){
        self.loading.onNext(true)
        noticeArray.append(contentsOf: [
            Notice(),Notice(),Notice(),
            Notice(),Notice(),Notice(),
            Notice(),Notice(),Notice(),
            Notice(),Notice(),Notice(),
        ])
        notice.onNext( noticeArray )
        
        
        
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(5)
            .debug()
            .delay(.seconds(5), scheduler: MainScheduler.instance)
            .subscribe { _ in
                self.loading.onNext(false)
                self.noticeArray.append(contentsOf: [
                    Notice(),Notice(),Notice(),
                    Notice(),Notice(),Notice(),
                    Notice(),Notice(),Notice(),
                    Notice(),Notice(),Notice(),
                ])
                self.notice.onNext(self.noticeArray)
            }
    }
    
}
struct DataSection {
    var type: String
    var items: [Notice]
}
extension DataSection: SectionModelType {
    init(original: DataSection, items: [Notice]) {
        self = original
        self.items = items
    }
}
 
