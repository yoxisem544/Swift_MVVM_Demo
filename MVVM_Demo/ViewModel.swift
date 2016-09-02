//
//  ViewModel.swift
//  MVVM_Demo
//
//  Created by David on 2016/9/2.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation

public protocol ViewModelDelegate: class {
	func viewModel(updateFiltered data: [FakeData])
}

final public class ViewModel {
	
	public weak var delegate: ViewModelDelegate?
	
	public private(set) var data: [FakeData] = []
	public private(set) var filteredData: [FakeData] = []
	public var thisData: FakeData!
	
	public init(delegate: ViewModelDelegate?) {
		self.delegate = delegate
		let titles: [String] = ["pika", "皮卡秋", "妙蛙種子", "妙蛙花", "火恐龍", "綠毛蟲", "比雕", "皮皮"]
		let subtitles: [String] = ["神奇寶貝", "神奇寶貝", "神奇寶貝", "神奇寶貝", "神奇寶貝", "神奇寶貝", "神奇寶貝", "神奇寶貝"]
		let url: String = "https://d17ixjpazu3j94.cloudfront.net/images/2016/08/02/14701500280947wfNjfJhprI.jpg"
		for _ in 1...100 {
			for i in 0..<titles.count {
				let d = FakeData(title: titles[i], subtitle: subtitles[i], url: url)
				data.append(d)
			}
		}
	}
	
	public func filterData(with text: String) {
		let qos = Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
		let queue = dispatch_get_global_queue(qos, 0)
		filteredData.removeAll()
		dispatch_async(queue) {
			for d in self.data {
				if d.title?.rangeOfString(text) != nil {
					self.filteredData.append(d)
				}
			}
			dispatch_async(dispatch_get_main_queue(), {
				self.delegate?.viewModel(updateFiltered: self.filteredData)
			})
		}
	}
}