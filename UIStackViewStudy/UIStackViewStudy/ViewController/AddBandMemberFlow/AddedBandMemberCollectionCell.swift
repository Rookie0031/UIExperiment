//
//  CategoryCollectionViewCell.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/20.
//

import UIKit

final class AddedBandMemberCollectionCell: UICollectionViewCell {

    // MARK: - properties

    private let backgroundContentView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.backgroundColor = .purple
        return view
    }()
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        return label
    }()

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
        addSubview(backgroundContentView)
        backgroundContentView.constraint(to: self)

        backgroundContentView.addSubview(itemLabel)
        itemLabel.constraint(
            leading: self.leadingAnchor,
            trailing: self.trailingAnchor,
            centerY: self.centerYAnchor,
            padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14))
    }

    private func configUI() {
        backgroundContentView.layer.cornerRadius = 10
    }


    func configure(data: CellInformation) {
        itemLabel.text = data.nickName
    }
}
