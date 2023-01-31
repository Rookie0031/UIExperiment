//
//  BandMemberInvitation.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/31.
//

import UIKit

class UserSearchViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .dark01
        self.addSubViews()
        self.configureConstraints()
        self.configureSearchCompleter()
    }

    private func addSubViews() {
        view.addSubview(searchBar)
        view.addSubview(searchResultTable)
    }

    private func configureConstraints() {
        searchBar.constraint(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25))

        searchResultTable.constraint(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 25, bottom: 10, right: 25))
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
        }
    }

extension UserSearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.searchBar.searchTextField.becomeFirstResponder()
        self.searchBar.textField.becomeFirstResponder()
    }
}

