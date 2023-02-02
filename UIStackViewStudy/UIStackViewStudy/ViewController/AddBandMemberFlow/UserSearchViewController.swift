//
//  BandMemberInvitation.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/31.
//

import UIKit

enum BottomScrollSection: Int {
    case main
}

class UserSearchViewController: UIViewController {

    private enum Size {
        static let cellHeight: CGFloat = 36
        static let cellContentInset: CGFloat = 50
    }

    private var tempWidth: CGFloat = 0
    
    var completion: (_ selectedUsers: [CellInformation]) -> Void = { selectedUsers in }
    
    var selectedUsers: [CellInformation] = []
    
    private lazy var searchBar = {
        let searchBar = SearchTextField(placeholder: "닉네임으로 검색")
        let action = UIAction { _ in
            if searchBar.textField.text == "" {
                self.searchResultTable.reloadData()
            }
        }
        searchBar.textField.addAction(action, for: .editingChanged)
        return searchBar
    }()
    
    private lazy var searchResultTable: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .dark01
        tableView.register(BandMemberSearchTableCell.self, forCellReuseIdentifier: BandMemberSearchTableCell.classIdentifier)
        tableView.allowsMultipleSelection = true
        
        return tableView
    }()
    
    private lazy var doneButton = {
        let button = BasicButton(text: "완료", widthPadding: 200, heightPadding: 50)
        let action = UIAction { _ in
            self.dismiss(animated: true){
                self.completion(self.selectedUsers)
            }
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomScrollView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .dark01
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.register(
            AddedBandMemberCollectionCell.self,
            forCellWithReuseIdentifier: AddedBandMemberCollectionCell.classIdentifier)
        return collectionView
    }()

    //MARK: Bottom CollectionView
    lazy var bottomScrollViewDataSource: UICollectionViewDiffableDataSource<BottomScrollSection, CellInformation> = self.makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .dark01
        setupLayout()
        
        updateSnapShot(with: selectedUsers)
    }
    
    private func setupLayout() {
        view.addSubview(searchBar)
        searchBar.constraint(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25))
        
        
        view.addSubview(doneButton)
        doneButton.constraint(bottom: view.safeAreaLayoutGuide.bottomAnchor, centerX: view.centerXAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0))

        view.addSubview(bottomScrollView)
        bottomScrollView.constraint(.heightAnchor, constant: 60)
        bottomScrollView.constraint(leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: doneButton.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))

        view.addSubview(searchResultTable)
        searchResultTable.constraint(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: bottomScrollView.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 25, bottom: 10, right: 25))
        
    }
}

//MARK: TableView datasource
extension UserSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellInformation.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BandMemberSearchTableCell.classIdentifier, for: indexPath) as? BandMemberSearchTableCell else { return UITableViewCell()}
        cell.configure(data: CellInformation.data[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}
//MARK: TableView delegate
extension UserSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedCell = tableView.cellForRow(at: indexPath) as! BandMemberSearchTableCell

        var data = CellInformation(nickName: selectedCell.titleLabel.text ?? "", instrument: selectedCell.subTitleLabel.text ?? "")
        // 선택될 때 Cell의 아이디 그대로 데이터에 넣기
        data.id = selectedCell.id

        // collectionView Cell 크기 업데이트하기
        tempWidth = data.nickName.size(withAttributes: [
            .font : UIFont.preferredFont(forTextStyle: .subheadline)
        ]).width + Size.cellContentInset

        //MARK: 이미 배열에 들어가있는 셀 없애기
        selectedUsers.append(data)
        self.updateSnapShot(with: selectedUsers)
    }

    //MARK: Deselect Function
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! BandMemberSearchTableCell
        selectedUsers.removeAll { $0.id == selectedCell.id }
        self.updateSnapShot(with: selectedUsers)
    }
}

extension UserSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //MARK: 동적 셀 크기 배정 코드 추후 추가 필요
        var cellSize = CGSize(width: 300, height: 50)
        return cellSize
    }
}

extension UserSearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.textField.becomeFirstResponder()
    }
}


//MARK: CollectionView DiffableData Source
extension UserSearchViewController {

    func updateSnapShot(with items: [CellInformation]) {
        var snapShot = NSDiffableDataSourceSnapshot<BottomScrollSection, CellInformation>()
        snapShot.appendSections([.main])
        snapShot.appendItems(items, toSection: .main)
        self.bottomScrollViewDataSource.apply(snapShot, animatingDifferences: true)
    }

    func makeDataSource() -> UICollectionViewDiffableDataSource<BottomScrollSection, CellInformation> {
        return UICollectionViewDiffableDataSource<BottomScrollSection, CellInformation>(collectionView: self.bottomScrollView, cellProvider: { collectionView, indexPath, person in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddedBandMemberCollectionCell.classIdentifier, for: indexPath) as? AddedBandMemberCollectionCell else { return UICollectionViewCell() }

            cell.configure(data: person)
            
            return cell
        })
    }

}
