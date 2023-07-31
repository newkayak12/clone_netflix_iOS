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
    
    var delegate: StarRateDelegate?
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
    private let sliderValue = BehaviorSubject(value: Float(0.0))
    
    private lazy var slider = {
        let slider = UISlider()
        slider.minimumValue = 0.0
        slider.maximumValue = 5.0
        slider.layer.opacity = 0.1
        slider.tintColor = .yellow
        let configuration = UIImage.SymbolConfiguration(pointSize: 5)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        slider.setThumbImage(image, for: .normal)
        
        let tab = UITapGestureRecognizer(target: self, action: #selector(self.sliderTab(gestureRecognizer:)))
        slider.addGestureRecognizer(tab)
        slider.rx.value.bind {  value  in
            self.sliderValue.onNext(value )
        }.disposed(by: rx.disposeBag)
        self.sliderValue.bind { value in
            Log.warning("VALUE", value)
            self.first.image = self.empty
            self.second.image = self.empty
            self.third.image = self.empty
            self.fourth.image = self.empty
            self.fifth.image = self.empty
            switch value {
                case Float(0.0):
                    break;
                case ...Float(0.5):
                    self.first.image = self.half
                    break;
                case ...Float(1.0):
                    self.first.image = self.filled
                    break;
                case ...Float(1.5):
                    self.first.image = self.filled
                    self.second.image = self.half
                    break;
                case ...Float(2.0):
                    self.first.image = self.filled
                    self.second.image = self.filled
                    break;
                case ...Float(2.5):
                    self.first.image = self.filled
                    self.second.image = self.filled
                    self.third.image = self.half
                    break;
                case ...Float(3.0):
                    self.first.image = self.filled
                    self.second.image = self.filled
                    self.third.image = self.filled
                    break;
                case ...Float(3.5):
                    self.first.image = self.filled
                    self.second.image = self.filled
                    self.third.image = self.filled
                    self.fourth.image = self.half
                    break;
                case ...Float(4.0):
                    self.first.image = self.filled
                    self.second.image = self.filled
                    self.third.image = self.filled
                    self.fourth.image = self.filled
                    break;
                case ...Float(4.5):
                    self.first.image = self.filled
                    self.second.image = self.filled
                    self.third.image = self.filled
                    self.fourth.image = self.filled
                    self.fifth.image = self.half
                    break;
                default:
                    self.first.image = self.filled
                    self.second.image = self.filled
                    self.third.image = self.filled
                    self.fourth.image = self.filled
                    self.fifth.image = self.filled
                    break;
            }
        }.disposed(by: rx.disposeBag)
        return slider
    }()
    private lazy var first = {
        var first = UIImageView()
        first.image = self.empty
        first.tintColor = .yellow
        return first
    }()
    private lazy var second = {
        var second = UIImageView()
        second.image = self.empty
        second.tintColor = .yellow
        return second
    }()
    private lazy var third = {
        var third = UIImageView()
        third.image = self.empty
        third.tintColor = .yellow
        return third
    }()
    private lazy var fourth = {
        var fourth = UIImageView()
        fourth.image = self.empty
        fourth.tintColor = .yellow
        return fourth
    }()
    private lazy var fifth = {
        var fifth = UIImageView()
        fifth.image = self.empty
        fifth.tintColor = .yellow
        return fifth
    }()
    
    lazy var starView = {
        let view = UIView()
        
        let starContainer = UIStackView(arrangedSubviews: [self.first, self.second, self.third, self.fourth, self.fifth])
        starContainer.distribution = .fillEqually
        view.addSubview(starContainer)
        view.addSubview(self.slider)
        
        
        starContainer.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
        self.slider.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
        return view
    }()
    lazy var verticalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.title, self.subTitle, self.starView] );
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
    
    @objc func sliderTab(gestureRecognizer: UIGestureRecognizer){
        
        let pointTapped: CGPoint = gestureRecognizer.location(in: self.starView)
        
        let positionOfSlider: CGPoint = self.slider.frame.origin
        let widthOfSlider: CGFloat = self.slider.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) / widthOfSlider) * CGFloat(slider.maximumValue)
        let value = round(newValue * 10)
        let calc = value.truncatingRemainder(dividingBy: 5.0)
        var result = value
        if calc >= 2.5 {
            result += (5.0 - calc)
        } else {
            result -= calc
        }
        let resultValue = Float(result / 10)
        slider.setValue(resultValue , animated: true)
        sliderValue.onNext(resultValue )
        delegate?.rating(value: resultValue )
    }
    
    func setSliderValue(value: Float) {
        self.sliderValue.onNext(value)
        self.slider.value = value
    }
        
}

protocol StarRateDelegate {
    func rating(value: Float )
}
