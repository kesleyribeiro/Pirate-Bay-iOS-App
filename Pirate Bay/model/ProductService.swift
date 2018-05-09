//
//  ProductService.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 9/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import Foundation
import CoreData

struct ProductService {
    
    static var managedObjectContext = CoreDataStack().persistentContainer.viewContext
    
    internal static func products(category type: String) -> [Product] {
        
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        request.predicate = NSPredicate(format: "type == %@", type)
        
        do {
            let products = try self.managedObjectContext.fetch(request)
            return products
        }
        catch let error as NSError {
            fatalError("Error is getting product list: \(error.localizedDescription)")
        }
    }
    
}

