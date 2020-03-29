//
//  CardModel.swift
//  MatchApp
//
//  Created by William Yeung on 3/29/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import Foundation


class CardModel {
    
    func getCards() -> [Card] {
        // Declare an empty array
        var generateCards = [Card]()
        // Declare a list that keeps track of existing card numbers
        var cardNumbers = [Int]()
        // Randomly generate 8 pairs of cards
        for _ in 1...8 {
            let randomNumber = Int.random(in: 1...13)
            
            if !cardNumbers.contains(randomNumber) {
                cardNumbers.append(randomNumber)
                
                let cardOne = Card()
                let cardTwo = Card()
                
                cardOne.imageName = "card\(randomNumber)"
                cardTwo.imageName = "card\(randomNumber)"
                
                generateCards += [cardOne, cardTwo]
            }
        }
        // Randomize the cards within the array
        generateCards.shuffle()
        
        // Return the array
        return generateCards
    }
}
