//
//  NoticeCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/10.
//

import Foundation
import UIKit

class NoticeCell: UITableViewCell {
    static let cellId: String = "Notice"
    
    lazy var titleLabel = {
        let label = UILabel(frame: .zero)
        label.layoutMargins = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        label.text = "TITLE"
        label.textColor = .white
        label.backgroundColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label;
    }()
    lazy var dateLabel = {
        let label = UILabel(frame: .zero)
        label.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        label.backgroundColor = .black
        let date = self.nowDate()
        label.text = date
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label;
    }()
    lazy var cellStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.dateLabel])
        stackView.axis = .vertical
        
        return stackView
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
    
    func nowDate () -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        
        return dateFormatter.string(from: Date())
    }
    override func prepareForReuse() {
        self.titleLabel.text = "TITLE"
        self.dateLabel.text = self.nowDate()
    }
    
    func drawUI(){
        cellStackView.backgroundColor = .clear
        
        self.addSubview(cellStackView)
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(cellStackView).multipliedBy(0.8)
        }
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(cellStackView).multipliedBy(0.2)
        }
        cellStackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }
}
