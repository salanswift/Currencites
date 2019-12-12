//
//  ExchangeRate.swift
//  Currencites
//
//  Created by Arsalan Akhtar on 12/11/19.
//  Copyright © 2019 Arsalan Akhtar. All rights reserved.
//

import Foundation
// 1. Import CoreData
import CoreData

class ExchangeRate {
	
	var rates: Dictionary<String,Double>?
	var convertedrates: Dictionary<String,Double>?
	var base:String?
	
	init(base:String) {
		self.base = base
		if let rateObj = fetchRates(base: base), let ratesData = rateObj.value(forKeyPath: "exchangeRates") as? Data {
			
			do {
				let decoded = try JSONSerialization.jsonObject(with: ratesData, options: [])
				
				if let dict = decoded as? [String:Double] {
					rates = dict
				}
				
			} catch let error as NSError {
				print("Could not parse. \(error), \(error.userInfo)")
			}
		}
	}
	
	func convertRates(value:Double) {
		convertedrates = rates?.mapValues { rate in
			return rate * value
		}
	}
	
}

func saveRates(base: String, exchangeRates:Data) {
	
	deleteRates(base: base)
	
	let managedContext = CoreDataStackManager.sharedInstance().persistentContainer.viewContext
	let entity = NSEntityDescription.entity(forEntityName: "Exchange", in: managedContext)!
	let exchange = NSManagedObject(entity: entity, insertInto: managedContext)
	exchange.setValue(base, forKeyPath: "baseCurrency")
	exchange.setValue(exchangeRates, forKeyPath: "exchangeRates")
	
	do {
		try managedContext.save()
	} catch let error as NSError {
		print("Could not save. \(error), \(error.userInfo)")
	}
}


func fetchRates(base: String) -> NSManagedObject? {
	let managedContext = CoreDataStackManager.sharedInstance().persistentContainer.viewContext
	let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exchange")
	fetchRequest.predicate = NSPredicate(format: "baseCurrency == %@", base)
	do {
		let record = try managedContext.fetch(fetchRequest)
		if record.first != nil {
			return record.first
		} else {
			return nil
		}
	} catch let error as NSError {
		print("Could not fetch. \(error), \(error.userInfo)")
		return nil
	}
}

func deleteRates(base: String) {
	let managedContext = CoreDataStackManager.sharedInstance().persistentContainer.viewContext
	let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exchange")
	fetchRequest.predicate = NSPredicate(format: "baseCurrency == %@", base)
	do {
		let objects = try managedContext.fetch(fetchRequest)
		for obj in objects {
			managedContext.delete(obj)
		}
	}
	catch {
		// Do something... fatalerror
	}
	
	do {
		try managedContext.save() // <- remember to put this :)
	} catch {
		// Do something... fatalerror
	}
}
