//
//  CommentsTableManager.swift
//  LikeTok
//
//  Created by Daniel on 22.01.22.
//

import UIKit

protocol CommentsTableManagement: AnyObject {
    var output: CommentsTableManagerOutput? { get set }
    func attach(_ tableView: UITableView)
    func update(with configurators: [CommentsCellConfigurator])
    func appendNew(configurator: CommentsCellConfigurator)
    var cellImageTapAction: ((_ userId: String, _ userType: String) -> Void)? { get set }
}

protocol CommentsTableManagerOutput: AnyObject {
    func tableViewIsScrollingToEnd()
}

final class CommentsTableManager: NSObject, CommentsTableManagement {
    private var configurators = [CommentsCellConfigurator]()
    private weak var tableView: UITableView?
    var cellImageTapAction: ((_ userId: String, _ userType: String) -> Void)?
    weak var output: CommentsTableManagerOutput?
    
    func attach(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(nibOfClass: CommentCell.self)
        tableView.contentInsetAdjustmentBehavior = .never
        self.tableView = tableView
    }
    
    func update(with configurators: [CommentsCellConfigurator]) {
        self.configurators = configurators
        tableView?.reloadData()
    }
    
    func appendNew(configurator: CommentsCellConfigurator) {
        self.configurators.insert(configurator, at: .zero)
        tableView?.reloadData()
        tableView?.setContentOffset(.zero, animated: true)
    }
}

extension CommentsTableManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = configurators[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: configurator).cellIdentifier, for: indexPath)
        configurator.setupCell(cell)
        configurator.imageTapAction = { [weak self] userId, profileType in
            self?.cellImageTapAction?(userId, profileType)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 2 == configurators.count, configurators.count > 24 {
            output?.tableViewIsScrollingToEnd()
        }
    }
}

extension CommentsTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return configurators[indexPath.row].didTapCell()
    }
}

extension CommentsTableManager: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            configurators[indexPath.row].prepareData()
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            configurators[indexPath.row].cancelPreparingData()
        }
    }
}
