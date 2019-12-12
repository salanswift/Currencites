//
//  CurrencyConvertedCell.swift
//  Currencites
//
//  Created by Arsalan Akhtar on 12/11/19.
//  Copyright © 2019 Arsalan Akhtar. All rights reserved.
//

import UIKit

//
// MARK: - Session Cell
//
class CurrencyConvertedCell: UITableViewCell {
  //
  // MARK: - Class Constants
  //
  static let identifier = "CurrencyConvertedCell"
  
  
  
  //
  // MARK: - Table View Cell
  //
  override func prepareForReuse() {
    super.prepareForReuse()
	textLabel?.text = nil
	detailTextLabel?.text = nil
  }
}
