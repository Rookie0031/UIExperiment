//
//  UITextViewTest.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/20.
//

import UIKit

class BasicTextView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBlue
        constraint(.widthAnchor, constant: DeviceSize.width * 0.9)
        constraint(.heightAnchor, constant: 250)
        
        let textView = UITextView.makeBasicTextView(placeholder: "우리 밴드를 잘 보여줄 수 있는 소개를 간단히 적어주세요", textColor: .white, lineSpacing: 10)
        
        let label = UILabel.makeBasicLabel(labelText: "10/300", textColor: .white, fontStyle: .title3, fontWeight: .bold)
        
        addSubviews(textView, label)
        
        textView.constraint(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom:50, right: 0))
        
        label.constraint(bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
