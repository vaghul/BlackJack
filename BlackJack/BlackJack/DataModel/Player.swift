//
//  Player.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-10.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation

class Player {
    
    var deckOfCards: [Card]?
    var name:String?
    
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
        var value = 0
        if let deck = deckOfCards {
            for item in deck {
                if !item.ishidden {
                    value += item.rank.rawValue
                }
            }
        }
        return "\(value)"
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
    }
    
}

class Dealer : Player {
    
    func canhit() {
        
    }
    
}
