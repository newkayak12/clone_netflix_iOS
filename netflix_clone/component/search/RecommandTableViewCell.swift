//
//  RecommandTableViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/21.
//

import Foundation
import UIKit
import SnapKit

class RecommandTableViewCell: UITableViewCell {
    static let cellId = "recommandCell"
    var rowNumber: Int = 0
    var callBack: ((_: Int) -> Void)?
    lazy var label = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.text = ""
        
        return label
    }()
    
    lazy var button = {
        let button = UIButton(frame: .zero)
        let symbolConfiguration = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: symbolConfiguration), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(self.wrapCallback), for: .touchUpInside)
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        label.text = ""
        rowNumber = 0
    }
    
    
    func drawUI() {
        
        
        self.addSubview(self.label)
        self.addSubview(self.button)
        
        self.label.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(20)
        }
        self.button.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).offset(-20)
        }
        
    }
    
    @objc
    func wrapCallback () {
        guard let callback = self.callBack else { return }
        callback(rowNumber)
    }
}
