//
//  PositionCollectionView.swift
//  GetARock
//
//  Created by 최동권 on 2023/01/21.
//

import UIKit

protocol PositionCollectionViewDelegate: AnyObject {
    func canSelectPosition(_ collectionView: UICollectionView, indexPath: IndexPath, selectedItemsCount: Int) -> Bool
}

enum Section: Int {
    case main
}

enum Item: Hashable {
    case bandMember(BandMember)
    case position(PositionType)
}


final class PositionCollectionView: UIView {
    
    // MARK: - Property
    
    enum CellType {
        case band
        case position
    }
    
    private var entryPoint: CellType
    weak var delegate: PositionCollectionViewDelegate?
    
    private var items: [Item] = []
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = self.makeDataSource()
    
    // MARK: - View
    
    lazy var collectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                              heightDimension: .absolute(140))
        let item1 = NSCollectionLayoutItem(layoutSize: itemSize)
        let item2 = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(140))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item1, item2])
        
        group.interItemSpacing = .fixed(5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        switch self.entryPoint {
        case .band:
            collectionView.register(BandMemberCollectionViewCell.self, forCellWithReuseIdentifier: BandMemberCollectionViewCell.classIdentifier)
        case .position:
            collectionView.register(PositionCollectionViewCell.self, forCellWithReuseIdentifier: PositionCollectionViewCell.classIdentifier)
        }
        return collectionView
    }()
    
    // MARK: - init
    
    init(entryPoint: CellType, items: [Item]) {
        self.entryPoint = entryPoint
        self.items = items
        super.init(frame: .zero)
        self.setupLayout()
        self.applySnapshot(with: items)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func setupLayout() {
        addSubview(collectionView)
        self.collectionView.constraint(to: self)
    }
}

// MARK: - diffable

extension PositionCollectionView {
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        return UICollectionViewDiffableDataSource<Section, Item>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .bandMember(let bandMember):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BandMemberCollectionViewCell.classIdentifier, for: indexPath) as? BandMemberCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(data: bandMember)
                return cell
            case .position(let position):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PositionCollectionViewCell.classIdentifier, for: indexPath) as? PositionCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(data: position)
                return cell
            }
        })
    }
    
    func applySnapshot(with items: [Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension PositionCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let selectedPositionCount = collectionView.indexPathsForSelectedItems?.count ?? 0
        guard let canSelect = delegate?.canSelectPosition(collectionView, indexPath: indexPath, selectedItemsCount: selectedPositionCount) else { return false }
        return canSelect
    }
}
