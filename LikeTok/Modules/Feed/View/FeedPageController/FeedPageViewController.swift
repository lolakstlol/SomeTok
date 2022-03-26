//
//  FeedPageViewController.swift
//  LikeTok
//
//  Created by Daniel on 17.03.22.
//

import UIKit

final class FeedPageViewController: UIPageViewController {
            
    private lazy var generalButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Общее", for: .normal)
        button.addTarget(self, action: #selector(generalFilterTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var advertismentButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Реклама", for: .normal)
        button.addTarget(self, action: #selector(advertismentFilterTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var subsciptionsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Подписки", for: .normal)
        button.addTarget(self, action: #selector(subscribesFilterTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var enterOptionStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
        
    private lazy var pages: [(controller: UIViewController, enterOption: FeedViewEnterOption)] = {
        var controllers = [(controller: UIViewController, enterOption: FeedViewEnterOption)]()
        let generalController = FeedViewAssembler.createModule(type: .mainAll, feedService: FeedService(), collectionManager: FeedCollectionManager())
        let advertismentController = FeedViewAssembler.createModule(type: .mainAdvertisment, feedService: FeedService(), collectionManager: FeedCollectionManager())
        let subscirptionsController = FeedViewAssembler.createModule(type: .mainFollowing, feedService: FeedService(), collectionManager: FeedCollectionManager())
        controllers.append(contentsOf: [(subscirptionsController, .mainFollowing),
                                        (advertismentController, .mainAdvertisment),
                                        (generalController, .mainAll)])
        return controllers
    }()
    
    var currentIndex: Int {
        guard let vc = viewControllers?.first else { return 0 }
        return pages.firstIndex(where: { $0.controller == vc }) ?? 0
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupFilterButtons()
        setupEnterOptionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    private func setupEnterOptionView() {
        enterOptionStackView.addArrangedSubview(subsciptionsButton)
        let dotImageView1 = UIImageView(image: Assets.dot.image)
        dotImageView1.contentMode = .scaleAspectFit
        enterOptionStackView.addArrangedSubview(dotImageView1)
        enterOptionStackView.addArrangedSubview(advertismentButton)
        let dotImageView2 = UIImageView(image: Assets.dot.image)
        dotImageView2.contentMode = .scaleAspectFit
        enterOptionStackView.addArrangedSubview(dotImageView2)
        enterOptionStackView.addArrangedSubview(generalButton)
        
        view.addSubview(enterOptionStackView)
        enterOptionStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterOptionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterOptionStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    private func configure() {
        guard let lastPage = pages.last?.controller else {
            return
        }
        setViewControllers([lastPage], direction: .forward, animated: true, completion: nil)
        let scrollView = view.subviews.filter { $0 is UIScrollView }.first as! UIScrollView
        scrollView.delegate = self
        dataSource = self
        delegate = self
    }

    func setupFilterButtons() {
        generalButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16)
        generalButton.titleLabel?.tintColor = .white
        advertismentButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        advertismentButton.titleLabel?.tintColor = .systemGray5
        subsciptionsButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        subsciptionsButton.titleLabel?.tintColor = .systemGray5
    }
    
    private func updateFilterButtons(with enterOption: FeedViewEnterOption) {
        switch enterOption {
        case .mainAll:
            generalButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16)
            generalButton.titleLabel?.tintColor = .white
            advertismentButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
            advertismentButton.titleLabel?.tintColor = .systemGray5
            subsciptionsButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
            subsciptionsButton.titleLabel?.tintColor = .systemGray5
            
        case .mainAdvertisment:
            advertismentButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16)
            advertismentButton.titleLabel?.tintColor = .white
            generalButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
            generalButton.titleLabel?.tintColor = .systemGray5
            subsciptionsButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
            subsciptionsButton.titleLabel?.tintColor = .systemGray5
            
        case .mainFollowing:
            subsciptionsButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16)
            subsciptionsButton.titleLabel?.tintColor = .white
            generalButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
            generalButton.titleLabel?.tintColor = .systemGray5
            advertismentButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
            advertismentButton.titleLabel?.tintColor = .systemGray5
            
        default:
            break
        }
    }
    
    // MARK: - @IBActions
    @objc private func subscribesFilterTap() {
        if pages[currentIndex].enterOption == .mainFollowing {
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: .updateFeed, object: self)
        } else {
            changeEnterOption(with: .mainFollowing)
        }
    }
    
    @objc private func advertismentFilterTap() {
        if pages[currentIndex].enterOption == .mainAdvertisment {
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: .updateFeed, object: self)
        } else {
            changeEnterOption(with: .mainAdvertisment)
        }
    }
    
    @objc private func generalFilterTap() {
        if pages[currentIndex].enterOption == .mainAll {
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: .updateFeed, object: self)
        } else {
            changeEnterOption(with: .mainAll)
        }
    }
    
    private func changeEnterOption(with enterOption: FeedViewEnterOption) {
        guard let controller = pages.first(where: { $0.enterOption == enterOption })?.controller else {
            return
        }
        setViewControllers([controller], direction: .forward, animated: false, completion: nil)
        updateFilterButtons(with: enterOption)
    }

}

extension FeedPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(where: { $0.controller == viewController }), index > 0 else {
            return nil
        }
        let before = index - 1
        debugPrint(pages[index].enterOption)
        return pages[before].controller
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(where: { $0.controller == viewController }), index < pages.count - 1 else {
            return nil
        }
        let after = index + 1
        debugPrint(pages[index].enterOption)
        return pages[after].controller
    }
    
    func viewController(at index: Int) -> UIViewController {
        return pages[index].controller
    }
      
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
}

extension FeedPageViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateFilterButtons(with: pages[currentIndex].enterOption)
    }
}
