//
//  IdInput.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/14.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa


final class IdInput: UIView {
   public var validText: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    
    
   private lazy var title = {
        let label = UILabel()
        label.text = "아이디를 입력해주세요"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.height.equalTo(26)
        }
        return label;
    }()
   private lazy var xButton = {
       let button = UIButton()
       let xImage = UIImage(systemName: "x.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(xImage, for: .normal)
        button.addTarget(self, action: #selector(self.clear), for: .touchUpInside)
        return button
    }()
   private lazy var input = {
       let field = UITextField()
       field.borderStyle = .roundedRect
       field.textColor = .white
       field.backgroundColor = .black
       field.tintColor = .white
       field.placeholder = "아이디를 입력해주세요."
       field.rightViewMode = .always
       field.rightView = self.xButton
       field.font = UIFont.systemFont(ofSize: 20)
       field.snp.makeConstraints { make in
           make.height.equalTo(50)
       }
        return field
    }()
   private lazy var validation = {
        let label = UILabel();
        self.validText.bind(to: label.rx.text).disposed(by: rx.disposeBag)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .red
       label.snp.makeConstraints { make in
           make.height.equalTo(15)
       }
        return label
    }()
   private lazy var container = {
    let stackView = UIStackView(arrangedSubviews: [self.title, self.input, self.validation])
    stackView.axis = .vertical
    stackView.spacing = 10
    return stackView
   }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    
    
    func drawUI () {
        self.addSubview(self.container)
        self.container.snp.makeConstraints { make in
            make.width.height.leading.top.trailing.bottom.equalTo(self)
        }
    }
    
    func addInputEvent() -> ControlProperty<String?> {
        return self.input.rx.text
    }
    func invalid( text: String ){
        validText.onNext(text)
    }
    @objc
    func clear () {
        self.input.text = ""
    }
}
