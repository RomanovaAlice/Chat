//
//  ChatViewController.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import UIKit

final class ChatViewController: UIViewController {

    private enum Section: Int, CaseIterable {
        case chats
    }
    
    private let chatss = [Chat(username: "v", userImage: "", lastMessage: "d")]
    
    //MARK: - Properties
    private var dataSource: UICollectionViewDiffableDataSource<Section, Chat>?

    private var chatCollectionView: UICollectionView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupCollectionView()
        setupDataSource()
        setupSnapshot()
    }
    
     //MARK: - setupCollectionView
    
    private func setupCollectionView() {
        chatCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        chatCollectionView.backgroundColor = .white
        chatCollectionView.showsVerticalScrollIndicator = false
        
        chatCollectionView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
        chatCollectionView.register(SectionHeader.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: SectionHeader.identifier)
        
        view.addSubview(chatCollectionView)
    }
    
    //MARK: - setupSnapshot
    
    private func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Chat>()
        
        snapshot.appendSections([.chats])
        snapshot.appendItems(chatss, toSection: .chats)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: - setupDataSource
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Chat>(collectionView: chatCollectionView, cellProvider: { collectionView, indexPath, _ in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath)
   
            return cell
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader else {
                fatalError("Can not create new section header") }
            
            sectionHeader.configure(text: "Chats", font: .systemFont(ofSize: 25), textColor: .black)
            
            return sectionHeader
        }
    }
    
    //MARK: - createCompositionalLayout
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: createSection())
        
        return layout
    }
    
    //MARK: - createSection

    private func createSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20)

        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
    
    //MARK: - createSectionHeader
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
}
