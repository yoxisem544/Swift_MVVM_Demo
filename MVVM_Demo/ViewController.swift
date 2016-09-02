//
//  ViewController.swift
//  MVVM_Demo
//
//  Created by David on 2016/9/2.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

private extension Selector {
	static let textChanged = #selector(ViewController.textFieldTextChanged(_:))
}

class ViewController: UIViewController {
	
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var tableView: UITableView!
	var data: [FakeData] = []
	var filteredData: [FakeData] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		tableView.delegate = self
		tableView.dataSource = self
		
		let titles: [String] = ["pika", "皮卡秋", "妙蛙種子", "妙蛙花", "火恐龍", "綠毛蟲", "比雕", "皮皮"]
		let subtitles: [String] = ["神奇寶貝", "神奇寶貝", "神奇寶貝", "神奇寶貝", "神奇寶貝", "神奇寶貝", "神奇寶貝", "神奇寶貝"]
		let url: String = "http://163.13.175.7/102pro/102proa/102proa05/pake.jpg"
		for _ in 1...100 {
			for i in 0..<titles.count {
				let d = FakeData(title: titles[i], subtitle: subtitles[i], url: url)
				data.append(d)
			}
		}
		
		textField.addTarget(self, action: .textChanged, forControlEvents: .EditingChanged)
	}

	@objc private func textFieldTextChanged(textField: UITextField) {
		guard let text = textField.text else { return }
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
				self.tableView.reloadData()
			})
		}
	}


}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredData.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
		cell.fakeData = filteredData[indexPath.row]
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let d = filteredData[indexPath.row]
		print(d)
	}
}
