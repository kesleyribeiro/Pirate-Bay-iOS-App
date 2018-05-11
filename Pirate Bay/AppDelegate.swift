//
//  AppDelegate.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 8/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreDataStack = CoreDataStack()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        deleteProducts()
        loadProducts()
        
        let tabBarController = window?.rootViewController as! UITabBarController
        
        let splitVC = tabBarController.viewControllers?[1] as! UISplitViewController
        let masterNavigation = splitVC.viewControllers[0] as! UINavigationController
        let productsTableVC = masterNavigation.topViewController as! ProductsTVC
        
        let detailNavigation = splitVC.viewControllers[1] as! UINavigationController
        let productDetailVC = detailNavigation.topViewController as! ProductDetailVC
        
        productsTableVC.delegate = productDetailVC

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func deleteProducts() {
        let managedObjectContext = coreDataStack.persistentContainer.viewContext
        let productRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let manufacturerRequest: NSFetchRequest<Manufacturer> = Manufacturer.fetchRequest()
        let productInfoRequest: NSFetchRequest<ProductInfo> = ProductInfo.fetchRequest()
        let productImageRequest: NSFetchRequest<ProductImage> = ProductImage.fetchRequest()
        
        var deleteRequest: NSBatchDeleteRequest
        
        do {
            deleteRequest = NSBatchDeleteRequest(fetchRequest: productRequest as! NSFetchRequest<NSFetchRequestResult>)
            let _ = try managedObjectContext.execute(deleteRequest) as! NSBatchDeleteResult
            
            deleteRequest = NSBatchDeleteRequest(fetchRequest: manufacturerRequest as! NSFetchRequest<NSFetchRequestResult>)
            let _ = try managedObjectContext.execute(deleteRequest) as! NSBatchDeleteResult
            
            deleteRequest = NSBatchDeleteRequest(fetchRequest: productInfoRequest as! NSFetchRequest<NSFetchRequestResult>)
            let _ = try managedObjectContext.execute(deleteRequest) as! NSBatchDeleteResult
            
            deleteRequest = NSBatchDeleteRequest(fetchRequest: productImageRequest as! NSFetchRequest<NSFetchRequestResult>)
            let _ = try managedObjectContext.execute(deleteRequest) as! NSBatchDeleteResult
        }
        catch {}
    }
    
    private func loadProducts() {
        
        let managedObjectContext = coreDataStack.persistentContainer.viewContext
        
        let url = Bundle.main.url(forResource: "products", withExtension: "json")
        
        if let url = url {
            let data = try? Data(contentsOf: url)
            
            do {
                guard let data = data else {
                    return
                }
                
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                
                let jsonArray = jsonResult.value(forKey: "products") as! NSArray
                
                for json in jsonArray {
                    
                    let productData = json as! [String: Any]
                    
                    guard let productId = productData["id"] else { return }
                    guard let name = productData["name"] else { return }
                    guard let type = productData["type"] else { return }
                    
                    let product = Product(context: managedObjectContext)
                    product.id = productId as? String
                    product.name = name as? String
                    product.type = type as? String
                    
                    if let regularPrice = productData["regularPrice"] {
                        product.regularPrice = (regularPrice as? Double)!
                    }
                    
                    if let salePrice = productData["salePrice"] {
                        product.salePrice = (salePrice as? Double)!
                    }
                    
                    if let quantity = productData["quantity"] {
                        product.quantity = (quantity as AnyObject).int16Value
                    }
                    
                    if let rating = productData["rating"] {
                        product.rating = (rating as AnyObject).int16Value
                    }
                    
                    let manufacturer = Manufacturer(context: managedObjectContext)
                    manufacturer.id = (productData["manufacturerId"] as AnyObject).int16Value
                    manufacturer.name = productData["manufacturerName"] as? String
                    product.manufacturer = manufacturer
                    
                    let productImages = product.productImages?.mutableCopy() as! NSMutableSet
                    var mainImageName: String?
                    
                    if let imageNames = productData["images"] {
                        for imageName in imageNames as! NSArray {
                            let productImage = ProductImage(context: managedObjectContext)
                            
                            let currentImageName = imageName as? String
                            let currentImage = Utility.image(withName: currentImageName, andType: "jpg")
                            
                            if let currentImage = currentImage, let imageData = UIImageJPEGRepresentation(currentImage, 1.0) {
                                productImage.image = NSData.init(data: imageData) as Data
                            }
                            
                            productImage.name = currentImageName
                            
                            if mainImageName == nil && currentImageName?.contains("1") == true {
                                mainImageName = currentImageName
                            }
                            
                            productImages.add(productImage)
                        }

                        product.productImages = productImages.copy() as? NSSet
                    }
                    
                    product.mainImage = mainImageName
                    
                    // Product Summary
                    
                    if let summary = productData["summary"] {
                        product.summary = summary as? String
                    }
                    
                    
                    // Product Info
                    let productInfo = product.productInfo?.mutableCopy() as! NSMutableSet
                    
                    if let description1 = productData["description1"] {
                        let temp = ProductInfo(context: managedObjectContext)
                        temp.info = description1 as? String
                        temp.type = "description"
                        productInfo.add(temp)
                    }
                    
                    if let description2 = productData["description2"] {
                        let temp = ProductInfo(context: managedObjectContext)
                        temp.info = description2 as? String
                        temp.type = "description"
                        productInfo.add(temp)
                    }
                    
                    if let description3 = productData["description3"] {
                        let temp = ProductInfo(context: managedObjectContext)
                        temp.info = description3 as? String
                        temp.type = "description"
                        productInfo.add(temp)
                    }
                    
                    if let weight = productData["weight"] {
                        let temp = ProductInfo(context: managedObjectContext)
                        temp.title = "Item Weight"
                        temp.info = weight as? String
                        temp.type = "specs"
                        productInfo.add(temp)
                    }
                    
                    if let dimension = productData["dimension"] {
                        let temp = ProductInfo(context: managedObjectContext)
                        temp.title = "Product Dimension"
                        temp.info = dimension as? String
                        temp.type = "specs"
                        productInfo.add(temp)
                    }
                    
                    if let ageGroup = productData["ageGroup"] {
                        let temp = ProductInfo(context: managedObjectContext)
                        temp.title = "Age Group"
                        temp.info = ageGroup as? String
                        temp.type = "specs"
                        productInfo.add(temp)
                    }
                    
                    if let modelNumber = productData["modelNumber"] {
                        let temp = ProductInfo(context: managedObjectContext)
                        temp.title = "Model Number"
                        temp.info = modelNumber as? String
                        temp.type = "specs"
                        productInfo.add(temp)
                    }
                    
                    if let format = productData["format"] {
                        let temp = ProductInfo(context: managedObjectContext)
                        temp.title = "Format"
                        temp.info = format as? String
                        temp.type = "specs"
                        productInfo.add(temp)
                    }
                    
                    if let language = productData["language"] {
                        let temp = ProductInfo(context: managedObjectContext)
                        temp.title = "Language"
                        temp.info = language as? String
                        temp.type = "specs"
                        productInfo.add(temp)
                    }
                    
                    if let region = productData["region"] {
                        let temp = ProductInfo(context: managedObjectContext)
                        temp.title = "Region"
                        temp.info = region as? String
                        temp.type = "specs"
                        productInfo.add(temp)
                    }
                    
                    product.productInfo = productInfo.copy() as? NSSet
                }
                
                coreDataStack.saveContext()
            }
            catch let error as NSError {
                print("Error in parsing products.json: \(error.localizedDescription)")
            }
        }
    }


}

