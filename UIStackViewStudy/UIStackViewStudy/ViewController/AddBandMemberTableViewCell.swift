//
//  AddBandMemberTableViewCell.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/29.
//
import UIKit

final class AddBandMemberTableViewCell: UITableViewCell {
    
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
    
    lazy var rightView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "x.circle.fill")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        self.backgroundColor = .dark01
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = nil
        self.subTitleLabel.text = nil
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
        
        contentView.addSubview(rightView)
        rightView.constraint(.widthAnchor, constant: 25)
        rightView.constraint(.heightAnchor, constant: 25)
        rightView.constraint(trailing: contentView.trailingAnchor, centerY: contentView.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 10)
        )
    
    }
    
    func configure(data: CellInformation) {
        self.titleLabel.text = data.nickName
        self.subTitleLabel.text = data.instrument
    }
}
