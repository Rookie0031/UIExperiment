//
//  UITextViewTest.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/20.
//

import UIKit

class BasicTextView: UIView {
    
    private var textCount: String = "0"
    
    private let textView = UITextView.makeBasicTextView(placeholder: "", textColor: .white, lineSpacing: 7)
    
    private lazy var countLabel = UILabel.makeBasicLabel(labelText: "\(textCount)/\(maxCount)", textColor: .white, fontStyle: .title3, fontWeight: .bold)
    
    private lazy var placeholder: UILabel = {
        let label = UILabel.makeBasicLabel(labelText: Placeholder.text, textColor: .white, fontStyle: .title3, fontWeight: .bold)
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        constraint(.widthAnchor, constant: DeviceSize.width * 0.9)
        constraint(.heightAnchor, constant: 250)
        
        addSubviews(textView, countLabel, placeholder)
        
        textView.constraint(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom:50, right: 0))
        textView.delegate = self
        
        countLabel.constraint(bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 20))
        
        placeholder.constraint(top: self.topAnchor, leading: self.leadingAnchor, padding: UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 0))
        
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.orange.cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(textViewTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BasicTextView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = textView.text ?? ""
        guard let stringRange = Range (range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        countLabel.text = "\(changedText.count)/\(maxCount)"
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing")
        placeholder.isHidden = true
        guard textView.textColor == .placeholderText else { return }
        textView.textColor = .label
        textView.attributedText = NSAttributedString(string: "")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholder.isHidden = false
        }
    }
}

extension BasicTextView {
    @objc func textViewTextDidChange(noti: NSNotification) {
        print("textViewTextDidChange")
        let maxCount = MaxCount.number
        if let text = textView.text {
            if text.count >= maxCount {
                let maxCountIndex = text.index(text.startIndex, offsetBy: maxCount)
                let fixedText = String(text[text.startIndex..<maxCountIndex])
                textView.text = fixedText + " "
                countLabel.text = "\(maxCount)/\(maxCount)"

                let when = DispatchTime.now() + 0.01
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.textView.attributedText = NSAttributedString(string: fixedText)
                }
            }
        }
    }
}

extension BasicTextView {
    struct MaxCount {
        static var number: Int = 300
    }
    var maxCount: Int {
        get {
            MaxCount.number
        }
        set(newValue) {
            MaxCount.number = newValue
        }
    }
    
    
    struct Placeholder {
        static var text: String = "우리 밴드를 잘 보여줄 수 있는 소개를 간단히 적어주세요"
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


