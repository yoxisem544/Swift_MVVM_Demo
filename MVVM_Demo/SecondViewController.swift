//
//  SecondViewController.swift
//  MVVM_Demo
//
//  Created by David on 2016/9/2.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
	
	@IBOutlet weak var yaaaLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	
	var viewModel: SecondViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		view.backgroundColor = UIColor.whiteColor()
		imageView.contentMode = .ScaleAspectFill
		
		viewModel = SecondViewModel(delegate: self)
    }
	
	
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		print(yaaaLabel)
		yaaaLabel.text = "哦哦哦哦哦畫面出現了！可是一片空白"
		
	}

}
