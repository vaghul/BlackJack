//
//  Settings.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-12.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation


enum GameState: String {
    case dealer_won = "Dealer Won"
    case pass = "Pass"
    case player_won = "You won"
    case player_bust = "Bust"
}


struct GamePlayInfo:Codable {
    var betValue:Int?
    var bankvalue:Int?
}

struct UserSettings:Codable {
    var bankBalance:Int = 500
    var minBet:Int = 100
    
    func canBet() -> Bool {
        return bankBalance - minBet >= 0
    }
    
    mutating func getBankBalance() -> Int {
        bankBalance -= minBet
        return bankBalance
    }
}
