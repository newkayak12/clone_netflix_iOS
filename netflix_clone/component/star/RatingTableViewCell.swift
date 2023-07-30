//
//  RatingTableViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/29.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class RatingTableViewCell: UITableViewCell {
    static let cellId = "RatingCell"
    
    private lazy var empty: UIImage? = {
        let image = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))
        return image
    }()
    private lazy var filled: UIImage? = {
        return UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))
    }()
    private lazy var half: UIImage? = {
        return  UIImage(systemName: "star.leadinghalf.filled", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))
    }()

    let rateArray: BehaviorSubject<[Double]> = BehaviorSubject<[Double]>(value: [0.0, 0.0, 0.0, 0.0, 0.0])
    private lazy var starBox = {
        let btnArray = [0.0, 0.0, 0.0, 0.0, 0.0].map { _ in
            let btn = UIButton(frame: .zero)
            btn.setImage(self.empty, for: .normal)
            btn.imageView?.tintColor = .yellow
            btn.imageView?.snp.makeConstraints({ make in
                make.width.height.equalTo(btn).multipliedBy(0.6)
            })
            btn.addTarget(self, action: #selector(self.btnEvent(btn: )), for: .touchUpInside)
            return btn
        }
        
        btnArray.enumerated().forEach{
            $1.tag = $0
        }

        let container = UIStackView(arrangedSubviews: btnArray)
        container.axis = .horizontal
        container.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        container.distribution = .fillEqually
        
        return container
    }()
    public func calculateStar ( rate: Double ) -> [Double] {
        var array = Array([0.0, 0.0, 0.0, 0.0, 0.0])
        var score = rate;
        var count = 0;
        while score > 0.0 {
            switch score {
                case ...0.0:
                    break;
                case 0.0...0.5 :
                    score -= 0.5
                    array[count] = 0.5
                    break;
                default:
                    score -= 1.0
                    array[count] = 1.0
                    break;
            }
            count += 1
        }
        
        return array
    }
    private func ratingStar ( rate: Double ) {
        
    }
    
    
    lazy var imgView: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.contentMode = .scaleAspectFit
        img.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return img
    }()
    lazy var title = {
        let label = UILabel(frame: .zero)
        label.text = "title"
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        return label;
    }()
    lazy var subTitle = {
        let label = UILabel(frame: .zero)
        label.text = "subtitle"
        label.textColor = .gray
        label.snp.makeConstraints { make in
            make.height.equalTo(15)
        }
        return label;
    }()
    lazy var verticalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.title, self.subTitle] );
        stackView.axis = .vertical
        return stackView
    }()
    lazy var horizontalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.imgView, self.verticalStackView] );
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
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
    
    override func prepareForReuse() {
        self.title.text = "title"
        self.subTitle.text = "subTitle"
        imgView.image = UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large))
    }
    
    
    func drawUI() {
        self.contentView.addSubview(horizontalStackView)
        
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.contentView)
            make.leading.equalTo(self.contentView).offset(20)
            make.trailing.equalTo(self.contentView).offset(-20)
            //            make.leading.trailing.equalTo(self.contentView)
        }
    }
    
    @objc func btnEvent ( btn: UIButton ) {
        Log.debug("BTN", btn)
        switch btn.tag {
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
            case 4:
                break;
            default:
                break;
        }
    }
    
        
        
}
