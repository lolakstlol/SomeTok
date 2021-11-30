import Foundation

struct SearchPaginationModel {
    var page: Int
    var lastpredict: String?
}

enum MainSearchTypes {
    case people
    case tags
    case categories
}

final class MainSearchPresenter {
    private unowned let view: MainSearchPresenterOutput

    init(_ view: MainSearchPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension MainSearchPresenter: MainSearchPresenterInput {

}
