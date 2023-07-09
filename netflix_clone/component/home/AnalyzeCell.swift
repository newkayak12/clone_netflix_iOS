//
//  AnalyzeCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
import UIKit

class AnalyzeCell: UICollectionViewCell{
    static let cellId = "Analyze"
   
    let title: UILabel = UILabel(frame: .zero)
    let subTitle: UILabel = UILabel(frame: .zero)
    let descriptions: UILabel = UILabel(frame: .zero)
    let imgView: UIImageView = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawUI()
    }
    
    func setImgSource( data: Data ){
        imgView.image = UIImage(data: data, scale: CGFloat(1.0))
    }
    func setContent( analyze: Analyze ){
        
    }
    func drawUI() {
        title.text = "TITLE"
        subTitle.text = "SUBTITLE"
        descriptions.text = "DESCRIPTIONS"
        title.textColor = .systemGray
        subTitle.textColor = .systemGray
        descriptions.textColor = .systemGray
        imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = .white
        
        
        let stackView = UIStackView(arrangedSubviews: [
            title,
            subTitle,
            descriptions,
            imgView,
        ])
        stackView.axis = .vertical
        
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.top.left.bottom.equalTo(self)
        }
        imgView.snp.makeConstraints { make in
            make.width.leading.trailing.bottom.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.7)
        }
        title.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.1)
        }
        subTitle.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(title.snp.bottom)
            make.height.equalTo(self).multipliedBy(0.1)
        }
        descriptions.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(subTitle.snp.bottom)
            make.height.equalTo(self).multipliedBy(0.1)
        }
        imgView.layer.cornerRadius = 20
        self.backgroundColor = .clear
        
    
        
        
        
    }
    
}
