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
	var data: FakeData?

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
		viewModel.loadImage(data)
	}

}

extension SecondViewController : SecondViewModelDelegate {
	
	func secondViewModel(failToDownloadImageWith error: String?) {
		yaaaLabel.text = error
	}
	
	func secondViewModel(startDownloadingImageWith state: String?) {
		yaaaLabel.text = state
	}
	
	func secondViewModel(seemLikeFinishDownloadingImageWith state: String?) {
		yaaaLabel.text = state
	}
	
	func secondViewModel(imageIsReadyWith state: String?) {
		yaaaLabel.text = state
	}
	
	func secondViewModel(downloaded imageData: NSData) {
		imageView.image = UIImage(data: imageData)
	}
	
	func secondViewModelShouldDismissViewController() {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	
}
