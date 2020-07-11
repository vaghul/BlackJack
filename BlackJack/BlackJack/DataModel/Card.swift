//
//  Card.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-10.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation

/// Defines the data structure for Card
struct Card :Codable {
    var rank: Rank
    var suit: Suit
    var ishidden:Bool
    
    init(rank: Rank, suit: Suit,ishidden:Bool = false) {
        self.rank = rank
        self.suit = suit
        self.ishidden = ishidden
    }
    
    func getImageName() ->String {
        if self.ishidden {
            return "CardPlaceholder"
        }else{
            return "\(rank.simpleDescription())\(suit.simpleDescription())"
        }
    }
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
}

enum Suit: String,Codable {
    
    case Spades, Hearts, Diamonds, Clubs
    
    static let allValues = [Spades, Hearts, Diamonds, Clubs]
    
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "S"
        case .Hearts:
            return "H"
        case .Diamonds:
            return "D"
        case .Clubs:
            return "C"
        }
    }
}

enum Rank: Int,Codable {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    
    static let allValues = [Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King]
    
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "A"
        case .Jack:
            return "J"
        case .Queen:
            return "Q"
        case .King:
            return "K"
        default:
            return String(self.rawValue)
        }
    }
}
