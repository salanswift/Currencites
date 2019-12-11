//
//  ExchangeRateApi.swift
//  Currencites
//
//  Created by Arsalan Akhtar on 12/11/19.
//  Copyright © 2019 Arsalan Akhtar. All rights reserved.
//

import Foundation
class ExchangeRateApi : NSObject {
    
	typealias  CompletionHander = (_ result: AnyObject?, _ error: Error?) -> Void
    
	var session: URLSession
    
    override init() {
		session = URLSession.shared
        super.init()
    }
   
	// MARK: - All purpose task method for data
    
	func taskForResource(resource: String, parameters: [String : AnyObject], completionHandler: @escaping CompletionHander) {
        
		let urlString = Constants.BaseUrl + resource + ExchangeRateApi.escapedParameters(parameters: parameters)
        let url = URL(string: urlString)!
		let request = URLRequest(url: url)
		let task = session.dataTask(with: request) {
			data,response,downloadError in
		
			if let _ = downloadError {
				completionHandler(nil, downloadError)
			} else {
				print("Step 3 - taskForResource's completionHandler is invoked.")
				ExchangeRateApi.parseJSONWithCompletionHandler(data: data!, completionHandler: completionHandler)
			}
		}
		
		task.resume()
	}
      
    
    // Parsing the JSON
    
    class func parseJSONWithCompletionHandler(data: Data, completionHandler: CompletionHander) {
        var parsingError: NSError? = nil
        
        let parsedResult: AnyObject?
        do {
			parsedResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
        } catch let error as NSError {
            parsingError = error
            parsedResult = nil
        }
        
        if let error = parsingError {
			completionHandler(nil, error)
        } else {
            print("Step 4 - parseJSONWithCompletionHandler is invoked.")
			completionHandler(parsedResult, nil)
        }
    }
    
	// URL Encoding a dictionary into a parameter string
		
		class func escapedParameters(parameters: [String : AnyObject]) -> String {
			
			var urlVars = [String]()
			
			for (key, value) in parameters {
				
				// Make sure that it is a string value
				let stringValue = "\(value)"
				
				// Escape it
				let escapedValue = stringValue.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
				
				// Append it
				 urlVars += [key + "=" + "\(escapedValue!)"]
				
			}
			
			return (!urlVars.isEmpty ? "?" : "") + urlVars.joined(separator:"&")
		}
    
    // MARK: - Shared Instance
    
    class func sharedInstance() -> ExchangeRateApi {
        
        struct Singleton {
            static var sharedInstance = ExchangeRateApi()
        }
        
        return Singleton.sharedInstance
    }
        
}
