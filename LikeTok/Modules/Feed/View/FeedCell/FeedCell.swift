// swiftlint:disable large_tuple

import UIKit
import Kingfisher
import GSPlayer

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
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var playerView: VideoPlayerView!
    
    //http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4
    // MARK: - Private properties

    private weak var output: FeedCellActionsOutput?
    
    private var isLiked: Bool = false
    private var videoURL: URL?
    private var previewImageString: String? {
        didSet {
            if let previewImageString = previewImageString,
               let previewImageURL = URL(string: previewImageString) {
                previewImageView.isHidden = false
                previewImageView.kf.setImage(with: previewImageURL)
            } else {
                previewImageView.isHidden = true
            }
        }
    }
    
    private var avatarImageString: String? {
        didSet {
            if let avatarImageString = avatarImageString,
               let avatarImageURL = URL(string: avatarImageString) {
                avatarImageView.isHidden = false
                avatarImageView.kf.setImage(with: avatarImageURL)
            } else {
                avatarImageView.isHidden = true
            }
        }
    }
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.5).cgColor,
            UIColor.black.withAlphaComponent(0.25).cgColor,
            UIColor.black.withAlphaComponent(0.25).cgColor,
            UIColor.black.withAlphaComponent(0.9).cgColor,
        ]
        gradient.locations = [0, 0.25, 0.5, 1]
        return gradient
    }()
    
    private lazy var playImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.playButton.image.withAlpha(0.5)
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.center = previewImageView.center
        imageView.isHidden = true
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addPlayerObserver()
        addTapGesture()
        contentView.addSubview(playImageView)
//        playerView.currentBufferDuration = TimeInterval(5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradient()
        shareView.layer.cornerRadius = 10
        shareView.layer.borderColor = UIColor.white.cgColor
        shareView.layer.borderWidth = 1.5
        shareView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        videoURL = nil
        playerView.isHidden = true
        avatarImageView.isHidden = true
        previewImageView.isHidden = false
        playImageView.isHidden = true
        likeImageView.image = Assets.emptyHeart.image
        likesCountLabel.text = "0"
    }
    
    func set(videoURL: URL? = nil, previewImageString: String, avatarImageString: String) {
        self.videoURL = videoURL
        self.previewImageString = previewImageString
        self.avatarImageString = avatarImageString
    }
    
    func setupUserData(authorName: String, description: String, likesCount: Int, isLiked: Bool, commentsCount: Int) {
        usernameLabel.text = authorName
        descriptionLabel.text = description
        likesCountLabel.text = String(likesCount)
        commentsCountLabel.text = String(commentsCount)
        setupLikeState(isLiked)
    }
    
    func update(_ output: FeedCellActionsOutput, likes: (likesCount: Int, type: LikeType, shouldShowFilledLike: Bool), commentsCount: Int) {
        self.output = output
        self.commentsCountLabel.text = String(commentsCount)
        self.likesCountLabel.text = String(likes.likesCount)
        self.setupLikeState(likes.shouldShowFilledLike)
    }
    
    func setupLikeState(_ isLiked: Bool) {
        self.isLiked = isLiked
        likeImageView.image = isLiked ? Assets.filledHeart.image : Assets.emptyHeart.image
    }
    
    func play() {
        if let videoURL = videoURL {
            debugPrint("play video for \(videoURL.absoluteString), author \(usernameLabel.text)")
            DispatchQueue.main.async {
                self.playerView.play(for: videoURL)
                self.playerView.isHidden = false
                self.playImageView.isHidden = true
            }
        } else {
            playerView.isHidden = true
        }
    }
    
    func pause() {
        playerView.pause(reason: .hidden)
    }
    
    @IBAction func showProfileButtonTap(_ sender: Any) {
        output?.profileTapAction()
    }
    
    @IBAction func commentsButtonTap(_ sender: Any) {
        output?.commentsTapAction()
    }
    
    @IBAction func likeButtonTap(_ sender: Any) {
        output?.likeTapAction(.iconTap)
    }
}

private extension FeedCell {
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let videoURL = videoURL {
            if playerView.state == .playing {
                playImageView.isHidden = false
                playerView.pause(reason: .userInteraction)
            } else{
                playImageView.isHidden = true
                playerView.play(for: videoURL)
            }
        }
    }
    
    func addPlayerObserver() {
        playerView.stateDidChanged = { [weak self] state in
            switch state {
            case .none:
                print("none")
            case .error(let error):
                print("error - \(error.localizedDescription)")
            case .loading:
                print("loading")
            case .paused(let playing, let buffering):
                print("paused - progress \(Int(playing * 100))% buffering \(Int(buffering * 100))%")
            case .playing:
                self?.previewImageView.isHidden = true
                print("playing")
            }
        }
    }
    
    func addGradient() {
        gradient.frame = contentView.bounds
        contentView.layer.insertSublayer(gradient, at: 2)
    }
    
    func addLabelReadMoreTrailing() {
        if descriptionLabel.text?.count ?? 0 > 1 {

           let readmoreFont = UIFont(name: "Roboto-Regular", size: 12.0)
            let readmoreFontColor = UIColor(red: 28/255, green: 125/255, blue: 228/255, alpha: 1)
            DispatchQueue.main.async {
                self.descriptionLabel.addTrailing(with: "... ", moreText: "Readmore", moreTextFont: readmoreFont!, moreTextColor: readmoreFontColor)
            }
        }
    }
}
