//
//  ExchangeRateApi-Convinience.swift
//  Currencites
//
//  Created by Arsalan Akhtar on 12/11/19.
//  Copyright © 2019 Arsalan Akhtar. All rights reserved.
//

import Foundation

extension ExchangeRateApi {
	
	func getBaseConversions(base:String, completionHandler: @escaping (_ success:Bool, _ result:AnyObject?, _ errorString:String?) -> Void) {
		
		let parameters = [
			ExchangeRateApi.Keys.BASE : base,
			] as [String : Any]
		
		ExchangeRateApi.sharedInstance().taskForResource(resource: ExchangeRateApi.Resources.LATEST, parameters: parameters as [String : AnyObject]){  JSONResult, error  in
			
			if let _ = error
			{
				completionHandler(false, nil, "Can not find conversion for base currency")
			}
			else
				
			{
				guard let jsonResultDictionary = JSONResult as? NSDictionary, jsonResultDictionary[ExchangeRateApi.Keys.RATES] != nil else {
					
					let error = NSError(domain: "Conversion for Base. Cant find Currency in \(String(describing: JSONResult))", code: 0, userInfo: nil)
					print(error)
					completionHandler(false, nil, error.localizedDescription)
					return
				
				}
				
				completionHandler(true, JSONResult, nil)
			}
		}
	}
}

