//
//  ChatViewController.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import FirebaseFirestore

final class ChatViewController: UIViewController {
    
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
    
    private let currentUser: Human
    
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
        
        view.backgroundColor = UIColor(named: "pink")
        
        self.setupCollectionView()
        self.setupDataSource()
        
        configureListener()
    }
    
    //MARK: - Deinit
    
    deinit {
        listener?.remove()
    }
    
    //MARK: - configureListener
    
    private func configureListener() {
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
    
    //MARK: - setupCollectionView
    
    private func setupCollectionView() {
        chatCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        chatCollectionView.backgroundColor = view.backgroundColor
        chatCollectionView.showsVerticalScrollIndicator = false
        chatCollectionView.delegate = self
        
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
        snapshot.appendItems(chats, toSection: .chats)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: - setupDataSource
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Chat>(collectionView: chatCollectionView, cellProvider: { collectionView, indexPath, _ in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
            
            cell.userNameLabel.text = self.chats[indexPath.row].username
            cell.lastMessageLabel.text = "How are you?"
            self.imageService.fetchImage(URLString: self.chats[indexPath.row].userAvatar, imageView: &cell.avatarImageView)
            
            return cell
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in

              guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader else {
                  fatalError("Can not create new section header") }

              sectionHeader.configure(text: "Messages", font: .systemFont(ofSize: 35), textColor: .white)

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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 15, bottom: 0, trailing: 0)
        
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

//MARK: - UICollectionViewDelegate

extension ChatViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(MessageViewController(user: currentUser, chat: chats[indexPath.row]), animated: true)
    }
}
