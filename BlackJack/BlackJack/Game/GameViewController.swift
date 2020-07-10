//
//  GameViewController.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-09.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var viewComponent: GameView! { return self.view as? GameView }
    var deck:DeckOfCards?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view = GameView(frame: self.view.frame)
        
        viewComponent.delegate = self
        deck = DeckOfCards()
        deck?.shuffle()
        
        let player1 = Dealer(name: "Dealer")
        player1.addCard(card: deck?.dealOneCard(ishidden: true))
        
        let player2 = Player(name:"Player")
        player2.addCard(card: deck?.dealOneCard())
        
        player1.addCard(card: deck?.dealOneCard())
        player2.addCard(card: deck?.dealOneCard())
        
        print(player1.printHand())
        print(player2.printHand())
        print(deck?.deckOfCards.count)
        
        viewComponent.viewdelearDeck.setViewElements(playervalue: player1)
        viewComponent.viewplayerDeck.setViewElements(playervalue: player2)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GameViewController : GameViewDelegate {
    func onClickLeave() {
        self.navigationController?.popViewController(animated: false)
    }
}
