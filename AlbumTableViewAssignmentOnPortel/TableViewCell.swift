//
//  TableViewCell.swift
//  AlbumTableViewAssignmentOnPortel
//
//  Created by Mac on 04/01/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
