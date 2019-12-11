//
//  ViewController.swift
//  Currencites
//
//  Created by Arsalan Akhtar on 12/11/19.
//  Copyright © 2019 Arsalan Akhtar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		downloadAndUpdate(base: "USD")
	}

	func downloadAndUpdate(base: String)
    {
		ExchangeRateApi.sharedInstance().getBaseConversions(base: base) {status,data,error in
			
			print(status)
			print(data ?? "")
			print(error ?? "")
		}
	}

}

