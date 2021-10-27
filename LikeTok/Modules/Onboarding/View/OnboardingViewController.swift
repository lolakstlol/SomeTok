//
//  OnboardingOnboardingViewController.swift
//  LikeTok
//
//  Created by Danik on 20/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var skipButton: UIButton!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    private var data: [OnboardingPage] = [] {
        didSet {
            pageControl.numberOfPages = data.count
        }
    }
        
    var presenter: OnboardingPresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    private func configure() {
        
        pageControl.currentPageIndicatorTintColor = Assets.Colors.darkRedPageControll.color
        
        skipButton.setTitle(Strings.Onboarding.skip, for: .normal)
        skipButton.setTitleColor(Assets.Colors.darkGrayText.color, for: .normal)
        skipButton.tintColor = Assets.Colors.darkGrayText.color
        
        if let title = skipButton.title(for: .normal) {
            let attributedTitle = NSAttributedString(string: title, attributes: [.kern : -0.4])
            skipButton.setAttributedTitle(attributedTitle, for: .normal)
        }
        
        nextButton.setTitleColor(Assets.Colors.blackText.color, for: .normal)
        nextButton.tintColor = Assets.Colors.blackText.color
        nextButton.setTitle(Strings.Onboarding.next, for: .normal)
        
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: OnboardingCollectionViewCell.identifier, bundle: Bundle.main),
                                     forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
    }
    
    @IBAction private func onPageChanged(_ sender: Any) {
        scrollToNextPage()
    }
    
    @IBAction private func onSkipButtonTap(_ sender: Any) {
        presenter.completeOnboarding()
    }
    
    @IBAction private func onNextButtonTap(_ sender: Any) {
        if pageControl.currentPage == data.count - 1 {
            presenter.completeOnboarding()
        } else {
            pageControl.currentPage += 1
            scrollToNextPage()
        }
    }
     
    private func scrollToNextPage() {
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0),
                                     at: .centeredHorizontally, animated: true)
    }
    
}

extension OnboardingViewController: OnboardingPresenterOutput {

    func onFetchOnboardingData(_ data: [OnboardingPage]) {
        self.data = data
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let item = Int(targetContentOffset.pointee.x / scrollView.frame.width)
        if item == data.count - 1 {
            presenter.completeOnboarding()
        }
        pageControl.currentPage = item
        scrollToNextPage()
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier,
                                                      for: indexPath) as! OnboardingCollectionViewCell
        cell.configureCell(data[indexPath.item])
        return cell
    }
    
    

}
