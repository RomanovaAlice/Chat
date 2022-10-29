//
//  ChatViewController.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import UIKit


struct Chat: Hashable, Decodable {
    
    var username: String
    var userImage: String
    var lastMessage: String
}


class ChatViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        
        case favoritesChats
        case chats
        
        func description() -> String {
            switch self {
            case .favoritesChats:
                return "Favorite cats"
            case .chats:
                return "Chats"
            }
        }
    }
    
    let chat = [Chat(username: "", userImage: "", lastMessage: ""), Chat(username: "", userImage: "", lastMessage: "d"), Chat(username: "s", userImage: "f", lastMessage: "")]
    let chatss = [Chat(username: "v", userImage: "", lastMessage: "d"), Chat(username: "", userImage: "c", lastMessage: ""), Chat(username: "b", userImage: "", lastMessage: "d"), Chat(username: "", userImage: "", lastMessage: ";")]
    

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
    
    private func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Chat>()
        
        snapshot.appendSections([.favoritesChats, .chats])

        snapshot.appendItems(chat, toSection: .favoritesChats)
        snapshot.appendItems(chatss, toSection: .chats)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Chat>(collectionView: chatCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath)
   
            return cell
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader else { fatalError("Can not create new section header") }
            
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            
            sectionHeader.configure(text: section.description(), font: .systemFont(ofSize: 25), textColor: .black)
            
            return sectionHeader
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: createSection())
        
        return layout
    }

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
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
}
