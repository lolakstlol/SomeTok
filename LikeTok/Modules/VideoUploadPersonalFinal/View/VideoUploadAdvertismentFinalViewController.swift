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
    @IBOutlet weak var titleLabel: UILabel!
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
    
    @IBAction func backButtonDidTap(_ sender: Any) {
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
    
}

extension VideoUploadAdvertismentFinalViewController: VideoUploadAdvertismentFinalPresenterOutput {
    
    func setupUI(preview: Data) {
        navigationController?.navigationBar.isHidden = true
        descriptionTextView.textContainerInset = UIEdgeInsets.zero
        descriptionTextView.delegate = self
        titleLabel.text = Strings.Upload.title
        hashtagTitleLabel.text = Strings.Upload.hastag
        categoryTitleLabel.text = Strings.Upload.category
        promotionsLabel.text = Strings.Upload.primitions
        publishButton.setTitle(Strings.Upload.publish, for: .normal)
        publishButton.layer.cornerRadius = 10
        setupTitles()
    }
    
}

extension VideoUploadAdvertismentFinalViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
