//
//  TableViewCell.swift
//  MVVM_Demo
//
//  Created by David on 2016/9/2.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
	
	@IBOutlet weak var bigTitle: UILabel!
	@IBOutlet weak var smallTitle: UILabel!
	@IBOutlet weak var urlLabel: UILabel!
	
	var fakeData: FakeData? {
		didSet {
			updateUI()
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func updateUI() {
		bigTitle.text = fakeData?.title
		smallTitle.text = fakeData?.subtitle
		urlLabel.text = fakeData?.url
	}
}
