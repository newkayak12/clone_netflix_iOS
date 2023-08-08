//
//  PersonCollectionViewHeader.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/08.
//

import UIKit
class PersonCollectionViewHeader: UICollectionReusableView {
    static let cellId = "collectionViewHeader"
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Header".uppercased()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setTitle( title: String ){
        self.label.text = title
    }
    
    func drawUI () {
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
