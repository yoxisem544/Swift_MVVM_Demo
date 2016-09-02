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
	
	var data: FakeData?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		view.backgroundColor = UIColor.whiteColor()
		imageView.contentMode = .ScaleAspectFill
    }
	
	func delay(time: Double, complete: () -> Void) {
		let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * time))
		dispatch_after(delay, dispatch_get_main_queue(), { () -> Void in
			complete()
		})
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		print(yaaaLabel)
		yaaaLabel.text = "哦哦哦哦哦畫面出現了！可是一片空白"
		let qos = Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
		let queue = dispatch_get_global_queue(qos, 0)
		print(data)
		guard let urlString = data?.url, let url = NSURL(string: urlString) else {
			self.yaaaLabel.text = "嗚嗚嗚網址壞掉了"
			return
		}
		yaaaLabel.text = "哦哦哦哦哦準備開始讀圖片囉！！"
		delay(2.0) { 
			dispatch_async(queue) {
				if let data = NSData(contentsOfURL: url) {
					// success
					dispatch_async(dispatch_get_main_queue(), {
						self.yaaaLabel.text = "哦哦哦哦哦圖片好像讀好了喔"
						self.delay(3.0, complete: {
							self.yaaaLabel.text = "哦哦哦哦哦圖片好了!!!!!"
							self.imageView.image = UIImage(data: data)
						})
					})
				} else {
					// error
					dispatch_async(dispatch_get_main_queue(), {
						self.yaaaLabel.text = "圖片壞惹"
					})
				}
			}
		}
	}

}
