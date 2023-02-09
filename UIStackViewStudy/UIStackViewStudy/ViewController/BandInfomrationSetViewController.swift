//
//  ViewController.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/18.
//

import UIKit

final class BandInfomrationSetViewController: UIViewController {
    
    private let titleLabel: BasicLabel = {
        $0.numberOfLines = 2
        return $0
    }(BasicLabel(contentText: "밴드에 대해\n간단히 알려주세요", fontStyle: .largeTitle01, textColorInfo: .white))
    
    private let subTitleLabel: BasicLabel = {
        $0.numberOfLines = 2
        return $0
    }(BasicLabel(contentText: "작성해주신 정보는 내 프로필로 만들어지고\n프로필은 다른 사용자들이 볼 수 있어요", fontStyle: .headline03, textColorInfo: .white))
    
    private let bandNameLabel = TwoHstackLabel.informationLabel(guideText: "밴드 이름", inputType: .optional)
    
    private let bandIntroductionLabel = TwoHstackLabel.informationLabel(guideText: "밴드 소개", inputType: .optional)
    
    private lazy var bandNamingTextFieldView: UIView = {
        let textField = TextLimitTextField(placeholer: "밴드 이름을 입력해주세요", maxCount: 10, checkCase: .bandName)
        return textField
    }()
    
    //MARK: Textfield 변경에 따라 삭제 예정
    private lazy var checkLabel: UIStackView = TwoHstackLabel.checkLabel
    
    private let bandIntroTextView = {
        let textView = BasicTextView(placeholder: "우리 밴드를 더 잘 보여줄 수 있는 소개를 간단하게\n적어주세요(ex. 좋아하는 밴드, 밴드 경력 등)")
        return textView
    }()
    
    private lazy var titleVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var textFieldVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bandNameLabel, bandNamingTextFieldView, checkLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var textViewVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bandIntroductionLabel, bandIntroTextView])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private var practiceLabel = TwoHstackLabel.informationLabel(guideText: "합주실 위치", inputType: .optional)
    
    private var practiceSubLabel = BasicLabel(contentText: "* 지도에서 우리밴드가 보여질 위치입니다.", fontStyle: .content, textColorInfo: .white)
    
    private lazy var practicePlace = {
        let boxView = BasicBoxView(text: "합주실 위치")
        boxView.basicRightView.isHidden = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentLocationSearchView))
        boxView.addGestureRecognizer(tapGesture)
        return boxView
    }()
    
    private var detailPracticePlace = {
        let view = BasicTextField(placeholder: "상세 주소를 입력해주세요 (선택)")
        return view
    }()
    
    private lazy var practicePlaceStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [practiceLabel, practiceSubLabel, practicePlace, detailPracticePlace])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private var practiceSongLabel = TwoHstackLabel.informationLabel(guideText: "합주곡", inputType: .optional)
    
    private var practiceSongSubLabel = BasicLabel(contentText: "* 최대 3개까지 등록 가능합니다.", fontStyle: .content, textColorInfo: .white)
    
    private lazy var addPracticeSongButton = {
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont.setFont(.contentBold)
        configuration.baseBackgroundColor = .systemPurple
        configuration.attributedTitle = AttributedString("합주곡 추가", attributes: container)
        configuration.image = UIImage(systemName: "plus")
        configuration.imagePadding = 10
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0)
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.addTarget(self, action: #selector(didTapAddPracticeSong), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var practiceSongStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [practiceSongLabel, practiceSongSubLabel, addPracticeSongButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let snsTitleLabel = TwoHstackLabel.informationLabel(guideText: "SNS", inputType: .optional)
    
    private let snsSubTitleLabel = BasicLabel(contentText: "* 밴드의 SNS 계정을 입력해주세요 ", fontStyle: .content, textColorInfo: .gray02)
    
    private let snsSecondSubTitleLabel = BasicLabel(contentText: "* 본인계정이 아닌 계정 등록 시 책임은 본인에게 있습니다?", fontStyle: .content, textColorInfo: .gray02)

    private let youtubeTextField = SNSBoxView(type: .youTube, placeholder: "채널명")

    private let instagramTextField = SNSBoxView(type: .instagram, placeholder: "사용자 계정")

    private let soundCloundTextField = SNSBoxView(type: .soundCloud, placeholder: "사용자 계정")
    
    private lazy var snsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [snsTitleLabel, snsSubTitleLabel, snsSecondSubTitleLabel, youtubeTextField, instagramTextField, soundCloundTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleVstack, textFieldVstack, practicePlaceStack, practiceSongStack, textViewVstack, snsStack])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 40
        stackView.backgroundColor = .dark01
        stackView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        return stackView
    }()
    
    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = .dark01
        scrollView.delegate = self
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        render()
        setConfiguration()
        attribute()
    }
    
    private func attribute() {
        self.view.backgroundColor = .dark01
    }
    
    private func addSubviews() {
        view.addSubviews(mainScrollView)
        mainScrollView.addSubview(contentView)
    }
    
    private func render() {
        
        titleVstack.constraint(leading: view.safeAreaLayoutGuide.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        
        mainScrollView.constraint(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        contentView.constraint(top: mainScrollView.topAnchor, leading: mainScrollView.leadingAnchor, bottom: mainScrollView.bottomAnchor, trailing: mainScrollView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25))
        contentView.constraint(.widthAnchor, constant: UIScreen.main.bounds.width - 50)
        
    }
    
    //MARK: 나중에 삭제 가능
    private func setConfiguration() {
        view.backgroundColor = .systemGray
        checkLabel.isHidden = true
    }
}

extension BandInfomrationSetViewController {
    
    private func showDuplicationCheckLabel(with isChecked: Bool) {
        checkLabel.isHidden = false
        let imageView = checkLabel.arrangedSubviews.first! as! UIImageView
        imageView.image = isChecked ? UIImage(systemName: "checkmark.circle")! : UIImage(systemName: "x.circle")!
        imageView.tintColor = isChecked ? .systemBlue : .systemRed
        let label = checkLabel.arrangedSubviews.last! as! UILabel
        label.text = isChecked ? "가능합니다" : "불가능합니다"
        label.textColor = isChecked ? .systemBlue : .systemRed
    }
    
    @objc func presentLocationSearchView() {
        let mapSearchView = MapSearchViewController()
        mapSearchView.completion = { mapItem in
            print("completion Handler 작동")
            self.practicePlace.basicLabel.text = mapItem.name ?? ""
            self.practicePlace.basicRightView.isHidden = true
        }
        present(mapSearchView, animated: true)
    }
    
    @objc func didTapAddPracticeSong() {
        present(AddPracticeSongViewController(), animated: true)
    }
}

// ScrollView 가로 스크롤 막기
extension BandInfomrationSetViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           if scrollView.contentOffset.x != 0 {
               scrollView.contentOffset.x = 0
           }
       }
}
