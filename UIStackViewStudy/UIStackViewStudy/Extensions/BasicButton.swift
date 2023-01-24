//
//  BasicButton.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/24.
//
import UIKit

final class BasicButton : UIButton {
    
    var widthPadding: Double?
    var heightPadding: Double?
    
    init(widthPadding: Double? = nil, heightPadding: Double? = nil) {
        if let widthPadding = widthPadding { self.widthPadding = widthPadding }
        if let heightPadding = heightPadding { self.heightPadding = heightPadding }
        super.init(frame: .zero)
        setTitle("중복 확인", for: .normal)
        titleLabel?.font = UIFont.setFont(.contentBold)
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
