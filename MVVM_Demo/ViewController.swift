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
	
	var viewModel: ViewModel!
	

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		viewModel = ViewModel(delegate: self)
		
		tableView.delegate = self
		tableView.dataSource = self
		
		textField.addTarget(self, action: .textChanged, forControlEvents: .EditingChanged)
	}

	@objc private func textFieldTextChanged(textField: UITextField) {
		guard let text = textField.text else { return }
		viewModel.filterData(with: text)
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "segue" {
			let vc = segue.destinationViewController as? SecondViewController
			vc?.data = viewModel.thisData
		}
	}

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.filteredData.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
		cell.fakeData = viewModel.filteredData[indexPath.row]
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		viewModel.thisData = viewModel.filteredData[indexPath.row]
		performSegueWithIdentifier("segue", sender: nil)
	}
}

extension ViewController : ViewModelDelegate {
	
	func viewModel(updateFiltered data: [FakeData]) {
		tableView.reloadData()
	}
	
}