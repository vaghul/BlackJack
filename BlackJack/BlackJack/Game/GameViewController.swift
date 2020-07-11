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
    let maxPlayer = 2 // inc dealer
    var players:[Player]?
    var dealer: Dealer! { return self.players?[0] as? Dealer }
    var istoastPresenting = false
    var isGamePlaying = false
    var shouldResume = false
    var gameInfo:GamePlayInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view = GameView(frame: self.view.frame)
        
        viewComponent.delegate = self
        deck = DeckOfCards()
        deck?.delegate = self
        viewComponent.viewGameActions.delegate = self
        if shouldResume {
            let storedData = GameHelper.shared.retriveGameState()
            if let cards = storedData.deck{
                deck?.deckOfCards = cards
            }
            if let arrayPlayers = storedData.player {
                players = arrayPlayers
                viewComponent.viewdelearDeck.setViewElements(playervalue: players![0])
                viewComponent.viewplayerDeck.setViewElements(playervalue: players![1])
                
                if players![1].isBlackJack() {
                    showAlert(message: "BlackJacked !!")
                }

            }
            if let info = storedData.game {
                viewComponent.setGameInfo(info: info)
            }
            isGamePlaying = true
        }
        viewComponent.viewGameActions.setActionValue(isnewGame: !isGamePlaying)

    }
    
    func startGame() {
        isGamePlaying = true
        self.viewComponent.viewGameActions.setActionValue(isnewGame: !self.isGamePlaying)

        deck?.shuffle()
        setPlayers()
        dealCards()

        viewComponent.viewdelearDeck.setViewElements(playervalue: players![0])
        viewComponent.viewplayerDeck.setViewElements(playervalue: players![1])
        
        if players![1].isBlackJack() {
            showAlert(message: "BlackJacked !!")
        }

        if let info = gameInfo {
            viewComponent.setGameInfo(info: info)
        }
    }
    func endGame() {
        self.isGamePlaying = false
        self.viewComponent.viewGameActions.setActionValue(isnewGame: !self.isGamePlaying)
        self.players = nil
        viewComponent.viewdelearDeck.setViewElements(playervalue: nil)
        viewComponent.viewplayerDeck.setViewElements(playervalue: nil)

    }
    func setPlayers() {
        players = [Dealer(name: "Dealer"),Player(name: "Player")]
    }
    
    func dealCards(noOfCards:Int = 2) {
        for i in 0..<noOfCards {
            players![0].addCard(card: deck?.dealOneCard(ishidden: (i == 0) ? true : false ))
            players![1].addCard(card: deck?.dealOneCard())
        }
    }
    
    func showAlert(message:String,isgameEnd:Bool = true) {
        
        // the alert view
        if istoastPresenting == false {
            istoastPresenting = true
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            // change to desired number of seconds (in this case 5 seconds)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alert.dismiss(animated: true, completion: nil)
                self.istoastPresenting = false
                if isgameEnd {
                    self.endGame()
                }
            }
        }else{
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                self.showAlert(message: message,isgameEnd: isgameEnd)
            }
        }
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

extension GameViewController : GameViewDelegate , ViewActionsDelegate ,DeckOfCardsDelegate {
    func onClickLeave() {
        if let arrayplayers = players,let cards = deck?.deckOfCards, let game = gameInfo {
            GameHelper.shared.saveGameState(players: arrayplayers, deck: cards,game: game)
        }
        self.navigationController?.popViewController(animated: false)
    }
    
    func onClickStand() {
        if isGamePlaying {
            dealer.unHideCard()
            while dealer.canhit() {
                dealer.addCard(card: deck?.dealOneCard())
            }
            viewComponent.viewdelearDeck.setViewElements(playervalue: players![0])
            showAlert(message: dealer.scoreCompare(with: players![1]))
        }else{
            gameInfo = GamePlayInfo(betValue: 500, bankvalue: 500)
            startGame()
        }
    }
    
    func onClickHit() {
        if isGamePlaying {
            players![1].addCard(card: deck?.dealOneCard())
            viewComponent.viewplayerDeck.setViewElements(playervalue: players![1])
            
            if players![1].isBust() {
                showAlert(message: "Bust")
            }
        }else{
            
        }
    }
    
    func didShuffle() {
        showAlert(message: "Shuffling Card",isgameEnd: false)
    }
}
