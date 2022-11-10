//
//  UsersViewController.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import SnapKit

protocol UsersDisplayLogic: AnyObject {
    func displayData(data: UsersModels.ModelType.ViewModel.ViewModelType)
}


struct Human: Hashable, Decodable {
    let userImage: String
    let userName: String
}


final class UsersViewController: UIViewController {
    
    var router: UsersRoutingLogic?
    var interactor: UsersBuisnessLogic?
    
    private enum Section: Int, CaseIterable {
        case users
    }
    
    //MARK: - Properties
    private var usersCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Human>?
    
    private let chat = [Human(userImage: "", userName: ""), Human(userImage: "1", userName: ""), Human(userImage: "2", userName: ""), Human(userImage: "3", userName: ""), Human(userImage: "4", userName: ""), Human(userImage: "5", userName: "")]
     
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

       snapshot.appendItems(chat, toSection: .users)
       
       dataSource?.apply(snapshot, animatingDifferences: true)
   }
   
   //MARK: - setupDataSource
   
   private func setupDataSource() {
       dataSource = UICollectionViewDiffableDataSource<Section, Human>(collectionView: usersCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
           
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UsersCell.identifier, for: indexPath)

           return cell
       })
       
       dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
           
           guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader else { fatalError("Can not create new section header") }

           sectionHeader.configure(text: "\(self.chat.count) peeope nearly", font: .systemFont(ofSize: 45, weight: .light), textColor: .black)
           
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
       
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(220))
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





//MARK: - UsersDisplayLogic

extension UsersViewController: UsersDisplayLogic {
    func displayData(data: UsersModels.ModelType.ViewModel.ViewModelType) {
        switch data {
            
        }
    }
}

