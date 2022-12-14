//
//  MessageViewController.swift
//  Chat
//
//  Created by Алиса Романова on 17.11.2022.
//

import MessageKit
import FirebaseFirestore
import InputBarAccessoryView

class MessageViewController: MessagesViewController {

    //MARK: - Properties
    
    private var messages: [Message] = []
    
    private var messageListener: ListenerRegistration?
    private let listenerService = ListenerService()
    
    private let storageService = StorageService()
    
    //MARK: - Init
    
    private let user: Human
    private let chat: Chat
    
    init(user: Human, chat: Chat) {
        self.user = user
        self.chat = chat
        
        super.init(nibName: nil, bundle: nil)
        
        title = chat.username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.backgroundColor = UIColor(named: "gray")
        
        configureMessageInputBar()
        configureCollectionView()
        hideAvatar()
        
        configureListener()
    }
    
    //MARK: - Deinit
    
    deinit {
        messageListener?.remove()
    }
    
    //MARK: - configureListener
    
    private func configureListener() {
        messageListener = listenerService.observeMessages(chat: chat, completion: { (result) in
            switch result {
                
            case .success(let message):
                self.insertNewMessage(message: message)
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    //MARK: - hideAvatar
    
    private func hideAvatar() {
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
    }
    
    //MARK: - configureCollectionView
    
    private func configureCollectionView() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    //MARK: - configureMessageInputBar
    
    private func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.backgroundView.backgroundColor = UIColor(named: "dark-pink")
        messageInputBar.inputTextView.backgroundColor = UIColor(named: "gray")
        messageInputBar.inputTextView.placeholderTextColor = .gray
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 14, left: 15, bottom: 14, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 14, left: 21, bottom: 14, right: 36)
        messageInputBar.inputTextView.layer.borderColor = UIColor.systemGray2.cgColor
        messageInputBar.inputTextView.layer.borderWidth = 0.2
        messageInputBar.inputTextView.layer.cornerRadius = 18
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        
        messageInputBar.layer.shadowColor = UIColor.black.cgColor
        messageInputBar.layer.shadowRadius = 5
        messageInputBar.layer.shadowOpacity = 0.3
        messageInputBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        configureSendButton()
    }
    
    //MARK: - configureSendButton
    
    private func configureSendButton() {
        messageInputBar.sendButton.title = ""
        messageInputBar.sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        messageInputBar.setRightStackViewWidthConstant(to: 56, animated: false)
     
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 6, right: 30)
        messageInputBar.sendButton.setSize(CGSize(width: 48, height: 48), animated: false)
        messageInputBar.middleContentViewPadding.right = -38
    }
    
    //MARK: - insertNewMessage
    
    private func insertNewMessage(message: Message) {
        guard !messages.contains(message) else { return }
        messages.append(message)
        messages.sort()
        
        let isLatestMessage = messages.firstIndex(of: message) == (messages.count - 1)
        let shouldScrollToBottom = messagesCollectionView.isAtBottom && isLatestMessage
        
        messagesCollectionView.reloadData()
        
        if shouldScrollToBottom {
            DispatchQueue.main.async {
                self.messagesCollectionView.scrollToBottom()
            }
        }
    }
}

//MARK: - MessagesDataSource

extension MessageViewController: MessagesDataSource {
    
    func currentSender() -> MessageKit.SenderType {
        return Sender(senderId: user.id, displayName: user.username)
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.item]
    }
    
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return 1
    }
}

//MARK: - MessagesLayoutDelegate

extension MessageViewController: MessagesLayoutDelegate {
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 10)
    }
}

//MARK: - MessagesDisplayDelegate

extension MessageViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor(named: "purple")! : UIColor(named: "pink")!
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .black
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
    }
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        return .bubble
    }
}

//MARK: - InputBarAccessoryViewDelegate

extension MessageViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = Message(user: user, content: text)
        
        FirestoreService.shared.sendMessage(chat: chat, message: message) { result in
            switch result {
                
            case .success:
                self.messagesCollectionView.scrollToBottom()
                
            case .failure(let error):
                print(error)
            }
        }
        inputBar.inputTextView.text = ""
    }
}
