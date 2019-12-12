//
//  CurrencySelectionCell.swift
//  Currencites
//
//  Created by Arsalan Akhtar on 12/11/19.
//  Copyright © 2019 Arsalan Akhtar. All rights reserved.
//

import UIKit

//
// MARK: - Session Cell
//
class CurrencySelectionCell: UITableViewCell {
	//
	// MARK: - Class Constants
	//
	static let identifier = "CurrencySelectionCell"
	
	//
	// MARK: - Table View Cell
	//
	override func prepareForReuse() {
		super.prepareForReuse()
		textLabel?.text = nil
		accessoryType = .none
	}
	
	func select() {
		accessoryType = .checkmark
	}
	
}
