//
//  UserRating.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 11/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class UserRating: UIView {
    
    // MARK: - Properties
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var ratingButtons = [UIButton]()
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "yellowstar")
        let emptyStarImage = UIImage(named: "blackstar")
        
        for _ in 0..<5 {
            let button = UIButton()
            
            button.setImage(emptyStarImage, for: .normal)
            button.setImage(filledStarImage, for: .selected)
            button.adjustsImageWhenHighlighted = false
            
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        
        // Set the buttons width and height
        let buttonsSize = Int(frame.size.height)
        
        var buttonsFrame = CGRect(x: 0, y: 0, width: buttonsSize, height: buttonsSize)
        
        var x = 0

        for button in ratingButtons {
            buttonsFrame.origin.x = CGFloat(x * (buttonsSize + 5)) // 0 0 0 0 0
            button.frame = buttonsFrame
            x += 1
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        
        var x = 0
        
        for button in ratingButtons {
            button.isSelected = x < rating
            x += 1
        }
    }
}
