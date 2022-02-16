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
    @IBOutlet private var generalButton: UIButton!
    @IBOutlet private var filterButtonsCollections: [UIButton]!
    
    private var cellIdentifier = String(describing: FeedTableViewCell.self)
    private var items: [FeedResponse] = []
    private var newItems: [FeedResponse] = []
    
    private var isFirstAppUse: Bool = true
    
    private var isRefreshingFeed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupTableView()
        configureRefreshControl()
        setupFilterButtons()
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
        for i in items.indices where items[i].uuid == presenter.selectedUUID {
            items[i].isLiked = !items[i].isLiked
        }
    }
    
    func onLikeFailed() {
        
    }
    
    
    func onTapComments(_ uuid: String) {
//        let commentsViewController = CommentsAssembler.createModule(uuid: uuid)
//        presentPanModal(commentsViewController)
    }
    
    func onFetchFeed(_ newItems: [FeedResponse]) {
//            self.tableView.refreshControl?.endRefreshing()
//            self.items.append(contentsOf: items)
//            self.tableView.reloadData()
//            self.checkVideoState()
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            var indexPaths = [IndexPath]()
            for row in (self.items.count..<(self.items.count + newItems.count)) {
              indexPaths.append(IndexPath(row: row, section: 0))
            }
            self.items.append(contentsOf: newItems)
            self.tableView.insertRows(at: indexPaths, with: .automatic)
            self.tableView.endUpdates()
        }

//        tableView.refreshControl?.endRefreshing()
//        checkVideoState()
    }
    
    func insertNewItems() {
        tableView.beginUpdates()
        var indexPaths = [IndexPath]()
        for row in (items.count..<(items.count + newItems.count)) {
          indexPaths.append(IndexPath(row: row, section: 0))
        }
        items.append(contentsOf: newItems)
        debugPrint(indexPaths)
        tableView.insertRows(at: indexPaths, with: .none)
        tableView.endUpdates()
    }
    
    func onChangedFilter() {
        tableView.contentOffset.y == .zero ? reloadFeed() : scrollToTop()
    }
}

private extension FeedNewwViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.isPagingEnabled = true
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
        
        if items.count - lastRow < 5 {
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
    
    func setupFilterButtons() {
        filterButtonsCollections.forEach {
            $0.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
            $0.titleLabel?.tintColor = .systemGray5
        }
        generalButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16)
        generalButton.titleLabel?.tintColor = .white
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
        if let visibleIndexPath = tableView.indexPathsForVisibleRows?.first, let item = items[safe: visibleIndexPath.row] {
            presenter.selectItem(item)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? FeedTableViewCell {
            cell.pause()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        checkPreloading()
        checkVideoState()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if !newItems.isEmpty {
//            insertNewItems()
//            newItems.removeAll()
//        }
       
        checkPreloading()
//            checkVideoState()

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
