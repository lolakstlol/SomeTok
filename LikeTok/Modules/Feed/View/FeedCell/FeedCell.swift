// swiftlint:disable large_tuple

import UIKit
import Kingfisher

protocol FeedCellActionsOutput: AnyObject {
    func moreTapAction()
    func commentsTapAction()
    func profileTapAction()
    func likeTapAction(_ tapType: LikeActionType)
    func shareTapAction(_ image: UIImage)
    func subscribeTapAction()
    func screenTapAction()
}

final class FeedCell: UICollectionViewCell {
    
    // MARK: - @IBOutlets

    @IBOutlet private var commentsLabel: UILabel!
    @IBOutlet private var likeLabel: UILabel!
    @IBOutlet private var likeImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private var topGradientView: UIView!
    @IBOutlet private var bottomGradientView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var playerContainerView: UIView!
    private var playerView: FeedPlayerVicw?
    
    //http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4
    // MARK: - Private properties

    private weak var output: FeedCellActionsOutput?
//    private lazy var blurView: UIVisualEffectView = {
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemChromeMaterialDark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = toCatalogButton.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurEffectView.layer.masksToBounds = true
//        blurEffectView.layer.cornerRadius = 12
//
//        return blurEffectView
//    }()
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setUpPlayerView()
    }

//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.isHidden = false
        playerView?.removeFromSuperview()
        playerView = nil
        imageView.isHidden = false
        userImageView.image = nil
        backgroundImageView.image = nil
        likeLabel.text = "0"
        subscribeButton.setImage(nil, for: .normal)
        setUpPlayerView()
    }
    
    // MARK: - @IBActions
        
    @IBAction private func commentsAction() {
        output?.commentsTapAction()
    }
    
    @IBAction private func likeAction() {
        output?.likeTapAction(.iconTap)
    }
    
    @IBAction private func profileAction() {
        output?.profileTapAction()
    }
    
    @IBAction private func shareAction() {
        guard let image = imageView.image else { return }
        output?.shareTapAction(image)
    }
    
    @IBAction private func subscribeAction() {
        output?.subscribeTapAction()
    }
    
    @objc private func doubleTapLikeAction() {
        output?.likeTapAction(.doubleTap)
    }
    
    @objc private func screenTapAction() {
        output?.screenTapAction()
    }
    
    // MARK: - Public methods

    func configure(_ output: FeedCellActionsOutput,
                   _ delegate: FeedPlayerDelegate,
                   _ likes: (likesCount: Int, type: LikeType, shouldShowFilledLike: Bool),
                   _ commentsCount: Int,
                   _ userImageUrlString: String,
                   _ description: String,
                   _ isReadyToPlay: Bool) {
        self.output = output
        playerView?.delegate = delegate
        updatePlayerState(isReadyToPlay)
        likeLabel.text = "\(likes.likesCount)"
        descriptionLabel.text = description
        commentsLabel.text = "\(commentsCount)"
        imageView.backgroundColor = .clear
    }
    
    func updateLikes(type: LikeType, shouldShowFilledLike: Bool) {
        let currentLikesCount = Int(likeLabel.text ?? "0") ?? .zero
        switch type {
        case .filled:
//            likeImageView.image = shouldShowFilledLike ? Asset.Assets.Feed.filledHeart.image : Asset.Assets.Feed.emptyHeart.image
//            likeImageView.wiggle(amplitude: .high)
            likeLabel.text = String(currentLikesCount + 1)
        case .empty:
//            likeImageView.image = Asset.Assets.Feed.emptyHeart.image
            likeLabel.text = String(currentLikesCount - 1)
        }
    }

    
    func loadVideo(_ url: URL?) {
        guard let url = url else { return }
        playerView?.load(with: url)
    }
    
    func updatePlayerState(_ isReadyToPlay: Bool) {
        if isReadyToPlay, playerView?.player?.status == .readyToPlay {
            imageView.isHidden = true
            playerView?.play()
        } else {
            playerView?.pause()
        }
    }
    
//    func playVideo() {
//        imageView.isHidden = true
//        playerView.play()
//    }
//
//    func stopVideo() {
////        imageView.isHidden = false
//        playerView.pause()
//    }
    
    func setupUserData(userName: String) {
        self.userName.text = userName
    }
}

// MARK: - UI

extension FeedCell {
    private func setupUI() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapLikeAction))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        
        let userLoginRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileAction))
        userName.isUserInteractionEnabled = true
        userName.addGestureRecognizer(userLoginRecognizer)
        
        let screenTap = UITapGestureRecognizer(target: self, action: #selector(screenTapAction))
        contentView.addGestureRecognizer(screenTap)
        shareButton.layer.cornerRadius = 10
        shareButton.layer.borderWidth = 1.5
        shareButton.layer.borderColor = UIColor.white.cgColor
//        userDataBottomConstraint.constant += Constants.General.safeArea?.bottom ?? .zero
        applyGradient()
    }
    
    private func applyGradient() {
        let topGradient = CAGradientLayer()
        let colors = [UIColor.black.withAlphaComponent(0.45),
                      UIColor.black.withAlphaComponent(.zero)]
        topGradient.colors = colors.map { $0.cgColor }
        
        topGradient.startPoint = CGPoint(x: 0.5, y: .zero)
        topGradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        topGradient.frame = topGradientView.bounds
        topGradientView.alpha = 0.9
        topGradientView.layer.insertSublayer(topGradient, at: 1)

        let bottomGradient = CAGradientLayer()
        bottomGradient.colors = colors.map { $0.cgColor }
        
        bottomGradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        bottomGradient.endPoint = CGPoint(x: 0.5, y: .zero)
        bottomGradient.frame = bottomGradientView.bounds
        bottomGradientView.alpha = 1
        bottomGradientView.layer.insertSublayer(bottomGradient, at: 1)
    }
    
    private func setUpPlayerView() {
        playerView = FeedPlayerVicw()
        playerContainerView.addSubview(playerView!)
            
        playerView?.translatesAutoresizingMaskIntoConstraints = false
        playerView?.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor).isActive = true
        playerView?.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor).isActive = true
        playerView?.heightAnchor.constraint(equalTo: playerContainerView.widthAnchor, multiplier: 16/9).isActive = true
        playerView?.centerYAnchor.constraint(equalTo: playerContainerView.centerYAnchor).isActive = true
    }
}
