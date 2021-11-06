// swiftlint:disable large_tuple

import UIKit

protocol FeedCellActionsOutput: class {
    func moreTapAction()
    func commentsTapAction()
    func profileTapAction()
    func likeTapAction(_ tapType: LikeActionType)
    func shareTapAction(_ image: UIImage)
    func subscribeTapAction()
}

final class FeedCell: UICollectionViewCell {
    
    // MARK: - @IBOutlets

    @IBOutlet private var moreButton: UIButton!
    @IBOutlet private var shareLabel: UILabel!
    @IBOutlet private var commentsLabel: UILabel!
    @IBOutlet private var likeLabel: UILabel!
    @IBOutlet private var likeImageView: UIImageView!
    @IBOutlet private var userImageView: UIImageView?
    
    @IBOutlet private var userLogin: UILabel!
    @IBOutlet private var creationTime: UILabel!
    @IBOutlet private var userName: UILabel!
    @IBOutlet private var userDataBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet private var topGradientView: UIView!
    @IBOutlet private var bottomGradientView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var toCatalogButton: UIView!
    
    // MARK: - Private properties

    private weak var output: FeedCellActionsOutput?
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemChromeMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = toCatalogButton.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.masksToBounds = true
        blurEffectView.layer.cornerRadius = 12
        
        return blurEffectView
    }()
    
    // MARK: - Lifecycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView?.image = nil
        backgroundImageView.image = nil
//        likeImageView.image = Asset.Assets.Feed.emptyHeart.image
        likeLabel.text = ""
        subscribeButton.setImage(nil, for: .normal)
    }
    
    // MARK: - @IBActions
    
    @IBAction private func moreAction() {
        output?.moreTapAction()
    }
        
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
    
    // MARK: - Public methods

    func configure(_ output: FeedCellActionsOutput,
                   _ likes: (likesCount: Int, type: LikeType, shouldShowFilledLike: Bool),
                   _ commentsCount: Int,
                   _ imageUrlString: String) {
        self.output = output
        likeLabel.text = "\(likes.likesCount)"
//        likeImageView.image = (likes.type == .filled && likes.shouldShowFilledLike)
//            ? Asset.Assets.Feed.filledHeart.image
//            : Asset.Assets.Feed.emptyHeart.image
        commentsLabel.text = "\(commentsCount)"
        userImageView?.kf.setImage(with: URL(string: imageUrlString))
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
    
    func setupUserData(userLogin: String, creationTime: String, userName: String) {
        self.userLogin.text = "@" + userLogin
        self.creationTime.text = creationTime
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
        userLogin.isUserInteractionEnabled = true
        userLogin.addGestureRecognizer(userLoginRecognizer)

//        userDataBottomConstraint.constant += Constants.General.safeArea?.bottom ?? .zero
        
        toCatalogButton.insertSubview(blurView, at: 0)
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
}
