//
//  UITextViewTest.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/20.
//

import UIKit

class BasicTextView: UIView {
    
    private var textCount: String = "0"
    
    private let placeholder: String
    
    private var maxCount: Int = 300
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        let style = NSMutableParagraphStyle()
        let attributedString = NSMutableAttributedString(string: textView.text)
        // 행간 세팅
        style.lineSpacing = CGFloat(7)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length))
        // 자간 세팅
        
        textView.attributedText = attributedString
        textView.font = UIFont.setFont(.content)
        textView.textColor = .white
        textView.backgroundColor = .dark02
        
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var countLabel = {
        let label = UILabel.makeBasicLabel(labelText: "\(textCount)/\(maxCount)", textColor: .gray02, fontStyle: .title3, fontWeight: .bold)
        label.font = UIFont.setFont(.headline01)
        return label
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel.makeBasicLabel(labelText: placeholder, textColor: .white, fontStyle: .title3, fontWeight: .bold)
        label.font = UIFont.setFont(.content)
        label.textColor = .gray02
        label.numberOfLines = 2
        return label
    }()
    
    init(placeholder: String, maxCount: Int? = nil) {
        self.placeholder = placeholder
        if let maxCount { self.maxCount = maxCount}
        super.init(frame: .zero)
        setupLayout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = .dark02
    }
    
    private func setupLayout() {
        self.constraint(.widthAnchor, constant: BasicComponentSize.width)
        self.constraint(.heightAnchor, constant: 250)
        
        addSubview(textView)
        textView.constraint(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom:50, right: 10))
        
        addSubview(countLabel)
        countLabel.constraint(bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 20))
        
        addSubview(placeholderLabel)
        placeholderLabel.constraint(top: self.topAnchor, leading: self.leadingAnchor, padding: UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 0))
    }
}

extension BasicTextView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        // text 숫자 업데이트
        countLabel.text = "\(textView.text.count)/\(maxCount)"
        
        // 최대 글자수 제한 로직
        let maxCount = maxCount
        if let text = textView.text {
            if text.count >= maxCount {
                let maxCountIndex = text.index(text.startIndex, offsetBy: maxCount)
                let fixedText = String(text[text.startIndex..<maxCountIndex])
                textView.text = fixedText + " "
                self.countLabel.text = "\(maxCount)/\(maxCount)"
                self.textView.text = fixedText
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholderLabel.isHidden = false
        }
    }
}

//extension BasicTextView {
//    static var maxCount: Int = 300
//
//    var maxCount: Int {
//        get {
//            BasicTextView.maxCount
//        }
//        set(newValue) {
//            BasicTextView.maxCount = newValue
//        }
//    }
//}


