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
    @IBOutlet weak var timerLabel: UILabel!
    let model = CardModel()
    var cardsArray: [Card]!
    var firstFlippedCardIndex: IndexPath?
    var soundPlayer = SoundManager()
    
    var timer: Timer?
    var milliseconds: Int = 40 * 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsArray = model.getCards()
        collectionView.dataSource = self
        collectionView.delegate = self
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        // play shuffle sound
        soundPlayer.playSound(effect: .shuffle)
    }
    
    // MARK: - Timer Methods
    @objc func timerFired() {
        milliseconds -= 1
        
        let seconds: Double = Double(milliseconds) / 1000.0
        timerLabel.text = String(format: "Time Remaining: %.2f", seconds)
        
        if milliseconds == 0 {
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            checkForGameEnd()
        }
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
        
        // check if there is any time remaining. dont let the user interact if the time is 0
        if milliseconds <= 0 {
            return
        }
        
        // get a referece to the cell that  was tapped
        if let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
            if cell.card?.isFlipped == false && cell.card?.isMatched == false {
                cell.flipUp()
                
                // play sound
                soundPlayer.playSound(effect: .flip)
                
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
            // play match sound
            soundPlayer.playSound(effect: .match)
            // set the status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            checkForGameEnd()
        } else {
            // not a match
            // play non match sound
            soundPlayer.playSound(effect: .nomatch)
            // flip them back over
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        // reset the firstFlippedCardIndex property
        firstFlippedCardIndex = nil
    }
    
    
    func checkForGameEnd() {
        // check if any card is unmatched
        // assume the user has won, loop through all the cards to seeif all of the cards are matched
        var hasWon = true
        
        for card in cardsArray {
            if !card.isMatched {
                hasWon = false
                break
            }
        }
            
        if hasWon {
            showAlert(title: "Congratulations!", message: "You've won the game")
        } else {
            if milliseconds <= 0 {
                showAlert(title: "Time's Up", message: "Sorry, better luck next time!")
            }
        }
    }
    
    
    func showAlert(title: String, message: String) {
        // create an alert popup
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an ok button to dismiss the alert popup
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        // add the ok button to the alert popup
        alert.addAction(okAction)
        // show the alert
        present(alert, animated: true, completion: nil)
    }
}

