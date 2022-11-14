//
//  UsersViewController.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import FirebaseAuth
import FirebaseFirestore
import SDWebImage

final class UsersViewController: UIViewController {
    
    private let listenerService = ListenerService()
    private let imageService = FetchImageService()

    private enum Section: Int, CaseIterable {
        case users
    }
    
    //MARK: - Properties
    private var usersCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Human>?
    private var users: [Human] = []
    private var usersListener: ListenerRegistration?
     
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersListener = listenerService.observeUsers(users: users, completion: { result in
            switch result {
                
            case .success(let users):
                self.users = users
                
                self.setupCollectionView()
                self.setupDataSource()
                self.setupSnapshot()

            case .failure(let error):
                print("listen error: ", error)
            }
        })

        view.backgroundColor = .white
    }
    
    //MARK: - Deinit
    
    deinit {
        usersListener?.remove()
    }

    //MARK: - setupCollectionView
   
   private func setupCollectionView() {
       usersCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
       usersCollectionView.backgroundColor = .white
       usersCollectionView.showsVerticalScrollIndicator = false
       
       usersCollectionView.register(UsersCell.self, forCellWithReuseIdentifier: UsersCell.identifier)
       usersCollectionView.register(SectionHeader.self,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                   withReuseIdentifier: SectionHeader.identifier)
       
       view.addSubview(usersCollectionView)
   }
   
   //MARK: - setupSnapshot
   
   private func setupSnapshot() {
       var snapshot = NSDiffableDataSourceSnapshot<Section, Human>()
       
       snapshot.appendSections([.users])
       snapshot.appendItems(users, toSection: .users)
       
       dataSource?.apply(snapshot, animatingDifferences: true)
   }
   
   //MARK: - setupDataSource
   
   private func setupDataSource() {
       dataSource = UICollectionViewDiffableDataSource<Section, Human>(collectionView: usersCollectionView, cellProvider: { [weak self] collectionView, indexPath, _ in
           
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UsersCell.identifier, for: indexPath) as! UsersCell
           
           let url = self?.users[indexPath.row].avatar
    
           self?.imageService.fetchImage(URLString: url!, imageView: &cell.photoImageView)
           cell.nameLabel.text = self?.users[indexPath.row].username
           
           return cell
       })
       
       dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
           
           guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader else {
               fatalError("Can not create new section header") }

           sectionHeader.configure(text: "\(self.users.count) peeope nearly", font: .systemFont(ofSize: 45, weight: .light), textColor: .black)
           
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
       
       item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 15, trailing: 15)
       
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(250))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
       
       let section = NSCollectionLayoutSection(group: group)

       section.contentInsets = NSDirectionalEdgeInsets.init(top: 15, leading: 15, bottom: 15, trailing: 0)

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
