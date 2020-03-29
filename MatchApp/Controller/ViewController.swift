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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        return cell
    }
}

