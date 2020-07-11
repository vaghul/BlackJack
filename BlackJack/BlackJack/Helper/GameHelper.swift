//
//  GameHelper.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-10.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import Foundation

typealias Gamestate = (player:[Player]?,deck:[Card]?,game:GamePlayInfo?)

class GameHelper {
    
    static let shared = GameHelper()
    
    
    var isGameAvailable:Bool {       
        return UserDefaults.standard.bool(forKey: "GAMESAVED")
    }
    
    func saveGameState(players:[Player],deck:[Card],game:GamePlayInfo) {
        
        if let encoded = try? JSONEncoder().encode(players) {
            UserDefaults.standard.set(encoded, forKey: "PLAYERS")
        }
        
        if let encoded = try? JSONEncoder().encode(players[0]) {
            UserDefaults.standard.set(encoded, forKey: "DEALER")
        }
        
        if let encoded = try? JSONEncoder().encode(deck) {
            UserDefaults.standard.set(encoded, forKey: "DECK")
        }
        
        if let encoded = try? JSONEncoder().encode(game) {
            UserDefaults.standard.set(encoded, forKey: "GAMEPLAY")
        }
        
        UserDefaults.standard.set(true, forKey: "GAMESAVED")
        UserDefaults.standard.synchronize()

    }
    
    func retriveGameState() -> Gamestate {
        var state:Gamestate = Gamestate(nil,nil,nil)
        if let players = UserDefaults.standard.value(forKey: "PLAYERS") as? Data {
            if let data = try? JSONDecoder().decode([Player].self, from: players) {
                state.player = data
            }
            if let dealer = UserDefaults.standard.value(forKey: "DEALER") as? Data {
                if let dealerdata = try? JSONDecoder().decode(Dealer.self, from: dealer) {
                    state.player?[0] = dealerdata
                }
            }
        }
      
        
        if let deck = UserDefaults.standard.value(forKey: "DECK") as? Data {
            if let data = try? JSONDecoder().decode([Card].self, from: deck) {
                state.deck = data
            }
        }
        
        if let deck = UserDefaults.standard.value(forKey: "GAMEPLAY") as? Data {
            if let data = try? JSONDecoder().decode(GamePlayInfo.self, from: deck) {
                state.game = data
            }
        }
        UserDefaults.standard.removeObject(forKey: "PLAYERS")
        UserDefaults.standard.removeObject(forKey: "DECK")
        UserDefaults.standard.removeObject(forKey: "DEALER")
        UserDefaults.standard.removeObject(forKey: "GAMEPLAY")
        UserDefaults.standard.removeObject(forKey: "GAMESAVED")
        UserDefaults.standard.synchronize()

        return state
    }

    
}
