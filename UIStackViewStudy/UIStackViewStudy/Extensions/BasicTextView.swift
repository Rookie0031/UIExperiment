//
//  UITextViewTest.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/20.
//

import UIKit

class BasicTextView: UIView {
    
    private var textCount: String = "0"
    
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
    
    private lazy var placeholder: UILabel = {
        let label = UILabel.makeBasicLabel(labelText: Placeholder.text, textColor: .white, fontStyle: .title3, fontWeight: .bold)
        label.font = UIFont.setFont(.content)
        label.textColor = .gray02
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
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
        textView.constraint(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom:50, right: 0))
        
        addSubview(countLabel)
        countLabel.constraint(bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 20))
        
        addSubview(placeholder)
        placeholder.constraint(top: self.topAnchor, leading: self.leadingAnchor, padding: UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 0))
    }
}

extension BasicTextView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        // text 숫자 업데이트
        countLabel.text = "\(textView.text.count)/\(maxCount)"
        
        // 최대 글자수 제한 로직
        let maxCount = BasicTextView.maxCount
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
        placeholder.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholder.isHidden = false
        }
    }
}

extension BasicTextView {
    static var maxCount: Int = 300
    
    var maxCount: Int {
        get {
            BasicTextView.maxCount
        }
        set(newValue) {
            BasicTextView.maxCount = newValue
        }
    }
    
    struct Placeholder {
        static var text: String = "우리 밴드를 더 잘 보여줄 수 있는 소개를 간단하게 적어주세요\n(ex. 좋아하는 밴드, 밴드 경력 등)"
    }
    var placeholderText: String {
        get {
            Placeholder.text
        }
        set(newValue) {
            Placeholder.text = newValue
        }
    }
}


