//
//  NoticeDetailImageCollectionViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/28.
//

import Foundation
import UIKit

class NoticeDetailImageCollectionViewCell: UICollectionViewCell {
    static let cellId = "NoticeImage"
    
    lazy var imageView = {
        let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    
    override init(frame: CGRect) {
        Log.debug("INIT COLLECTION")
        super.init(frame: frame)
        drawUI()
    }
    
    func drawUI() {
        
        self.contentView.addSubview(imageView)
        
        self.imageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
    }
}
