//
//  ViewController.swift
//  MatchApp
//
//  Created by William Yeung on 3/28/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    let model = CardModel()
    var cardsArray: [Card]!
    
    var firstFlippedCardIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsArray = model.getCards()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // MARK: - CollectionView Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // creates cell matching the prototype and casting it as a custom cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // configure the state of the cell based on the properties of the card that it represents
    
        let cardCell = cell as? CardCollectionViewCell
        // set that cell's front image with the card image belonging to card with the same index as the cell
        cardCell?.configureCell(card: cardsArray[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // get a referece to the cell that  was tapped
        if let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
            if cell.card?.isFlipped == false && cell.card?.isMatched == false {
                cell.flipUp()
                
                // check if its the first card flipped or second
                if firstFlippedCardIndex == nil {
                    // first card flipped
                    firstFlippedCardIndex = indexPath
                } else {
                    // second card flipped
                    // comparison logic
                    checkForMatch(indexPath)
                }
            }
        }
    }
    
    // MARK: - Game logic Methods
    
    func checkForMatch(_ secondFlippedCardIndex: IndexPath) {
        // get the two card objects for the two indices and see if they match
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[secondFlippedCardIndex.row]
        
        // get the two collection view cells that represent cardone and cardtwo
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        if cardOne.imageName == cardTwo.imageName {
            // its a match
            // set the status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
        } else {
            // not a match
            // flip them back over
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        // reset the firstFlippedCardIndex property
        firstFlippedCardIndex = nil
    }
}

