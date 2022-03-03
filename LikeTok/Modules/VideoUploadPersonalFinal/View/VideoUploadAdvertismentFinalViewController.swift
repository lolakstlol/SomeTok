//
//  VideoUploadPersonalFinalViewController.swift
//  LikeTok
//
//  Created by Daniel on 24.02.22.
//

import UIKit

class VideoUploadAdvertismentFinalViewController: BaseViewController {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var hashTagButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var promotionsLabel: UILabel!
    @IBOutlet weak var promotionsButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var hashtagTitleLabel: UILabel!
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    private let keyboardObserver = KeyboardObserver()
    private lazy var tapWhenKeyboardAppears = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    private var filtres: CategoriesFiltres?
    
    var presenter: VideoUploadAdvertismentFinalPresenterInput!
    
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
    
    private func addKeyboardObservers() {
        keyboardObserver.keyboardWillShow = { [weak self] info in
            guard let self = self else { return }
            self.keyboardWillShow(info)
        }

        keyboardObserver.keyboardWillHide = { [weak self] info in
            guard let self = self else { return }
            self.keyboardWillHide(info)
        }
    }
   
    private func keyboardWillHide(_ info: KeyboardObserver.KeyboardInfo) {
         view.removeGestureRecognizer(tapWhenKeyboardAppears)
         presenter.hideKeyboard()

    }

    private func keyboardWillShow(_ info: KeyboardObserver.KeyboardInfo) {
         view.addGestureRecognizer(tapWhenKeyboardAppears)
         presenter.showKeyboard(info)
    }
    
    @objc
    func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func hashTagButtonTap(_ sender: Any) {
        let vc = FilterCurrentAssembler.createModule(type: .country, completion: { data in
            self.filtres?.countries = data as! CountryDictionary
            self.setupTitles()
        })
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func categoryButtonTap(_ sender: Any) {
        let vc = FilterCurrentAssembler.createModule(type: .category, completion: { data in
            self.filtres?.categories = data as! CategoryDictionary
            self.setupTitles()
        })
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func publishButtonTap(_ sender: Any) {
        showLoader()
        presenter.publishButtonTap(description: descriptionTextView.text)
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
        addKeyboardObservers()
        setupTitles()
    }
    
    func onPublishPost() {
        hideLoader()
        navigationController?.popToRootViewController(animated: false)
        guard let tabBar = tabBarController as? TabBarViewController else { return }
        tabBar.returnToPreviositem()
    }
    
    func onShowKeyboard(_ insets: UIEdgeInsets) {
         scrollView.contentInset = insets
         scrollView.scrollIndicatorInsets = insets

         UIView.animate(withDuration: 0.4) {
             self.view.setNeedsLayout()
         }
    }
    
    func onHideKeyboard(_ insets: UIEdgeInsets) {

         scrollView.contentInset = insets
         scrollView.scrollIndicatorInsets = insets
        
         UIView.animate(withDuration: 0.4) {
             self.view.setNeedsLayout()
         }
    }
    
}

extension VideoUploadAdvertismentFinalViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
