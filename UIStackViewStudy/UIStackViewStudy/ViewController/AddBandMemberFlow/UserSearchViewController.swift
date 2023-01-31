//
//  BandMemberInvitation.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/31.
//

import UIKit

class UserSearchViewController: UIViewController {

    var completion: (_ selectedUsers: [CellInformation]) -> Void = { selectedUsers in }

    private var selectedUsers: [CellInformation] = []
    
    private lazy var searchBar = {
        let searchBar = SearchTextField(placeholder: "합주실 주소 검색")
        searchBar.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .dark01
        self.setupLayout()
        self.configureSearchCompleter()
    }

    private func setupLayout() {
        view.addSubview(searchBar)
        searchBar.constraint(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25))


        view.addSubview(doneButton)
        doneButton.constraint(bottom: view.safeAreaLayoutGuide.bottomAnchor, centerX: view.centerXAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0))

        view.addSubview(searchResultTable)
        searchResultTable.constraint(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: doneButton.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 25, bottom: 10, right: 25))

        //        doneButton.constraint(.widthAnchor, constant: 300)
        //        doneButton.constraint(.heightAnchor, constant: 55)
    }

    private func configureSearchCompleter() {
        //        self.searchCompleter.delegate = self
    }
}

extension UserSearchViewController {
    @objc func textFieldDidChange(_ sender: Any?) {
        if searchBar.textField.text == "" {
            //            searchResults.removeAll()
            searchResultTable.reloadData()
        }
        // 사용자가 search bar 에 입력한 text를 자동완성 대상에 넣는다
    }
}

extension UserSearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellInformation.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BandMemberSearchTableCell.classIdentifier, for: indexPath) as? BandMemberSearchTableCell else { return UITableViewCell()}
        cell.configure(data: CellInformation.data[indexPath.row], index: indexPath.row)
        cell.selectionStyle = .none

        //        let searchResult = searchResults[indexPath.row]
        //        cell.setUI(mapSearchResult: searchResult)

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
        selectedUsers.append(data)
    }
}

extension UserSearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        self.searchBar.searchTextField.becomeFirstResponder()
        self.searchBar.textField.becomeFirstResponder()
    }
}

