//
//  ChatViewController.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import FirebaseFirestore

final class ChatViewController: UIViewController {
    
    private let currentUser: Human
    
    private enum Section: Int, CaseIterable {
        case chats
    }
    
    //MARK: - Properties
    private let imageService = FetchImageService()
    private let service = ListenerService()
    private var listener: ListenerRegistration?
    
    private var chats: [Chat] = []
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Chat>?
    
    private var chatCollectionView: UICollectionView!
    
    //MARK: - Init
    
    init(currentUser: Human) {
        self.currentUser = currentUser
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.setupCollectionView()
        self.setupDataSource()
        
        listener = service.observeChats(chats: chats, completion: { result in
            switch result {
                
            case .success(let chats):
                self.chats = chats
                
                self.setupSnapshot()
                
            case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        })
    }
    
    //MARK: - Deinit
    
    deinit {
        listener?.remove()
    }
    
    //MARK: - setupCollectionView
    
    private func setupCollectionView() {
        chatCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        chatCollectionView.backgroundColor = .white
        chatCollectionView.showsVerticalScrollIndicator = false
        chatCollectionView.delegate = self
        
        chatCollectionView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
        
        view.addSubview(chatCollectionView)
    }
    
    //MARK: - setupSnapshot
    
    private func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Chat>()
        
        snapshot.appendSections([.chats])
        snapshot.appendItems(chats, toSection: .chats)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: - setupDataSource
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Chat>(collectionView: chatCollectionView, cellProvider: { collectionView, indexPath, _ in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
            
            cell.userNameLabel.text = self.chats[indexPath.row].username
            self.imageService.fetchImage(URLString: self.chats[indexPath.row].userAvatar, imageView: &cell.avatarImageView)
            
            return cell
        })
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
        
        //        section.interGroupSpacing = 10
        //        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
}

//MARK: - UICollectionViewDelegate

extension ChatViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(MessageViewController(user: currentUser, chat: chats[indexPath.row]), animated: true)
    }
}
