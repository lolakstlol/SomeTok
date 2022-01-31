//
//  FeedNewwViewController.swift
//  LikeTok
//
//  Created by Daniel on 17.01.22.
//

import UIKit
import GSPlayer

final class FeedNewwViewController: UIViewController {

    var presenter: FeedNewPresenterInput!

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var filterButtonsCollections: [UIButton]!
    
    private var cellIdentifier = String(describing: FeedTableViewCell.self)
    private var items: [FeedResponse] = []
    private var isRefreshingFeed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupTableView()
        configureRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let visibleRows = tableView.visibleCells.compactMap({ $0 as? FeedTableViewCell })
        visibleRows.forEach { $0.play() }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let visibleRows = tableView.visibleCells.compactMap({ $0 as? FeedTableViewCell })
        visibleRows.forEach { $0.pause() }
    }
     
    
    // MARK: - @IBActions
    @IBAction private func subscribesFilterTap(_ sender: UIButton) {
        updateFilterButtons(selectedButton: sender)
        presenter.updateFeedType(.subscriptions)
    }
    
    @IBAction private func advertismentFilterTap(_ sender: UIButton) {
        updateFilterButtons(selectedButton: sender)
        presenter.updateFeedType(.advertisment)
    }
    
    @IBAction private func generalFilterTap(_ sender: UIButton) {
        updateFilterButtons(selectedButton: sender)
        presenter.updateFeedType(.general)
    }
    
}

extension FeedNewwViewController: FeedNewPresenterOutput {
    func onLikeSuccess() {
        
    }
    
    func onLikeFailed() {
        
    }
    
    
    func onTapComments(_ uuid: String) {
        let commentsViewController = CommentsAssembler.createModule(uuid: uuid)
//        commentsViewController.modalPresentationStyle = .overFullScreen
//        commentsViewController.modalTransitionStyle = .coverVertical
        presentPanModal(commentsViewController)
//        present(commentsViewController, animated: true, completion: nil)
    }
    
    func onFetchFeed(_ items: [FeedResponse]) {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.items.append(contentsOf: items)
            self.tableView.reloadData()
            self.checkVideoState()
        }
    }
    
    func onChangedFilter() {
        tableView.contentOffset.y == .zero ? reloadFeed() : scrollToTop()
    }
}

private extension FeedNewwViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func scrollToTop() {
        DispatchQueue.main.async {
            self.tableView?.scrollToRow(at: .init(row: .zero, section: .zero), at: .top, animated: true)
            self.isRefreshingFeed = true
        }
    }
    
    func checkPreloading() {
        guard let lastRow = tableView.indexPathsForVisibleRows?.last?.row else { return }
        
        if items.count - lastRow < 3 {
            presenter.fetchMoreFeed()
        }
        
        let videoItems = items
            .suffix(from: min(lastRow + 1, items.count))
            .prefix(2)
            .flatMap { $0.media.map { $0.original ?? "" }}
            .compactMap { URL(string: $0 )}
        
        VideoPreloadManager.shared.set(waiting: Array(videoItems))
    }
    
    func checkVideoState() {
        let visibleCells = tableView.visibleCells.compactMap { $0 as? FeedTableViewCell }
        
        guard visibleCells.count > 0 else { return }
        
        let visibleFrame = CGRect(x: 0, y: tableView.contentOffset.y, width: tableView.bounds.width, height: tableView.bounds.height)

        let visibleCell = visibleCells
            .filter { visibleFrame.intersection($0.frame).height >= $0.frame.height / 2 }
            .first
        
        visibleCell?.play()
    }
    
    func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .lightGray
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
    
    func configuredCell(_ cell: FeedTableViewCell, _ model: FeedResponse) -> FeedTableViewCell {
        let mediaModel = model.media
        
        let previewImageString = mediaModel.first?.preview ?? ""
        let videoUrlString = mediaModel.first(where: { $0.type == .video })?.original ?? ""
        let avatarImageString = model.author.photo.preview ?? ""
        let authorName = model.author.name ?? ""
        let description = model.title ?? ""
        let likesCount = model.likes
        let isLiked = model.isLiked
        let commentsCount = model.comments
        
        if let videoUrl = URL(string: videoUrlString) {
            cell.set(videoURL: videoUrl, previewImageString: previewImageString, avatarImageString: avatarImageString)
        } else {
            cell.set(previewImageString: previewImageString, avatarImageString: avatarImageString)
        }
        cell.setupUserData(authorName: authorName,
                           description: description,
                           likesCount: likesCount,
                           isLiked: isLiked,
                           commentsCount: commentsCount)
        return cell
    }
    
    func updateFilterButtons(selectedButton: UIButton) {
        filterButtonsCollections.forEach {
            $0.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
            $0.titleLabel?.tintColor = .systemGray5
        }
        selectedButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16)
        selectedButton.titleLabel?.tintColor = .white
    }

    @objc func handleRefreshControl() {
        items.removeAll()
        presenter.reloadFeed()
    }
    
    func reloadFeed() {
        items.removeAll()
        presenter.reloadFeed()
    }
}

extension FeedNewwViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FeedTableViewCell
        cell.delegate = self
        return configuredCell(cell, items[indexPath.row])
    }
}

extension FeedNewwViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let visibleIndexPath = tableView.indexPathsForVisibleRows?.first {
            presenter.selectItem(items[visibleIndexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? FeedTableViewCell {
            cell.pause()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            checkPreloading()
            checkVideoState()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        checkPreloading()
        checkVideoState()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == .zero, isRefreshingFeed {
            reloadFeed()
        }
    }
}

extension FeedNewwViewController: FeedTableViewCellDelegate {
    func didTapCommentsButton() {
        presenter.didTapComments()
    }
    
    func didTapLikeButton() {
        presenter.likeAction()
    }
}

extension FeedNewwViewController: UIViewControllerTransitioningDelegate {
    
      func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
          return HalfSizePresentationController(presentedViewController: presented, presenting: presentingViewController)
      }
}
