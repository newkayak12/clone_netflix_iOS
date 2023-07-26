//
//  SearchPersonCollectionViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/26.
//

import Foundation
import UIKit
import RxSwift

class SearchPersonCollectionViewCell: UICollectionViewCell {
    static let cellId = "SearchPersonCell"
    let imgView: UIImageView = {
       let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.layer.cornerRadius = 100.0
        return img
    }()
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textColor = .white
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textColor = .gray
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawUI()
    }
    
    func drawUI() {
        
    }
}

