//
//  CategoryCollectionViewCell.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/20.
//

import UIKit

final class AddedBandMemberCollectionCell: UICollectionViewCell, Identifiable {

    // MARK: - properties
    var id: String = "default"

    private let backgroundContentView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.backgroundColor = .purple
        return view
    }()
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .white
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        $0.setImage(UIImage(
            systemName: "xmark.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)),
            for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .gray02
        $0.setContentHuggingPriority(UILayoutPriority(rawValue: 500),
                                     for: .horizontal)
        $0.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 760),
                                                   for: .horizontal)
        return $0
    }(UIButton(type: .custom))

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:  Cell Resue Prepare
    override func prepareForReuse() {
    }

    // MARK: - func

    private func render() {
        contentView.addSubview(backgroundContentView)
        backgroundContentView.constraint(to: self)

        backgroundContentView.addSubview(itemLabel)
        itemLabel.constraint(
            leading: self.leadingAnchor,
            trailing: self.trailingAnchor,
            centerY: self.centerYAnchor,
            padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
        
        backgroundContentView.addSubview(deleteButton)
        deleteButton.constraint(.widthAnchor, constant: 25)
        deleteButton.constraint(.heightAnchor, constant: 25)
        deleteButton.constraint(trailing: backgroundContentView.trailingAnchor, centerY: backgroundContentView.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 10))
        
        
    }

    private func configUI() {
        backgroundContentView.layer.cornerRadius = 10
    }


    func configure(data: CellInformation) {
        itemLabel.text = data.nickName
        self.id = data.id
    }
}
