//
//  SetupProfileViewController.swift
//  Chat
//
//  Created by Алиса Романова on 28.10.2022.
//

import SnapKit

final class SetupProfileViewController: UIViewController {
    
    private let service = AuthorizationService()
 
    //MARK: - Properties
    
    let email: String
    let id: String
    
    //items
    private let items = ["Male", "Female"]
    
    //title
    private let titleLabel = UILabel(title: "Set up profile", font: .systemFont(ofSize: 30))
    
    //labels
    private let fullNameLabel = UILabel(title: "Full name", textAlignment: .left)
    private let aboutMeLabel = UILabel(title: "About me", textAlignment: .left)
    private let sexLabel = UILabel(title: "Sex", textAlignment: .left)
    
    //buttons
    private let goToChatsButton = UIButton(title: "Go to chats!", color: UIColor(named: "purple")!, titleColor: .white)
    private let addingButton = UIButton()
    
    //testFields
    private let fullNameTextField = UITextField(placeholder: "Bob Robinson", textColor: .gray)
    private let aboutMeTextField = UITextField(placeholder: "i can tell you a very funny joke", textColor: .gray)
    
    //imageView
    private let photoImageView = UIImageView()
    
    //segmentedControl
    private lazy var sexSegmentedControl = UISegmentedControl(items: items)
    
    //stackViews
    private lazy var fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTextField], spacing: 10)
    private lazy var aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTextField], spacing: 10)
    private lazy var sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl], spacing: 20)
    
    private lazy var centerStackView = UIStackView(arrangedSubviews: [fullNameStackView, aboutMeStackView, sexStackView, goToChatsButton], spacing: 35)
    
    //MARK: - Init
    
    init(email: String, id: String) {
        self.email = email
        self.id = id
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupAddingButton()
        setupSexSegmentedControl()
        setupPhotoImageVeiw()
        setupGoToChatsButton()
        
        setuContsraints()
    }
    
    private func setupAddingButton() {
        addingButton.setImage(UIImage(named: "add"), for: .normal)
        addingButton.clipsToBounds = true
        addingButton.addTarget(self, action: #selector(addingButtonTapped), for: .touchUpInside)
    }
    
    private func setupSexSegmentedControl() {
        sexSegmentedControl.selectedSegmentIndex = 1
    }

    private func setupPhotoImageVeiw() {
        photoImageView.layer.cornerRadius = 65
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.borderColor = UIColor(named: "purple")!.cgColor
        photoImageView.image = UIImage(named: "userMessage")
        photoImageView.clipsToBounds = true
    }
    
    private func setupGoToChatsButton() {
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
    }
    
    @objc private func goToChatsButtonTapped() {
        
        let username = fullNameTextField.text
        let description = aboutMeTextField.text
        let sex = sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)
        let avatar = photoImageView.image
        
        if Validators.isAllFieldsFilled(username: username, description: description) {

            service.saveProfile(email: email,
                                username: username!,
                                avatar: avatar!,
                                description: description!,
                                sex: sex!,
                                id: id) { [weak self] result in

                switch result {

                case .success(_):
                    let tabBar = TabBarController()
                    tabBar.modalPresentationStyle = .fullScreen
                    
                    self?.present(tabBar, animated: true)

                case .failure(let error):
                    print("Failed to save profile", error)
                }
            }
        }
    }
    
    @objc private func addingButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
}





//MARK: - Setup constraints

extension SetupProfileViewController {
    private func setuContsraints() {
        
        //titleLabel
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(90)
            make.centerX.equalToSuperview()
        }
        
        //photoImageView
        
        view.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(120)
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.height.width.equalTo(130)
        }
        
        //addingButton
        
        view.addSubview(addingButton)
        
        addingButton.snp.makeConstraints { make in
            make.top.equalTo(photoImageView).inset(100)
            make.left.equalTo(photoImageView.snp.right).offset(-10)
            make.height.width.equalTo(30)
        }
        
        //goToChatsButton
        
        goToChatsButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        //centerStackVeiw
        
        view.addSubview(centerStackView)
        
        centerStackView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }
    }
}

//MARK: - UIImagePickerControllerDelegate

extension SetupProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        photoImageView.image = image
    }
}
