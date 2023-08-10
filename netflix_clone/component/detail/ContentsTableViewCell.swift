//
//  ContentsTableViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/10.
//

import UIKit

class ContentsTableViewCell: UITableViewCell {
    static let cellId = "Contents"
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawUI(){
        
    }
}
