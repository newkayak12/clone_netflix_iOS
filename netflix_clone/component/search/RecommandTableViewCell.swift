//
//  RecommandTableViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/21.
//

import UIKit
import SnapKit

class RecommandTableViewCell: UITableViewCell {
    static let cellId = "recommandCell"
    var rowNumber: Int = 0
    lazy var label = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.text = ""
        
        return label
    }()
    var callBackMehtod: ((_: Int) -> Void)?
    
    
    lazy var button = {
        let button = UIButton(frame: .zero)
        let symbolConfiguration = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: symbolConfiguration), for: .normal)
        button.tintColor = .white
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
        
        self.contentView.addSubview(self.label)
        self.contentView.addSubview(self.button)
        self.button.addTarget(self, action: #selector(callback), for: .touchUpInside)
        
        self.label.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.leading.equalTo(self.contentView).offset(20)
        }
        self.button.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.trailing.equalTo(self.contentView).offset(-20)
        }
    }
    
    @objc
    func callback () {
        guard let callback = self.callBackMehtod else { return }
        callback(self.rowNumber)
    }
}
