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
    var pageRequest = PageRequest()
    var disposeBag = DisposeBag()
    
    public var noticeArray: [Notice] = []
    public lazy var notice = PublishSubject<[Notice]>()

    public var dataSource: RxTableViewSectionedReloadDataSource<DataSection> = {
        let datasource =  RxTableViewSectionedReloadDataSource<DataSection> {
            _, tableView, indexPath, item in
            switch indexPath[0] {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: NoticeCell.cellId, for: indexPath) as! NoticeCell
                    
                    cell.titleLabel.text = item.title
                    let format = DateFormatter()
                    format.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
                    cell.dateLabel.text = format.string(from: item.regDate)
                    
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
    
    func fetchNotice (  ){
        Log.debug(pageRequest.totalPages, pageRequest.page )
        
        
            service.get(path: BoardApi.notices, params: ["page": pageRequest.page, "limit": pageRequest.limit], type: PageResult<Notice>.self)
                .subscribe{
                    if let result: PageResult<Notice> = $0.element {
                        self.pageRequest.totalPages = result.totalPages
                        self.noticeArray.append(contentsOf: result.content)
                        self.notice.onNext( self.noticeArray )
                        self.pageRequest.page += 1
                    }
                }   .disposed(by: disposeBag)
            
            
            
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
 
