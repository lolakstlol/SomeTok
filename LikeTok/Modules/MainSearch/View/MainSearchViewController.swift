import UIKit

final class MainSearchViewController: BaseViewController {
//    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var crossTextFieldButton: UIButton!
    @IBOutlet weak var peopleButton: UIButton!
    @IBOutlet weak var categoriesButton: UIButton!
    @IBOutlet weak var tagsButton: UIButton!
    @IBOutlet weak var peopleTagView: UIView!
    @IBOutlet weak var categoriesTagView: UIView!
    @IBOutlet weak var tagsTagView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var clearSearchButton: UIButton!
//    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backButoon: UIButton!
    
    fileprivate let unselectedColor: UIColor = Assets.classicBGGray.color
    fileprivate let selectedColor: UIColor = Assets.mainRed.color
    var collectionManager: SearchCollectionViewManager?
    var selectedSearchType: MainSearchTypes = .people {
        didSet {
//            switch selectedSearchType {
//            case .people:
//                emptyLabel.text = R.strings.SearchMain.peooplePlug
//            case .videos:
//                emptyLabel.text = R.strings.SearchMain.videosPlug
//            case .tags:
//                emptyLabel.text = R.strings.SearchMain.tagPlug
//            }
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
//        setupTableView()
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        emptyLabel.text = R.strings.SearchMain.peooplePlug
        filterButton.setTitle("", for: .normal)
        backButoon.setTitle("", for: .normal)
        setupCollection()
        collectionManager = SearchCollectionViewManager()
        collectionManager?.attach(collectionView)
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
//            peeopleDataSource = []
//            tagsDataSource = []
//            videosDataSource = []
//            tableView.reloadData()
        } else {
            clearSearchButton.isHidden = false
        }
        guard let predict = textField.text, predict != "" else {
//            lastSearchTags.page = 0
//            lastSearchVideos.page = 0
//            lastSearchPeeople.page = 0
            return
        }
//        load(predict: predict)
    }
}

extension MainSearchViewController: MainSearchPresenterOutput {

}

extension MainSearchViewController: UICollectionViewDelegate {
    
}

extension MainSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return VideoCollectionViewCell()
    }
}
