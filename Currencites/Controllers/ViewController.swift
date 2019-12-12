//
//  ViewController.swift
//  Currencites
//
//  Created by Arsalan Akhtar on 12/11/19.
//  Copyright © 2019 Arsalan Akhtar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CurrencySelectorDelegate {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var amountField: UITextField!
	var selectedCurrency: Currency? {
		didSet {
			if isViewLoaded {
				guard let key = selectedCurrency?.key else {
					return
				}
				if let amount = Double(amountField.text!) {
					updateUI(base: key, value: amount)
				}
				self.title = selectedCurrency?.title
			}
		}
	}
	
	lazy var currencies: [Currency] = {
		return Currencies().list
	}()
	
	var exchangeRate:ExchangeRate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		selectedCurrency = currencies.last
	}
	@IBAction func calculate(_ sender: Any) {
		if let key = selectedCurrency?.key, let amount = Double(amountField.text!) {
			updateUI(base: key, value: amount)
		}
	}
	
	@IBAction func refresh(_ sender: Any) {
		
		guard let key = selectedCurrency?.key else {
			return
		}
		if let amount = Double(amountField.text!) {
			downloadAndUpdate(base: key, value: amount)
		}
		
	}
	
	func downloadAndUpdate(base: String, value: Double)
	{
		ExchangeRateApi.sharedInstance().getBaseConversions(base: base) { status,data,error in
			
			do {
				guard let exchangeRates = data?[ExchangeRateApi.Keys.RATES] as? NSDictionary else {
					return
				}
				
				let jsonData = try JSONSerialization.data(withJSONObject: exchangeRates, options: .prettyPrinted)
				saveRates(base: base, exchangeRates:jsonData)
				self.updateUI(base: base, value: value)
				
			} catch let error as NSError {
				print("Could not save. \(error), \(error.userInfo)")
			}
		}
	}
	
	func updateUI(base: String, value:Double)
	{
		exchangeRate = nil
		
		exchangeRate = ExchangeRate(base: base)
		
		if exchangeRate?.rates == nil {
			downloadAndUpdate(base: base, value: value)
		} else {
			exchangeRate?.convertRates(value: value)
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
	//
	// MARK: - View Controller
	//
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		if segue.identifier == "SelectBaseCurrency", let currencyPicker = segue.destination as? CurrencyPickerViewController {
			
			currencyPicker.selectedCurrency = selectedCurrency
			currencyPicker.delegate = self
		}
	}
	
	func currencySelected(_ currency: Currency){
		selectedCurrency = currency
	}
	
}

//
// MARK: - Table View Data Source
//
extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let currencyCell = tableView.dequeueReusableCell(withIdentifier: CurrencyConvertedCell.identifier, for: indexPath) as! CurrencyConvertedCell
		let currency = currencies[indexPath.row]
		currencyCell.textLabel?.text = currency.title
		if let exRate = exchangeRate, let convRat = exRate.convertedrates, let convertedRate = convRat[currency.key] {
		
			currencyCell.detailTextLabel?.text = String(format:"%.2f", convertedRate)
		
		} else {
			currencyCell.detailTextLabel?.text = "-"
		}
		return currencyCell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return currencies.count
	}
}
