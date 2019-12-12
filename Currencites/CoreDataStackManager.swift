//
//  CoreDataStackManager.swift
//  Currencites
//
//  Created by Arsalan Akhtar on 12/11/19.
//  Copyright © 2019 Arsalan Akhtar. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStackManager {
	
	
	// MARK: - Shared Instance
	class func sharedInstance() -> CoreDataStackManager {
		struct Static {
			static let instance = CoreDataStackManager()
		}
		
		return Static.instance
	}
	
	// MARK: - Core Data stack
	lazy var persistentContainer: NSPersistentContainer = {
		
		let container = NSPersistentContainer(name: "ExchangeModel")
		
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	// MARK: - Core Data Saving support
	
	func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
}
