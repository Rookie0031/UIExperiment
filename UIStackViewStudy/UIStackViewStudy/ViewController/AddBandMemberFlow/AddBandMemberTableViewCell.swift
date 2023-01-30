//
//  AddBandMemberTableViewCell.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/29.
//
import UIKit

final class AddBandMemberTableViewCell: UITableViewCell {
    
    private var cellIndex: Int = -1
    
    weak var delegate: CellDeletable?
    
    static let identifier = "TableCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.setFont(.headline01)
        label.textColor = .white
        
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.setFont(.content)
        label.textColor = .white.withAlphaComponent(0.5)
        
        return label
    }()
    
    lazy var leftView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "music.note.list")
        imageView.contentMode = .scaleToFill
        return imageView
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        attribute()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = nil
        self.subTitleLabel.text = nil
    }
    
    private func attribute() {
        self.backgroundColor = .dark01
    }
    
    private func setupLayout() {
        backgroundColor = .clear
        
        contentView.addSubview(leftView)
        leftView.constraint(.widthAnchor, constant: 35)
        leftView.constraint(.heightAnchor, constant: 35)
        leftView.constraint(leading: contentView.leadingAnchor, centerY: contentView.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        )
        
        contentView.addSubview(titleLabel)
        titleLabel.constraint(top: leftView.topAnchor, leading: leftView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.constraint(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 20))
        
        contentView.addSubview(deleteButton)
        deleteButton.constraint(.widthAnchor, constant: 25)
        deleteButton.constraint(.heightAnchor, constant: 25)
        deleteButton.constraint(trailing: contentView.trailingAnchor, centerY: contentView.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 10)
        )
    
    }
    
    func configure(data: CellInformation, index: Int) {
        self.titleLabel.text = data.nickName
        self.subTitleLabel.text = data.instrument
        self.cellIndex = index
        
        let action = UIAction { _ in
            self.delegate?.deleteCell(id: data.id)
            print("Button Tapped")
        }
        self.deleteButton.addAction(action, for: .touchUpInside)
    }
}

protocol CellDeletable: AnyObject {
    func deleteCell(id: CellInformation.ID)
}
