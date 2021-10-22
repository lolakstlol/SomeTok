import Foundation
import Alamofire


protocol ApiMethod {
    var request: DataRequest { get }
}
