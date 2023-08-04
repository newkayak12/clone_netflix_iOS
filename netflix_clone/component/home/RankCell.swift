//
//  RankCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/09.
//

import UIKit

class RankCell: UICollectionViewCell {
    
    static let cellId = "Rank"
    let imgView: UIImageView = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
    
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawUI()
    }
    
    func drawUI() {
        self.addSubview(imgView)
        imgView.contentMode = .scaleAspectFit
        imgView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
        
    }
}
