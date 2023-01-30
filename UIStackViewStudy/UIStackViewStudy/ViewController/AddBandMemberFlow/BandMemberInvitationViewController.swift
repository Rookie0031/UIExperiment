//
//  BandMemberInvitation.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/31.
//

import UIKit

class BandMemberInvitationViewController: UIViewController {

    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    
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
        tableView.register(MapSearchResultTableViewCell.self, forCellReuseIdentifier: MapSearchResultTableViewCell.identifier)

        return tableView
    }()
    
    //MARK: Google Map으로 현재 위치 바꿔야함...
    private let currentLocationButton = {
        let button = BasicButton(text: "현재 위치", widthPadding: 20, heightPadding: 10)
        button.setImage(UIImage(systemName: "scope"), for: .normal)
        button.backgroundColor = .systemPurple
        button.tintColor = . white
        button.layer.cornerRadius = 8
        return button
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
        view.addSubview(currentLocationButton)
    }

    private func configureConstraints() {
        searchBar.constraint(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25))
        
        currentLocationButton.constraint(top: searchBar.bottomAnchor, leading: searchBar.leadingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        
        searchResultTable.constraint(top: currentLocationButton.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 25, bottom: 10, right: 25))
    }

    private func configureSearchCompleter() {
        self.searchCompleter.delegate = self
    }
}

extension BandMemberInvitationViewController {
    @objc func textFieldDidChange(_ sender: Any?) {
        if searchBar.textField.text == "" {
            searchResults.removeAll()
            searchResultTable.reloadData()
        }
      // 사용자가 search bar 에 입력한 text를 자동완성 대상에 넣는다
        }
}

extension BandMemberInvitationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MapSearchResultTableViewCell.identifier, for: indexPath) as? MapSearchResultTableViewCell else { return UITableViewCell()}

        let searchResult = searchResults[indexPath.row]
        cell.setUI(mapSearchResult: searchResult)

        return cell
    }
}

extension BandMemberInvitationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
//        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
//        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard error == nil else { return }
            guard let mapItem = response?.mapItems.first else { return }
            self.dismiss(animated: true){
                print("함수 종료")
                self.completion(mapItem)
            }
        }
    }
}

extension BandMemberInvitationViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.searchBar.searchTextField.becomeFirstResponder()
        self.searchBar.textField.becomeFirstResponder()
    }
}

