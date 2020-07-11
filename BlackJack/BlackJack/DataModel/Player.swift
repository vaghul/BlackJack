//
//  Player.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-10.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation


class Player : Codable {
    
    var deckOfCards: [Card]?
    var name:String?
    // var totalCardValue = 0
    var hiddenCardValue = 0
    var totalPossibility:[Int] = [0]
    
    init(name:String?) {
        self.name = name
    }
    public func printHand() {
        
        if let deck = deckOfCards {
            for item in deck {
                print(item)
            }
        }
    }
    
    
    func getHandValue()  -> String {
        if totalPossibility.count == 1 {
            return "\(totalPossibility[0])"
        }else{
            return totalPossibility.map{"\($0)"}.joined(separator: "/")
        }
    }
    
    func addCardPossibility(value:Int) {
        if value == 1{
            var temp: [Int] = []
            for item in totalPossibility {
                if (item + 1) <= 21 {
                    temp.append(item + 1)
                }
                if (item + 11) <= 21 {
                    temp.append(item + 11)
                }
            }
            if temp.count == 0 {
                temp.append(totalPossibility.min()! + value)
            }
            totalPossibility = temp
        }else{
            if totalPossibility.count == 1 {
                totalPossibility[0] += value
            }else {
                var temp: [Int] = []
                for item in totalPossibility {
                    let val = item + value
                    if val <= 21 {
                        temp.append(val)
                    }
                }
                if temp.count == 0 {
                    temp.append(totalPossibility.min()! + value)
                }
                totalPossibility = temp
            }
        }
    }
    
    func addCard(card:Card?) {
        guard card != nil  else {
            return
        }
        if deckOfCards == nil {
            deckOfCards = [card!]
        }else{
            deckOfCards?.append(card!)
        }
        
        if card!.ishidden {
            hiddenCardValue = card!.rank.rawValue
        }else{
            addCardPossibility(value: (card!.rank.rawValue >= 11) ? 10 : card!.rank.rawValue)
        }
    }
    
    func isBlackJack() ->Bool {
        return totalPossibility.contains(21)
    }
    
    func isBust() -> Bool {
        return totalPossibility.min()! > 21
    }
    
}

class Dealer : Player {
    
    func canhit() -> Bool {
        return totalPossibility.min()! < 17
    }
    func unHideCard() {
        deckOfCards![0].ishidden = false
        addCardPossibility(value: (hiddenCardValue >= 11) ? 10 : hiddenCardValue)
        hiddenCardValue = 0
    }
    func scoreCompare(with opponent:Player) -> String {
        
        if self.totalPossibility.max()! > opponent.totalPossibility.max()! && !self.isBust(){
            return "Dealer Won"
        }else if self.totalPossibility.contains(opponent.totalPossibility.max()!){
            return "Pass"
        }else {
            return "You Won"
        }
    }
    
}
