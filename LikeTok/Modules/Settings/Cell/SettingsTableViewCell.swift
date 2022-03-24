//
//  SettingsTableViewCell.swift
//  LikeTok
//
//  Created by Daniel on 23.03.22.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    private var action: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(_ title: String) {
        titleLabel.text = title
    }
    
}
