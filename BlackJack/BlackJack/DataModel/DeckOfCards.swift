//
//  Deck.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-10.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation


/// Representing a deck of cards with methods to manipulate it.
class DeckOfCards {
  
  /// Holds a deck of cards
  var deckOfCards: [Card]
  
  /// Constructor method for creating a deck of cards
  init() {
    self.deckOfCards = [Card]()
    
    for rank in Rank.allValues {
      for suit in Suit.allValues {
        self.deckOfCards.append(Card(rank: rank, suit: suit))
      }
    }
  }
  
  /// Deals one card from the current deck. Pops the last card from the deck.
  ///
  /// - Returns: The last card of the deck
    func dealOneCard(ishidden:Bool = false) -> Card {
        var dealCard = deckOfCards.removeLast()
        dealCard.ishidden = ishidden
        return dealCard
  }
  
  /// Shuffles the deck into random order
  func shuffle() {
    var shuffled = [Card]()
    
    // Fisher-Yates shuffle algorithm
    for _ in 0 ..< deckOfCards.count {
      // Get a random that is within the length of the array
      let randomNumber = Int(arc4random_uniform(UInt32(deckOfCards.count)))
      
      // Remove a card and then put it into shuffled array
      shuffled.append(deckOfCards.remove(at: randomNumber))
    }
    
    deckOfCards = shuffled
  }
  
  /// Pops the last card in deck until no card is left
  func dealAllCards() {
    while deckOfCards.count > 0 {
      print("Dealing \(dealOneCard().simpleDescription())")
    }
  }
}
