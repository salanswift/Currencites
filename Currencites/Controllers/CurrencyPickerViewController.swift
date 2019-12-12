//
//  CurrencyPickerViewController.swift
//  Currencites
//
//  Created by Arsalan Akhtar on 12/11/19.
//  Copyright © 2019 Arsalan Akhtar. All rights reserved.
//

import UIKit

protocol CurrencySelectorDelegate: AnyObject {
    func currencySelected(_ currency: Currency)
}

class CurrencyPickerViewController: UITableViewController {
	
	lazy var currencies: [Currency] = {
		return Currencies().list
	}()
	
	var selectedCurrency: Currency? {
	  didSet {
		if isViewLoaded {
			self.tableView.reloadData()
		}
	  }
	}
	
	weak var delegate: CurrencySelectorDelegate?
	
}

//
// MARK: - Table View Data Source
//
extension CurrencyPickerViewController {
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let currencyCell = tableView.dequeueReusableCell(withIdentifier: CurrencySelectionCell.identifier, for: indexPath) as! CurrencySelectionCell
		let currency = currencies[indexPath.row]
		currencyCell.textLabel?.text = currency.title
		
		if currency == selectedCurrency {
			currencyCell.select()
		}
		return currencyCell
	}
	
	override	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return currencies.count
	}
}

//
// MARK: - Table View Delegate
//
extension CurrencyPickerViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedCurrency = currencies[indexPath.row]
		self.delegate?.currencySelected(currencies[indexPath.row])
	}
}
