//
//  VideoUploadPersonalFinalViewController.swift
//  LikeTok
//
//  Created by Daniel on 24.02.22.
//

import UIKit

class VideoUploadAdvertismentFinalViewController: UIViewController {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var hashTagButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var promotionsLabel: UILabel!
    @IBOutlet weak var promotionsButton: UIButton!
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var hashtagTitleLabel: UILabel!
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var presenter: VideoUploadAdvertismentFinalPresenterInput!
    var filtres: CategoriesFiltres?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    private func setupTitles() {
        guard let filtres = filtres else {
            return
        }
        hashtagLabel.text = filtres.countries?.name ?? ""
        categoryLabel.text = filtres.categories?.name ?? ""
    }
    
    @objc
    func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func hashTagDidTap(_ sender: Any) {
        let vc = FilterCurrentAssembler.createModule(type: .country, completion: { data in
            self.filtres?.countries = data as! CountryDictionary
            self.setupTitles()
        })
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func categoryDidTap(_ sender: Any) {
        let vc = FilterCurrentAssembler.createModule(type: .category, completion: { data in
            self.filtres?.categories = data as! CategoryDictionary
            self.setupTitles()
        })
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func publishButtonTap(_ sender: Any) {
        presenter.publishButtonTap()
    }
    
    func didPublishPost() {
        navigationController?.popToRootViewController(animated: false)
        guard let tabBar = tabBarController as? TabBarViewController else { return }
        tabBar.returnToPreviositem()
    }
}

extension VideoUploadAdvertismentFinalViewController: VideoUploadAdvertismentFinalPresenterOutput {
    
    func setupUI(preview: Data) {
        descriptionTextView.textContainerInset = UIEdgeInsets.zero
        descriptionTextView.delegate = self
        hashtagTitleLabel.text = Strings.Upload.hastag
        categoryTitleLabel.text = Strings.Upload.category
        promotionsLabel.text = Strings.Upload.primitions
        publishButton.setTitle(Strings.Upload.publish, for: .normal)
        publishButton.layer.cornerRadius = 10
        title = Strings.Camera.Publication.ad
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Assets.backButton.image, style: .plain, target: self, action: #selector(backButtonDidTap))
        navigationItem.leftBarButtonItem?.tintColor = .black
        previewImageView.image = UIImage(data: preview)
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        setupTitles()
    }
    
}

extension VideoUploadAdvertismentFinalViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
