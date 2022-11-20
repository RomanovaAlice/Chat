//
//  UsersViewController.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import FirebaseAuth
import FirebaseFirestore

final class UsersViewController: UIViewController {

    private enum Section: Int, CaseIterable {
        case users
    }
    
    //MARK: - Properties
    private let listenerService = ListenerService()
    private let imageService = FetchImageService()
    
    private var usersListener: ListenerRegistration?
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Human>!
    
    private var usersCollectionView: UICollectionView!

    private var users: [Human] = []

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.setupCollectionView()
        self.setupDataSource()
        
        usersListener = listenerService.observeUsers(users: users, completion: { result in
            switch result {
                
            case .success(let users):
                self.users = users
                
                self.setupSnapshot()
    
            case .failure(let error):
                print("listen error: ", error)
            }
        })
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
       usersCollectionView.delegate = self
       
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
           cell.descriptionLabel.text = self?.users[indexPath.row].description
           cell.genderLabel.text = self?.users[indexPath.row].sex
           
           return cell
       })
       
       dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in

             guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader else {
                 fatalError("Can not create new section header") }

           sectionHeader.configure(text: "People nearly you", font: .systemFont(ofSize: 35), textColor: .black)

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

       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                             heightDimension: .fractionalHeight(1))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       
       item.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 20, trailing: 10)
       
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(0.65))
       let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
       
       let section = NSCollectionLayoutSection(group: group)
       section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 15, bottom: 10, trailing: 15)
       
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

extension UsersViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showAlertGoToChat { _ in

            FirestoreService.shared.createChat(friend: self.users[indexPath.row]) { [weak self] result in
                switch result {
                    
                case .success:
                    self?.tabBarController?.selectedIndex = 1
                
                case .failure(let error):
                    self?.showErrorAlert(message: error.localizedDescription)
                }
            }
        }
    }
}
