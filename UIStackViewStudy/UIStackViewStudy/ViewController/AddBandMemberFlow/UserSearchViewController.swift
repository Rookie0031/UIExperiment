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
    
    var completion: (_ selectedUsers: [CellInformation]) -> Void = { selectedUsers in }
    
    private var selectedUsers: [CellInformation] = []
    
    private lazy var searchBar = {
        let searchBar = SearchTextField(placeholder: "합주실 주소 검색")
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
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.register(AddedBandMemberCollectionCell.self, forCellWithReuseIdentifier: AddedBandMemberCollectionCell.classIdentifier)
        return collectionView
    }()
    
    lazy var bottomScrollViewDataSource: UICollectionViewDiffableDataSource<BottomScrollSection, CellInformation> = self.makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .dark01
        setupLayout()
        
        updateSnapShot(with: CellInformation.data)
    }
    
    private func setupLayout() {
        view.addSubview(searchBar)
        searchBar.constraint(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25))
        
        
        view.addSubview(doneButton)
        doneButton.constraint(bottom: view.safeAreaLayoutGuide.bottomAnchor, centerX: view.centerXAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0))
        
        view.addSubview(searchResultTable)
        searchResultTable.constraint(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: doneButton.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 25, bottom: 10, right: 25))
        
        view.addSubview(bottomScrollView)
        bottomScrollView.constraint(.widthAnchor, constant: 60)
        bottomScrollView.constraint(leading: view.leadingAnchor, bottom: doneButton.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        
    }
}

//MARK: TableView delegate
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

extension UserSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected.toggle()
        let selectedCell = tableView.cellForRow(at: indexPath) as! BandMemberSearchTableCell
        let data = CellInformation(nickName: selectedCell.titleLabel.text ?? "", instrument: selectedCell.subTitleLabel.text ?? "")
        print(data.id)
        selectedUsers.append(data)
    }
}

extension UserSearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.textField.becomeFirstResponder()
    }
}

//MARK: CollectionView (Bottom Scroll view)

extension UserSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 50)
    }
}


//MARK: general methods
extension UserSearchViewController {
    func makeDataSource() -> UICollectionViewDiffableDataSource<BottomScrollSection, CellInformation> {
        return UICollectionViewDiffableDataSource<BottomScrollSection, CellInformation>(collectionView: self.bottomScrollView, cellProvider: { collectionView, indexPath, item in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddedBandMemberCollectionCell.classIdentifier, for: indexPath) as? AddedBandMemberCollectionCell else { return UICollectionViewCell() }
            
            // Configure
            
            return cell
        })
    }
    
    func updateSnapShot(with items: [CellInformation]) {
        var snapShot = NSDiffableDataSourceSnapshot<BottomScrollSection, CellInformation>()
        snapShot.appendSections([.main])
        snapShot.appendItems(items, toSection: .main)
        self.bottomScrollViewDataSource.apply(snapShot, animatingDifferences: true)
    }
}
