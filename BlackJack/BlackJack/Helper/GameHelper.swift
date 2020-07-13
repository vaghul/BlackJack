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
    
    private var settings:UserSettings?
    
    var isGameAvailable:Bool {       
        return UserDefaults.standard.bool(forKey: Constants.shared.CacheGameSaved)
    }
    
    func saveGameState(players:[Player],deck:[Card],game:GamePlayInfo) {
        
        if let encoded = try? JSONEncoder().encode(players) {
            UserDefaults.standard.set(encoded, forKey: Constants.shared.CachePlayer)
        }
        
        if let encoded = try? JSONEncoder().encode(players[0]) {
            UserDefaults.standard.set(encoded, forKey: Constants.shared.CacheDealer)
        }
        
        if let encoded = try? JSONEncoder().encode(deck) {
            UserDefaults.standard.set(encoded, forKey: Constants.shared.CacheDeck)
        }
        
        if let encoded = try? JSONEncoder().encode(game) {
            UserDefaults.standard.set(encoded, forKey: Constants.shared.CacheGameplay)
        }
        
        UserDefaults.standard.set(true, forKey: Constants.shared.CacheGameSaved)
        UserDefaults.standard.synchronize()
        
    }
    
    func retriveGameState() -> Gamestate {
        var state:Gamestate = Gamestate(nil,nil,nil)
        if let players = UserDefaults.standard.value(forKey: Constants.shared.CachePlayer) as? Data {
            if let data = try? JSONDecoder().decode([Player].self, from: players) {
                state.player = data
            }
            if let dealer = UserDefaults.standard.value(forKey: Constants.shared.CacheDealer) as? Data {
                if let dealerdata = try? JSONDecoder().decode(Dealer.self, from: dealer) {
                    state.player?[0] = dealerdata
                }
            }
        }
        
        
        if let deck = UserDefaults.standard.value(forKey: Constants.shared.CacheDeck) as? Data {
            if let data = try? JSONDecoder().decode([Card].self, from: deck) {
                state.deck = data
            }
        }
        
        if let deck = UserDefaults.standard.value(forKey: Constants.shared.CacheGameplay) as? Data {
            if let data = try? JSONDecoder().decode(GamePlayInfo.self, from: deck) {
                state.game = data
            }
        }
        UserDefaults.standard.removeObject(forKey: Constants.shared.CachePlayer)
        UserDefaults.standard.removeObject(forKey: Constants.shared.CacheDeck)
        UserDefaults.standard.removeObject(forKey: Constants.shared.CacheDealer)
        UserDefaults.standard.removeObject(forKey: Constants.shared.CacheGameplay)
        UserDefaults.standard.removeObject(forKey: Constants.shared.CacheGameSaved)
        UserDefaults.standard.synchronize()
        
        return state
    }
    
    func getGameSetting() -> UserSettings {
        if self.settings == nil {
           setDefaultSetting()
        }
        return self.settings!
    }
    func setDefaultSetting() {
        if let deck = UserDefaults.standard.value(forKey: Constants.shared.CacheSettings) as? Data {
            if let data = try? JSONDecoder().decode(UserSettings.self, from: deck) {
                self.settings = data
            }else{
                self.settings = UserSettings(bankBalance: 1000, minBet: 100)
            }
        }else{
            self.settings = UserSettings(bankBalance: 1000, minBet: 100)
        }
        saveGameSetting(minAmount: settings?.minBet, bank: settings?.bankBalance)
    }
    
    func saveGameSetting(minAmount:Int?,bank:Int?) {
        if self.settings != nil {
            if let bankval = bank {
                self.settings?.bankBalance = bankval
            }
            if let minval = minAmount {
                self.settings?.minBet = minval
            }
            if let encoded = try? JSONEncoder().encode(self.settings!) {
                UserDefaults.standard.set(encoded, forKey: Constants.shared.CacheSettings)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
}
