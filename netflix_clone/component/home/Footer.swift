//
//  Footer.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import UIKit

class Footer: UIView {
    let company = UILabel(frame: .zero)
    let info = UILabel(frame: .zero)
    let numbers = UILabel(frame: .zero)
    let representer = UILabel(frame: .zero)
    let email = UILabel(frame: .zero)
    let address = UILabel(frame: .zero)
    let companyNo = UILabel(frame: .zero)
    let hosting = UILabel(frame: .zero)
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawUI()
    }
    
    func drawUI() {
        
        company.text = "넷플릭스 대한민국"
        info.text = "넷플릭스서비시스코리아 유한회사"
        numbers.text = "통신판매업신고번호: 제2018-서울종로-0426호"
        representer.text = "대표: 레지널드 숀 톰프슨"
        email.text = "이메일 주소: korea@netflix.com"
        address.text = "주소: 대한민국 서울특별시 종로구 우정국로 26, 센트로폴리스 A동 20층 우편번호 03161"
        companyNo.text = "사업자등록번호: 165-87-00119"
        hosting.text = "클라우드 호스팅: Amazon Web Services Inc."
        
        company.textColor = .systemGray
        info.textColor = .systemGray
        numbers.textColor = .systemGray
        representer.textColor = .systemGray
        email.textColor = .systemGray
        address.textColor = .systemGray
        companyNo.textColor = .systemGray
        hosting.textColor = .systemGray
        
        company.font = UIFont(name: "", size: CGFloat(8))
        info.font = UIFont(name: "", size: CGFloat(8))
        numbers.font = UIFont(name: "", size: CGFloat(8))
        representer.font = UIFont(name: "", size: CGFloat(8))
        email.font = UIFont(name: "", size: CGFloat(8))
        address.font = UIFont(name: "", size: CGFloat(8))
        companyNo.font = UIFont(name: "", size: CGFloat(8))
        hosting.font = UIFont(name: "", size: CGFloat(8))
        
        address.lineBreakMode = .byWordWrapping
        address.numberOfLines = 0 
        
        let stackView = UIStackView(arrangedSubviews: [
            company,
            info,
            numbers,
            representer,
            email,
            address,
            companyNo,
            hosting
        ])
        stackView.axis = .vertical
        stackView.spacing = CGFloat(5)
        stackView.distribution = .fillProportionally
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(self)
        }
    }

}
