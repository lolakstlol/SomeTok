//
//  FeedTableViewCell.swift
//  LikeTok
//
//  Created by Daniel on 17.01.22.
//

import UIKit
import GSPlayer

protocol FeedTableViewCellDelegate: AnyObject {
    func didTapCommentsButton()
    func didTapLikeButton()
}

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var subscibeButton: UIButton!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var topGradientView: UIView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var commentsLabelCount: UILabel!
    @IBOutlet weak var bottomGradientView: UIView!
    @IBOutlet weak var playerView: VideoPlayerView!
    
    weak var delegate: FeedTableViewCellDelegate?
    
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
        imageView.image = UIImage(named: "playButton")
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.center = previewImageView.center
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addPlayerObserver()
        addTapGesture()
        addGradient()
//        previewImageView.addSubview(playImageView)
        contentView.addSubview(playImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
    }
    
    func set(videoURL: URL? = nil, previewImageString: String, avatarImageString: String) {
        self.videoURL = videoURL
        self.previewImageString = previewImageString
        self.avatarImageString = avatarImageString
    }
    
    func setupUserData(authorName: String, description: String, likesCount: Int, isLiked: Bool, commentsCount: Int) {
        userNameLabel.text = authorName
        descriptionLabel.text = description
        likesCountLabel.text = String(likesCount)
        commentsLabelCount.text = String(commentsCount)
        setupLikeState(isLiked)
    }
    
    
    func setupLikeState(_ isLiked: Bool) {
        self.isLiked = isLiked
        let currentLikesCount = Int(likesCountLabel.text ?? "0") ?? .zero
        likeImageView.image = isLiked ? UIImage(named: "filledHeart") : Assets.emptyHeart.image
        likesCountLabel.text = isLiked ? String(currentLikesCount + 1) : String(currentLikesCount)
    }
    
    func updateLikeState() {
        isLiked = !isLiked
        let currentLikesCount = Int(likesCountLabel.text ?? "0") ?? .zero
        likeImageView.image = isLiked ? UIImage(named: "filledHeart") : Assets.emptyHeart.image
        likesCountLabel.text = isLiked ? String(currentLikesCount + 1) : String(currentLikesCount - 1)
    }
    
    func play() {
        if let videoURL = videoURL {
            playerView.play(for: videoURL)
            playerView.isHidden = false
            playImageView.isHidden = true
        } else {
            playerView.isHidden = true
        }
    }
    
    func pause() {
        playerView.pause(reason: .hidden)
    }
    
    @IBAction func commentsButtonTap(_ sender: Any) {
        delegate?.didTapCommentsButton()
    }
    
    @IBAction func likeButtonTap(_ sender: Any) {
        updateLikeState()
        delegate?.didTapLikeButton()
    }
}

private extension FeedTableViewCell {
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
