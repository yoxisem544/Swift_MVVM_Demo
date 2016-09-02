//
//  SecondViewModel.swift
//  MVVM_Demo
//
//  Created by David on 2016/9/2.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation

public protocol SecondViewModelDelegate: class {
	func secondViewModel(failToDownloadImageWith error: String?)
	func secondViewModel(startDownloadingImageWith state: String?)
	func secondViewModel(seemLikeFinishDownloadingImageWith state: String?)
	func secondViewModel(imageIsReadyWith state: String?)
	func secondViewModel(downloaded imageData: NSData)
	func secondViewModelShouldDismissViewController()
}

final public class SecondViewModel {
	
	public weak var delegate: SecondViewModelDelegate?
	private var data: FakeData?
	
	public init(delegate: SecondViewModelDelegate?, fakeData: FakeData?) {
		self.delegate = delegate
	}
	
	private func delay(time: Double, complete: () -> Void) {
		let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * time))
		dispatch_after(delay, dispatch_get_main_queue(), { () -> Void in
			complete()
		})
	}
	
	public func loadImage() {
		let qos = Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
		let queue = dispatch_get_global_queue(qos, 0)
		print(data)
		guard let urlString = data?.url, let url = NSURL(string: urlString) else {
			delegate?.secondViewModel(failToDownloadImageWith: "嗚嗚嗚網址壞掉了")
			return
		}
		delegate?.secondViewModel(startDownloadingImageWith: "哦哦哦哦哦準備開始讀圖片囉！！")
		delay(2.0) {
			dispatch_async(queue) {
				if let data = NSData(contentsOfURL: url) {
					// success
					dispatch_async(dispatch_get_main_queue(), {
						self.delegate?.secondViewModel(seemLikeFinishDownloadingImageWith: "哦哦哦哦哦圖片好像讀好了喔")
						self.delay(3.0, complete: {
							self.delegate?.secondViewModel(imageIsReadyWith: "哦哦哦哦哦圖片好了!!!!!")
							self.delegate?.secondViewModel(downloaded: data)
							self.delay(3.0, complete: {
								self.delegate?.secondViewModelShouldDismissViewController()
							})
						})
					})
				} else {
					// error
					dispatch_async(dispatch_get_main_queue(), {
						self.delegate?.secondViewModel(failToDownloadImageWith: "圖片壞惹")
						self.delay(3.0, complete: {
							self.delegate?.secondViewModelShouldDismissViewController()
						})
					})
				}
			}
		}
	}
}