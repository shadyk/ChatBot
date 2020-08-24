//
//  Created by Shady
//  All rights reserved.
// 

import UIKit

class BaseTableViewCell: UITableViewCell {
    @IBOutlet weak var lblText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
