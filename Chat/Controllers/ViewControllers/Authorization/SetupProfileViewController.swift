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
    private let goToChatsButton = UIButton(title: "Go to chats!", color: UIColor(named: "bright-pink"), titleColor: .white)
    private let addingButton = UIButton(title: "Add new photo", color: UIColor(named: "bright-pink")!, cornerRadius: 5, titleColor: .white)
    
    //label
    private let genderLabel = UILabel(title: "Your gender: ", textAlignment: .left, textColor: .white)
    
    //testFields
    private let fullNameTextField = UITextField(placeholder: "Full name")
    private let aboutMeTextField = UITextField(placeholder: "About me")
    
    //imageView
    private let photoImageView = UIImageView()
    
    //segmentedControl
    private lazy var sexSegmentedControl = UISegmentedControl(items: items)
    
    //other
    private let topBackgroundView = UIView()
    private let bottomBackgroundView = UIView()
    private let picture = UIImageView(image: UIImage(named: "1"))
    
    //stackView
    private lazy var genderStackView = UIStackView(arrangedSubviews: [genderLabel, sexSegmentedControl], spacing: 20)
    private lazy var textFieldStackView = UIStackView(arrangedSubviews: [fullNameTextField, aboutMeTextField], spacing: 20)
    
    private lazy var generalStackView = UIStackView(arrangedSubviews: [textFieldStackView, genderStackView, goToChatsButton], spacing: 50)
    
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

        self.setTapGesture(action: #selector(hideKeyboard))

        setupViewsBackgroundColor()
        setupSexSegmentedControl()
        setupPhotoImageVeiw()
        addTargetsToButtons()
        setupTestFieldsDelegates()
        
        setuContsraints()
    }
    
    //MARK: - setupViewsBackgroundColor
    
    private func setupViewsBackgroundColor() {
        view.backgroundColor = UIColor(named: "light-green")
        topBackgroundView.backgroundColor = UIColor(named: "dark-green")
        bottomBackgroundView.backgroundColor = UIColor(named: "dark-green")
        bottomBackgroundView.layer.cornerRadius = 10
    }

    //MARK: - setupTestFieldsDelegates
    
    private func setupTestFieldsDelegates() {
        fullNameTextField.delegate = self
        aboutMeTextField.delegate = self
    }
    
    //MARK: - setupSexSegmentedControl
    
    private func setupSexSegmentedControl() {
        sexSegmentedControl.selectedSegmentIndex = 2
        sexSegmentedControl.backgroundColor = UIColor(named: "dark-dark-green")
    }
    
    //MARK: - setupPhotoImageVeiw

    private func setupPhotoImageVeiw() {
        photoImageView.layer.cornerRadius = 10
        photoImageView.backgroundColor = UIColor(named: "gray")
        photoImageView.clipsToBounds = true
    }
    
    //MARK: - addTargetsToButtons
    
    private func addTargetsToButtons() {
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
        addingButton.addTarget(self, action: #selector(addingButtonTapped), for: .touchUpInside)
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
        
        //topBackgroundView
        
        view.addSubview(topBackgroundView)
        
        topBackgroundView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(80)
            make.height.equalTo(170)
        }
        
        //photoImageView
        
        view.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(110)
            make.height.equalTo(200)
            make.width.equalTo(150)
        }
        
        //bottomBackgroundView
        
        view.addSubview(bottomBackgroundView)
        
        bottomBackgroundView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(photoImageView.snp.bottom).offset(60)
        }
        
        //picture
        
        view.addSubview(picture)
        
        picture.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.right.equalToSuperview().inset(7)
            make.bottom.equalTo(bottomBackgroundView.snp.top)
        }
        
        //generalStackView
        
        bottomBackgroundView.addSubview(generalStackView)
        
        generalStackView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(30)
        }
        
        //addingButton
        
        view.addSubview(addingButton)
        
        addingButton.snp.makeConstraints { make in
            make.centerX.equalTo(photoImageView)
            make.top.equalTo(photoImageView.snp.bottom).inset(10)
            make.height.equalTo(35)
            make.width.equalTo(120)
        }
        
        //goToChatsButton
        
        goToChatsButton.snp.makeConstraints { make in
            make.height.equalTo(60)
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
