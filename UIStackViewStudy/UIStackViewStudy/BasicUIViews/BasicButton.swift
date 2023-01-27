//
//  BasicButton.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/24.
//
import UIKit

final class BasicButton : UIButton {
    
    var contentText: String
    var widthPadding: Double?
    var heightPadding: Double?
    
    init(text: String, widthPadding: Double? = nil, heightPadding: Double? = nil) {
        self.contentText = text
        if let widthPadding = widthPadding { self.widthPadding = widthPadding }
        if let heightPadding = heightPadding { self.heightPadding = heightPadding }
        super.init(frame: .zero)
        titleLabel?.font = UIFont.setFont(.contentBold)
        self.setTitle(contentText, for: .normal)
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            let baseSize = super.intrinsicContentSize
            return CGSize(width: baseSize.width + (widthPadding ?? 0), height: baseSize.height + (heightPadding ?? 0))
        }
    }
}
