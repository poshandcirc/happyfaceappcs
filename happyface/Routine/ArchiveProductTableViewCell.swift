//
//  ArchiveProductTableViewCell.swift
//  happyface
//
//  Created by Cassy Stone on 7/26/16.
//  Copyright © 2016 Cassandra Stone. All rights reserved.
//

import UIKit

class ArchiveProductTableViewCell: UITableViewCell {
    @IBOutlet weak var archiveProductLabel: UILabel!
    @IBOutlet weak var archiveProdIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
