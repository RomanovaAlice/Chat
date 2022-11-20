//
//  SetupProfileViewController.swift
//  Chat
//
//  Created by Алиса Романова on 28.10.2022.
//

import SnapKit

final class SetupProfileViewController: UIViewController {
 
    //MARK: - Properties
    
    let email: String
    let id: String
    
    //items
    private let items = ["Male", "Female", "None"]
    
    //buttons
    private let goToChatsButton = UIButton(title: "Go to chats!", color: .systemGreen, titleColor: .white)
    private let addingButton = UIButton()
    
    //label
    private let genderLabel = UILabel(title: "Your gender: ", textAlignment: .left)
    
    //testFields
    private let fullNameTextField = UITextField(placeholder: "Full name")
    private let aboutMeTextField = UITextField(placeholder: "About me")
    
    //imageView
    private let photoImageView = UIImageView()
    
    //segmentedControl
    private lazy var sexSegmentedControl = UISegmentedControl(items: items)
    
    private lazy var genderStackView = UIStackView(arrangedSubviews: [genderLabel, sexSegmentedControl], spacing: 20)
    private lazy var centerStackView = UIStackView(arrangedSubviews: [fullNameTextField, aboutMeTextField], spacing: 20)
    
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
        setupTestFieldsDelegates()
        createTapGesture()
        
        setuContsraints()
    }
    
    //MARK: - createTapGesture
    
    private func createTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - setupTestFieldsDelegates
    
    private func setupTestFieldsDelegates() {
        fullNameTextField.delegate = self
        aboutMeTextField.delegate = self
    }
    
    //MARK: - setupAddingButton
    
    private func setupAddingButton() {
        addingButton.setImage(UIImage(systemName: "plus.app.fill"), for: .normal)
        addingButton.tintColor = .systemGreen
        addingButton.clipsToBounds = true
        addingButton.addTarget(self, action: #selector(addingButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - setupSexSegmentedControl
    
    private func setupSexSegmentedControl() {
        sexSegmentedControl.selectedSegmentIndex = 2
    }
    
    //MARK: - setupPhotoImageVeiw

    private func setupPhotoImageVeiw() {
        photoImageView.layer.cornerRadius = 10
        photoImageView.backgroundColor = .systemGray5
        photoImageView.clipsToBounds = true
    }
    
    //MARK: - setupPhotoImageVeiw
    
    private func setupGoToChatsButton() {
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc "hideKeyboard"
    
    @objc private func hideKeyboard() {
        aboutMeTextField.resignFirstResponder()
        fullNameTextField.resignFirstResponder()
    }
    
    //MARK: - @objc goToChatsButtonTapped
    
    @objc private func goToChatsButtonTapped() {
        
        let username = fullNameTextField.text
        let description = aboutMeTextField.text
        let sex = sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)
        let avatar = photoImageView.image
        
        let userData = Human(username: username!,
                                 email: email,
                                 avatar: "not exist",
                                 description: description!,
                                 sex: sex!,
                                 id: id)

        FirestoreService.shared.saveProfile(userData: userData, avatar: avatar) { [weak self] result in
                switch result {

                case .success(let user):
                    FirestoreService.shared.currentUser = user
                    
                    let tabBar = TabBarController(currentUser: user)
                    tabBar.modalPresentationStyle = .fullScreen

                    self?.present(tabBar, animated: true)

                case .failure(let error):
                    self?.showErrorAlert(message: error.localizedDescription)
                }
            }
    }
    
    //MARK: - @objc addingButtonTapped
    
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

        //photoImageView
        
        view.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(120)
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(200)
            make.width.equalTo(150)
        }
        
        //addingButton
        
        view.addSubview(addingButton)
        
        addingButton.snp.makeConstraints { make in
            make.centerY.equalTo(photoImageView)
            make.left.equalTo(photoImageView.snp.right).offset(10)
        }
        
        //goToChatsButton
        
        goToChatsButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        //centerStackVeiw
        
        view.addSubview(centerStackView)
        
        centerStackView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        //genderStackView
        
        view.addSubview(genderStackView)
        
        genderStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(centerStackView.snp.bottom).offset(50)
        }
        
        //goToChatsButton
        
        view.addSubview(goToChatsButton)
        
        goToChatsButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(70)
        }
    }
}

//MARK: - UIImagePickerControllerDelegate

extension SetupProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        photoImageView.image = image
    }
}

//MARK: - UITextFieldDelegate

extension SetupProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
