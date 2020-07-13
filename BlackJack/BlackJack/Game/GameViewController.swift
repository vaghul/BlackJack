//
//  GameViewController.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-09.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

typealias GameScreenState = (istoastPresenting:Bool,isGamePlaying:Bool,shouldResume:Bool)
class GameViewController: UIViewController {

    var viewComponent: GameView! { return self.view as? GameView }
    var deck:DeckOfCards?
    var screenState:GameScreenState = GameScreenState(istoastPresenting:false,isGamePlaying:false,shouldResume:false)
    var gameInfo:GamePlayInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view = GameView(frame: self.view.frame)
        
        viewComponent.delegate = self
        deck = DeckOfCards()
        deck?.delegate = self
        viewComponent.viewGameActions.delegate = self
        viewComponent.viewBet.delegate = self
        if screenState.shouldResume {
            let storedData = GameHelper.shared.retriveGameState()
            if let cards = storedData.deck{
                deck?.deckOfCards = cards
            }
            if let arrayPlayers = storedData.player {
                //players = arrayPlayers
                viewComponent.braindelearDeck.setPlayer(object: arrayPlayers[0])
                viewComponent.brainplayerDeck.setPlayer(object: arrayPlayers[1])
                
                if viewComponent.brainplayerDeck.isPlayerBlackJacked() {
                    showAlert(message: "BlackJacked !!")
                    if let bet = storedData.game?.betValue, let bank = storedData.game?.bankvalue {
                        GameHelper.shared.saveGameSetting(minAmount: nil, bank: bank + (bet * 2))
                    }
                }

            }
            if let info = storedData.game {
                gameInfo = info
                viewComponent.setGameInfo(info: info)
            }
            screenState.isGamePlaying = true
        }
        viewComponent.viewGameActions.setActionValue(isnewGame: !screenState.isGamePlaying)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let dealer = viewComponent.braindelearDeck.getDealerObj(),
            let player = viewComponent.brainplayerDeck.getPlayerObj(),
            let cards = deck?.deckOfCards,
            let game = gameInfo {
                GameHelper.shared.saveGameState(players: [dealer,player], deck: cards,game: game)
        }
    }
    
    func startGame() {
        screenState.isGamePlaying = true
        self.viewComponent.viewGameActions.setActionValue(isnewGame: !self.screenState.isGamePlaying)

        deck?.shuffle()
        setPlayers()
        dealCards()
        
        if viewComponent.brainplayerDeck.isPlayerBlackJacked() {
            showAlert(message: "BlackJacked !!")
            if let bet = gameInfo?.betValue, let bank = gameInfo?.bankvalue {
                GameHelper.shared.saveGameSetting(minAmount: nil, bank: bank + (bet * 2))
            }
        }

        if let info = gameInfo {
            viewComponent.setGameInfo(info: info)
        }
    }
    func endGame() {
        self.screenState.isGamePlaying = false
        self.viewComponent.viewGameActions.setActionValue(isnewGame: !self.screenState.isGamePlaying)
//        self.players = nil
        var defaultSettings = GameHelper.shared.getGameSetting()
        GameHelper.shared.saveGameSetting(minAmount: nil, bank: defaultSettings.getBankBalance())
        viewComponent.resetGameInfo()
        viewComponent.braindelearDeck.resetPlayersHand()
        viewComponent.brainplayerDeck.resetPlayersHand()

    }
    func setPlayers() {
        viewComponent.braindelearDeck.setPlayer(object: Dealer(name: "Dealer"))
        viewComponent.brainplayerDeck.setPlayer(object: Player(name: "You"))
    }
    
    func dealCards(noOfCards:Int = 2) {
        for i in 0..<noOfCards {
            viewComponent.braindelearDeck.addCard(dealtCard: deck?.dealOneCard(ishidden: (i == 0) ? true : false ))
            viewComponent.brainplayerDeck.addCard(dealtCard: deck?.dealOneCard())
        }
    }
    
    func showAlert(message:String,isgameEnd:Bool = true) {
        
        // the alert view
        if screenState.istoastPresenting == false {
            screenState.istoastPresenting = true
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            // change to desired number of seconds (in this case 5 seconds)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alert.dismiss(animated: true, completion: nil)
                self.screenState.istoastPresenting = false
                if isgameEnd {
                    self.endGame()
                }
            }
        }else{
            let when = DispatchTime.now() + 1.2
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

extension GameViewController : GameViewDelegate , ViewActionsDelegate ,DeckOfCardsDelegate, viewBetsDelegate {
    func onClickLeave() {
        self.navigationController?.popViewController(animated: false)
    }
    func onClickInteraction(index: Int) {
        
    }
    
    func onClickLeft() {
        if screenState.isGamePlaying {
            let dealer = self.viewComponent.braindelearDeck.getDealerObj()!
            self.viewComponent.braindelearDeck.unHideCard()
            while dealer.canhit() {
                self.viewComponent.braindelearDeck.addCard(dealtCard: deck?.dealOneCard())
            }
            //viewComponent.viewdelearDeck.setViewElements(playervalue: players![0])
            let gameStatus = dealer.scoreCompare(with: viewComponent.brainplayerDeck.getPlayerObj()!)
            
            if gameStatus == .player_won || gameStatus == .pass {
                if let bet = gameInfo?.betValue, let bank = gameInfo?.bankvalue {
                    GameHelper.shared.saveGameSetting(minAmount: nil, bank: bank + (bet * ((gameStatus == .pass) ? 1 : 2)))
                }
            }
            showAlert(message: gameStatus.rawValue)
        }else{
            var defaultSettings = GameHelper.shared.getGameSetting()
            if defaultSettings.canBet() {
                gameInfo = GamePlayInfo(betValue: defaultSettings.minBet, bankvalue: defaultSettings.getBankBalance())
                startGame()
            }else{
                showAlert(message: "Insufficient Balance", isgameEnd: false)
            }
            
        }
    }
    
    func onClickRight() {
        if screenState.isGamePlaying {
            viewComponent.brainplayerDeck.addCard(dealtCard: deck?.dealOneCard())
            
            if viewComponent.brainplayerDeck.isPlayerBust() {
                showAlert(message: "Bust")
            }
        }else{
            viewComponent.viewBet.isHidden = false
        }
    }
    
    func didShuffle() {
        showAlert(message: "Shuffling Card",isgameEnd: false)
    }
    
    func onClickClose() {
        viewComponent.viewBet.isHidden = true
    }
    func onClickChip(value: Int) {
        viewComponent.viewBet.isHidden = true
        let defaultSettings = GameHelper.shared.getGameSetting()
        if defaultSettings.bankBalance - value >= 0 {
            gameInfo = GamePlayInfo(betValue: value, bankvalue: defaultSettings.bankBalance - value)
            GameHelper.shared.saveGameSetting(minAmount: nil, bank: defaultSettings.bankBalance - value)
            startGame()
        }else{
            showAlert(message: "Insufficient Balance", isgameEnd: false)
        }
    }
}
