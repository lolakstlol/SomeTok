import UIKit
import Kingfisher


extension UIImageView{
    
    func setImageFromUrl(urlImage: String, placeHolder: UIImage? = nil){
        let url = URL(string: urlImage)
        kf.indicatorType = .activity
        kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                break
            case .failure(let error):
                self.image = placeHolder
                print("Job failed: \(error.localizedDescription)")
                break
            }
        }
    }
}
