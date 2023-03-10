//
//  BandMemberAddTableHeader.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/29.
//

import UIKit

final class AddBandMemberTableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: 이 뷰를 업로드할 때, 서버에 UID를 날리고 그 UID에 해당하는 닉네임을 업데이트해야함
    private let stepLabel = BasicLabel(contentText: "2/3", fontStyle: .caption, textColorInfo: .gray02)
    
    private let titleLabel = {
        let label = BasicLabel(contentText: "밴드 멤버를\n알려주세요",
                               fontStyle: .largeTitle01,
                               textColorInfo: .white)
        label.numberOfLines = 2
        return label
    }()
    
    private let subTitleLabel = {
        let label = BasicLabel(contentText: "처음 선택한 악기가\n나의 Main 포지션이 됩니다.",
                               fontStyle: .content,
                               textColorInfo: .gray02)
        label.numberOfLines = 2
        return label
    }()
    
    let inviteMemberButton = BasicButton(text: "멤버 초대")
    
    let inviteUnRegisteredMemberButton = BasicButton(text: "미가입 회원 추가")
    
    private let sectionTitle = BasicLabel(contentText: "밴드 멤버 3인", fontStyle: .content, textColorInfo: .white)
    
    private lazy var buttonHstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [inviteMemberButton, inviteUnRegisteredMemberButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var titleVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stepLabel, titleLabel, subTitleLabel, buttonHstack, sectionTitle])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleVstack)
        titleVstack.constraint(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.safeAreaLayoutGuide.leadingAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, trailing: contentView.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        
        contentView.backgroundColor = .dark01
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
