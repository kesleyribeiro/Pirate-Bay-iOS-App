//
//  HomeVC.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 8/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var toyCV: UICollectionView!
    @IBOutlet weak var dvdCV: UICollectionView!
    
    // MARK: - Properties
    var pageViewController: UIPageViewController?
    let arrayPageImage = ["piratebattle", "piratemap", "piratesofcaribbean"]
    var currentIndex = 0
    var toysCollection = [Product]()
    var dvdCollection = [Product]()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(HomeVC.loadNextController), userInfo: nil, repeats: true)
        
        setPageViewController()
        
        loadProducts()
    }
    
    // MARK: - Private functions
    
    private func setPageViewController() {
        
        let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "promoPageVC") as! UIPageViewController
        
        pageVC.dataSource = self
        
        let firstController = getViewController(atIndex: 0)
        
        pageVC.setViewControllers([firstController], direction: .forward, animated: true, completion: nil)
        
        self.pageViewController = pageVC
        
        self.addChildViewController(self.pageViewController!)
        self.pageView.addSubview(self.pageViewController!.view)
        self.pageViewController?.didMove(toParentViewController: self)
    }
    
    fileprivate func getViewController(atIndex index: Int) -> PromoContentVC {
        let promoContentVC = self.storyboard?.instantiateViewController(withIdentifier: "promoContentVC") as! PromoContentVC
        
        promoContentVC.imageName = arrayPageImage[index]
        promoContentVC.pageIndex = index
        
        return promoContentVC
    }
    
    @objc private func loadNextController() {
        
        currentIndex += 1
        
        if currentIndex == arrayPageImage.count {
            currentIndex = 0
        }
        
        let nextController = getViewController(atIndex: currentIndex)
        
        self.pageViewController?.setViewControllers([nextController], direction: .forward, animated: true, completion: nil)
    }
    
    private func loadProducts() {
        
        toysCollection = ProductService.products(category: "toy")
        
        dvdCollection = ProductService.products(category: "dvd")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UIPageViewControllerDatasource

extension HomeVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let pageContentVC = viewController as! PromoContentVC
        var index = pageContentVC.pageIndex
        
        if index == 0 || index == NSNotFound {
            return getViewController(atIndex: arrayPageImage.count - 1)
            
            // 0  | 1 | 2 | 0 | 1 | 2 | ...
            
        }

        index -= 1 // index = index - 1
        
        return getViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let pageContentVC = viewController as! PromoContentVC
        var index = pageContentVC.pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1  // index = index + 1
        
        if index == arrayPageImage.count {
            return getViewController(atIndex: 0)
        }
        
        return getViewController(atIndex: index)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.toyCV:
            return self.toysCollection.count
            
        case self.dvdCV:
            return self.dvdCollection.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.toyCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellToy", for: indexPath) as! ProductCVCell
            
            let product = toysCollection[indexPath.row]
            
            cell.productImageView.image = Utility.image(withName: product.mainImage, andType: "jpg")
            
            return cell
            
        case self.dvdCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDvd", for: indexPath) as! ProductCVCell
            
            let product = dvdCollection[indexPath.row]
            
            cell.productImageView.image = Utility.image(withName: product.mainImage, andType: "jpg")
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
