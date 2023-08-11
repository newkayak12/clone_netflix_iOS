//
//  DetailVIewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/02.
//

import Foundation
import RxSwift
import RxDataSources
import UIKit


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
    
    public var personDataSource: RxCollectionViewSectionedReloadDataSource<PersonSection> = {
        let dataSource = RxCollectionViewSectionedReloadDataSource<PersonSection> (
            
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.cellId, for: indexPath) as! PersonCollectionViewCell
                cell.title.text = "TITLE"
                cell.subTitle.text = "SUBTITLE"
                return cell
            },
            configureSupplementaryView: { datasource, collectionView, kind, indexPath  in
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PersonCollectionViewHeader.cellId, for: indexPath) as? PersonCollectionViewHeader else {
                    return UICollectionReusableView()
                }
                let section = datasource.sectionModels[indexPath.row].type
                header.setTitle(title: section)
                
                return header
            }
        )
        return dataSource
    }()
    
    public var contnentsDetailDataSource: RxTableViewSectionedReloadDataSource<ContentsDetailSection> = {
        let dataSource = RxTableViewSectionedReloadDataSource<ContentsDetailSection> { dataSource, table, IndexPath, item in
            let cell =  table.dequeueReusableCell(withIdentifier: ContentsTableViewCell.cellId) as! ContentsTableViewCell
            
            Log.info("???????")
            return cell
        } titleForHeaderInSection: { dataSource, number in
            return "0개"
        }

        Log.error(">>>>>>>>")
        return dataSource
    }()
    var contentsNo: Int?
    
    init(title: String, service: Service) {
        self.title = title
        self.service = service
    }
    
    func fetchPerson () {
        Log.warning("fetchPerson")
        persons.append(contentsOf: [Person(), Person(), Person(), Person(), Person(), Person(), Person()])
        personSubject.onNext(persons)
    }
    
    func fetchReview () {
        Log.warning("fetchReview")
        reviews.append(contentsOf: [
            Comment(), Comment(), Comment(), Comment(), Comment(),
            Comment(), Comment(), Comment(), Comment(), Comment(),
            Comment(), Comment(), Comment(), Comment(), Comment(),
            Comment(), Comment(), Comment(), Comment(), Comment(),
            Comment(), Comment(), Comment(), Comment(), Comment(),
            Comment(), Comment(), Comment(), Comment(), Comment(),
            Comment(), Comment(), Comment(), Comment(), Comment(),
            Comment(), Comment(), Comment(), Comment(), Comment(),
            Comment(), Comment(), Comment(), Comment(), Comment(),
            Comment(), Comment(), Comment(), Comment(), Comment(),
            Comment(), Comment(), Comment(), Comment(), Comment(),
            Comment(), Comment(), Comment(), Comment(), Comment(),
        ])
        reviewSubject.onNext(reviews)
    }
    
    func fetchContentsDetail () {
        Log.warning("fetchContentsDetail")
        contentsDetails.append(contentsOf: [
                                                    ContentDetail(), ContentDetail(), ContentDetail(), ContentDetail(), ContentDetail(),
                                                    ContentDetail(), ContentDetail(), ContentDetail(), ContentDetail(), ContentDetail(),
                                                    ContentDetail(), ContentDetail(), ContentDetail(), ContentDetail(), ContentDetail(),
                                           ])
        contentDetailSubject.onNext(contentsDetails)
    }
    
    
}


struct PersonSection {
    var type: String
    var items: [Person]
}
extension PersonSection: SectionModelType {
    init(original: PersonSection, items: [Person]) {
        self = original
        self.items = items
    }
}


struct ContentsDetailSection {
    var type: String
    var items: [ContentDetail]
}
extension ContentsDetailSection: SectionModelType {
    init(original: ContentsDetailSection, items: [ContentDetail]) {
        self = original
        self.items = items
    }
}
