//
//  ViewController.swift
//  MatchApp
//
//  Created by William Yeung on 3/28/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let model = CardModel()
    var cardsArray: [Card]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardsArray = model.getCards()
    }


}

