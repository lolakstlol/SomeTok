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
}

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addPlayerObserver()
        addTapGesture()
        addGradient()
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
    }
    
    func play() {
        if let videoURL = videoURL {
            playerView.play(for: videoURL)
            playerView.isHidden = false
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
}

private extension FeedTableViewCell {
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let videoURL = videoURL {
            playerView.state == .playing ? playerView.pause(reason: .userInteraction) : playerView.play(for: videoURL)
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
}