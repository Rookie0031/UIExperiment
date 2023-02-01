//
//  CategoryCollectionViewCell.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/20.
//

import UIKit

final class AddedBandMemberCollectionCell: UICollectionViewCell, Identifiable {
    
    // MARK: - properties
    
    var id: String = ""
    
    private let backgroundContentView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.backgroundColor = .activeGradationPurple
        return view
    }()
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
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
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func setupLayout() {
        addSubview(backgroundContentView)
        backgroundContentView.constraint(to: self)
        
        backgroundContentView.addSubview(itemLabel)
        itemLabel.constraint(leading: contentView.safeAreaLayoutGuide.leadingAnchor, centerY: contentView.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        
        backgroundContentView.addSubview(deleteButton)
        deleteButton.constraint(trailing: contentView.safeAreaLayoutGuide.trailingAnchor, centerY: contentView.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20))
    }
    
    func configure(data: CellInformation) {
        self.itemLabel.text = data.nickName
        self.id = data.id
    }
}
