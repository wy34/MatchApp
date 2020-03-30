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
        
        // set that cell's front image with the card image belonging to card with the same index as the cell
        cell.configureCell(card: cardsArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // get a referece to the cell that  was tapped
        if let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
            if cell.card?.isFlipped == false {
                cell.flipUp()
            } else {
                cell.flipDown()
            }
        }
    }
}

