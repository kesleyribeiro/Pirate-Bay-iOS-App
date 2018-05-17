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
    
    static internal func addCustomer(name: String, email: String, password: String) -> Customer{
        
        let customer = Customer(context: managegObjectContext)
        customer.name = name
        customer.email = email
        customer.password = password
        
        do {
            try managegObjectContext.save()
            return customer
        }
        catch let error as NSError {
            fatalError("Error create a new customer: \(error.localizedDescription)")
        }
    }
    
    static func addressList(forCustomer customer: Customer) -> [Address] {
        
        let addresses = customer.address?.mutableCopy() as! NSMutableSet
        return addresses.allObjects as! [Address]
    }
    
}

