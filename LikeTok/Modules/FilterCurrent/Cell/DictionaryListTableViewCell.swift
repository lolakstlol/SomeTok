//
//  DictionaryListTableViewCell.swift
//  LikeTok
//
//  Created by Artem Holod on 4.12.21.
//

import UIKit

class DictionaryListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       // super.setSelected(selected, animated: animated)
    }
    
    func setTitle(text: String) {
        titleLabel.text = text
    }
    
}
