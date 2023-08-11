//
//  ContentsTableView.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/11.
//

import UIKit

class ContentsTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
}
