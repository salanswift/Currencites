//
//  Currencies.swift
//  Currencites
//
//  Created by Arsalan Akhtar on 12/11/19.
//  Copyright © 2019 Arsalan Akhtar. All rights reserved.
//

import Foundation

//
// MARK: - Currencies
//
class Currencies {
  //
  // MARK: - Variables And Properties
  //
  var list: [Currency] = [
	Currency(title: "CAD", key: "CAD"),
	Currency(title: "HKD", key: "HKD"),
	Currency(title: "ISK", key: "ISK"),
	Currency(title: "PHP", key: "PHP"),
	Currency(title: "DKK", key: "DKK"),
	Currency(title: "HUF", key: "HUF"),
	Currency(title: "CZK", key: "CZK"),
	Currency(title: "AUD", key: "AUD"),
	Currency(title: "RON", key: "RON"),
	Currency(title: "SEK", key: "SEK"),
	Currency(title: "IDR", key: "IDR"),
	Currency(title: "INR", key: "INR"),
	Currency(title: "BRL", key: "BRL"),
	Currency(title: "RUB", key: "RUB"),
	Currency(title: "HRK", key: "HRK"),
	Currency(title: "JPY", key: "JPY"),
	Currency(title: "THB", key: "THB"),
	Currency(title: "CHF", key: "CHF"),
	Currency(title: "SGD", key: "SGD"),
	Currency(title: "PLN", key: "PLN"),
	Currency(title: "BGN", key: "BGN"),
	Currency(title: "TRY", key: "TRY"),
	Currency(title: "CNY", key: "CNY"),
	Currency(title: "NOK", key: "NOK"),
	Currency(title: "NZD", key: "NZD"),
	Currency(title: "ZAR", key: "ZAR"),
	Currency(title: "USD", key: "USD"),
	Currency(title: "MXN", key: "MXN"),
	Currency(title: "ILS", key: "ILS"),
	Currency(title: "GBP", key: "GBP"),
	Currency(title: "KRW", key: "KRW"),
	Currency(title: "MYR", key: "MYR")
	]
  
  
}

class Currency:Equatable {
	
	let title:String
	let key:String
	
	init(title:String, key:String) {
		self.title = title
		self.key = key
	}
	
	static func == (lhs: Currency, rhs: Currency) -> Bool {
		return lhs.key == rhs.key
	}

}
