//
//  CardCollectionViewCell.swift
//  MatchApp
//
//  Created by William Yeung on 3/29/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?
    
    
    func configureCell(card: Card) {
        
        // keep track of the card this cell represents
        self.card = card
        // set the front image view to the image that represents the card
        frontImageView.image = UIImage(named: card.imageName)
        
        // reset the state of the cell by checking the flip status of the card and then showing the front or the back image view accordingly
        if card.isFlipped == true {
            flipUp(speed: 0)
        } else {
            flipDown(speed: 0)
        }
        
    }
    
    func flipUp(speed: TimeInterval = 0.3) {
        // flip up animation
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        // set status of card
        card?.isFlipped = true
    }
    
    func flipDown(speed: TimeInterval = 0.3) {
        UIView.transition(from: frontImageView, to: backImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        card?.isFlipped = false
    }
}
