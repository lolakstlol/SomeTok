import UIKit

final class MainSearchViewController: BaseViewController {
    @IBOutlet weak var crossTextFieldButton: UIButton!
    @IBOutlet weak var peopleButton: UIButton!
    @IBOutlet weak var categoriesButton: UIButton!
    @IBOutlet weak var tagsButton: UIButton!
    @IBOutlet weak var peopleTagView: UIView!
    @IBOutlet weak var categoriesTagView: UIView!
    @IBOutlet weak var tagsTagView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var clearSearchButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var backButoon: UIButton!
    
    fileprivate let unselectedColor: UIColor = Assets.classicBGGray.color
    fileprivate let selectedColor: UIColor = Assets.mainRed.color
    
    var collectionManager: SearchCollectionViewManager?
    var selectedSearchType: MainSearchTypes = .people {
        didSet {
            switch selectedSearchType {
            case .people:
                emptyLabel.text = Strings.Search.Plug.people
            case .tags:
                emptyLabel.text = Strings.Search.Plug.tags
            case .categories:
                emptyLabel.text = Strings.Search.Plug.categories
            }
        }
    }
    
	var presenter: MainSearchPresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        peopleButton.setTitle(Strings.Search.Control.accounts, for: .normal)
        categoriesButton.setTitle(Strings.Search.Control.categories, for: .normal)
        tagsButton.setTitle(Strings.Search.Control.tags, for: .normal)
        select(type: selectedSearchType)
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emptyLabel.text = Strings.Search.Plug.people
        filterButton.setTitle("", for: .normal)
        backButoon.setTitle("", for: .normal)
        setupCollection()
        collectionManager = SearchCollectionViewManager()
        collectionManager?.attach(collectionView, output: self)
        collectionManager?.collectionType = .accounts
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let sideInset = 10
        let width: CGFloat = (view.bounds.width - CGFloat(sideInset * 2) - 5) / 2
        layout.itemSize = CGSize(width: width, height: 230)
        layout.sectionInset = UIEdgeInsets(top: .zero, left: CGFloat(sideInset), bottom: .zero, right: CGFloat(sideInset))
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

    private func select(type: MainSearchTypes) {
        clearAllTags()
        switch type {
        case .people:
            UIView.animate(withDuration: 0.2) {
                self.peopleTagView.backgroundColor = self.selectedColor
            }
            collectionManager?.collectionType = .accounts
        case .categories:
            UIView.animate(withDuration: 0.2) {
                self.categoriesTagView.backgroundColor = self.selectedColor
            }
            collectionManager?.collectionType = .categories
        case .tags:
            UIView.animate(withDuration: 0.2) {
                self.tagsTagView.backgroundColor = self.selectedColor
            }
            collectionManager?.collectionType = .videos
        }
        selectedSearchType = type
        view.endEditing(true)
    }
    
    private func clearAllTags() {
        [peopleTagView, categoriesTagView, tagsTagView].forEach {
            $0?.backgroundColor = unselectedColor
        }
    }
    @IBAction func clearButtonDidTap(_ sender: Any) {
        searchTextField.text = ""
        clearSearchButton.isHidden = true
        collectionManager?.setVideos(models: [])
        collectionManager?.setCategories(models: [])
        collectionManager?.setAccounts(models: [])
        collectionView.reloadData()
    }
    
    @IBAction func backButtonDidtap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func peopleDidTap(_ sender: Any) {
        select(type: .people)
    }
    
    @IBAction func categoriesDidTap(_ sender: Any) {
        select(type: .categories)
    }
    
    @IBAction func tagsDidTap(_ sender: Any) {
        select(type: .tags)
    }
}

extension MainSearchViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty ?? true) {
            clearSearchButton.isHidden = true
        } else {
            clearSearchButton.isHidden = false
        }
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField.text == "") {
            clearSearchButton.isHidden = true
            collectionManager?.setVideos(models: [])
            collectionManager?.setCategories(models: [])
            collectionManager?.setAccounts(models: [])
            collectionView.reloadData()
        } else {
            clearSearchButton.isHidden = false
        }
        guard let predict = textField.text, predict != "" else {
            return
        }
        presenter.load(predict: predict, type: selectedSearchType)
    }
}

extension MainSearchViewController: MainSearchPresenterOutput {
    func setAccounts(models: [SearchAccountsDatum]) {
        collectionManager?.setAccounts(models: models)
    }
    
    func setCategories(models: [CategoriesDatum]) {
        collectionManager?.setCategories(models: models)
    }
    
    func setVideos(models: [CategoriesPost]) {
        collectionManager?.setVideos(models: models)
    }
    
    func onFollowSuccess(_ following: Bool, uuid: String) {
        collectionManager?.updateFollowState(following, uuid: uuid)
    }
    
    func onFollowFailure(_ error: NetworkError) {
        showToast(error.localizedDescription, toastType: .failured)
    }
}

extension MainSearchViewController: SearchCollectionViewOutput {
    func openOtherProfile(_ viewController: OtherProfileViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func followButtonTap(_ uuid: String) {
        presenter.followButtonTap(uuid)
    }
}
