//
//  CustomerService.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 17/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import Foundation
import CoreData

struct CustomerService {
    
    static var managegObjectContext = CoreDataStack().persistentContainer.viewContext
    
    static internal func verify(username: String, password: String) -> Customer? {
        
        let request: NSFetchRequest<Customer> = Customer.fetchRequest()
        
        request.predicate = NSPredicate(format: "email = %@ AND password = %@", username, password)
        
        do {
            let result = try managegObjectContext.fetch(request)
            
            if result.count > 0 {
                return result.first
            }
            return nil
        }
        catch let error as NSError{
            print("Error verifying customer login: \(error.localizedDescription)")
            return nil
        }
    }
}

