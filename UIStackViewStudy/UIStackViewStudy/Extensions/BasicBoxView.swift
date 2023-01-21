//
//  BasicBoxView.swift
//  UIStackViewStudy
//
//  Created by Jisu Jang on 2023/01/21.
//

import UIKit

class BasicBoxView: UIView {

    var text: String

    private lazy var basicLabel = UILabel.makeBasicLabel(labelText: text, textColor: .white, fontStyle: .body, fontWeight: .bold)

    var basicRightView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    init(text: String) {
        self.text = text
        super.init(frame: .zero)

        addSubviews(basicLabel, basicRightView)
        basicRightView.isHidden = true

        constraint(.widthAnchor, constant: DeviceSize.width * 0.9)
        constraint(.heightAnchor, constant: DeviceSize.width * 0.9 * 0.15)

        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.orange.cgColor

        basicLabel.constraint(leading: self.leadingAnchor, centerY: self.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))

        basicRightView.constraint(.widthAnchor, constant: 15)
        basicRightView.constraint(.heightAnchor, constant: 15)
        basicRightView.constraint(trailing: self.trailingAnchor, centerY: self.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20))
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
