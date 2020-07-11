//
//  GameHelper.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-10.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation

typealias Gamestate = (player:[Player]?,deck:[Card]?)

class GameHelper {
    
    static let shared = GameHelper()
    
    
    var isGameAvailable:Bool {       
        return UserDefaults.standard.bool(forKey: "GAMESAVED")
    }
    
    func saveGameState(players:[Player],deck:[Card]) {
        
        if let encoded = try? JSONEncoder().encode(players) {
            UserDefaults.standard.set(encoded, forKey: "PLAYERS")
        }
        
        if let encoded = try? JSONEncoder().encode(deck) {
            UserDefaults.standard.set(encoded, forKey: "DECK")
        }
        
        UserDefaults.standard.set(true, forKey: "GAMESAVED")
        UserDefaults.standard.synchronize()

    }
    
    func retriveGameState() -> Gamestate {
        var state:Gamestate = Gamestate(nil,nil)
        if let players = UserDefaults.standard.value(forKey: "PLAYERS") as? Data {
            if let data = try? JSONDecoder().decode([Player].self, from: players) {
                state.player = data
            }
        }
        
        if let deck = UserDefaults.standard.value(forKey: "DECK") as? Data {
            if let data = try? JSONDecoder().decode([Card].self, from: deck) {
                state.deck = data
            }
        }
        
        return state
    }

    
}
