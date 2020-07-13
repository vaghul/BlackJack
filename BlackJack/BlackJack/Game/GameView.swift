//
//  GameView.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-09.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

protocol GameViewDelegate:class {
    func onClickLeave()
    func onClickInteraction(index:Int)
}

class GameView: UIView {
        
    weak var delegate:GameViewDelegate?
    
    let imageViewBackground:UIImageView = {
        let view = UIImageView(image: UIImage(named: "Background"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let labelBetAmount: UILabel = {
       let view = UILabel()
       view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .mediumAppInfo
       view.textColor = .white
       view.textAlignment = .left
       return view
    }()
    
    let buttonLeave:ButtonGame = {
        let view = ButtonGame()
        view.setTitle(Constants.shared.PlaceholderTitleLeave, for: .normal)
        view.titleLabel?.font = .regularAppDisclaimer
        return view
    }()
    
    let braindelearDeck:viewDeck = {
       let view = viewDeck()
        return view
    }()
    
    let viewGameActions:ViewActions = {
        let view = ViewActions()
        return view
    }()
    
    let brainplayerDeck:viewDeck = {
        let view = viewDeck()
        return view
    }()
    
    let labelBankAmount: UILabel = {
       let view = UILabel()
       view.translatesAutoresizingMaskIntoConstraints = false
       view.font = UIFont.systemFont(ofSize: 18, weight: .medium)
       view.textColor = .white
       view.textAlignment = .left
       return view
    }()
   
    let viewBet:viewBets = {
        let view = viewBets()
        view.isHidden = true
        return view
    }()
       
    func setGameInfo(info:GamePlayInfo) {
        if let bet = info.betValue {
            labelBetAmount.text = "BET : \(bet)"
        }
        if let bank = info.bankvalue {
            labelBankAmount.text = "BANK : \(bank)"
        }
    }
    
    func resetGameInfo() {
        labelBetAmount.text = nil
        labelBankAmount.text = nil
    }

    override init(frame: CGRect) {
          super.init(frame: frame)
          backgroundColor = .white
          layoutSetup()
          
        buttonLeave.addTarget(self, action: #selector(onclickButtonLeave), for: .touchUpInside)
    }
      
    @objc func onclickButtonLeave() {
        delegate?.onClickLeave()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutSetup() {
       
        addSubview(imageViewBackground)
        imageViewBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageViewBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageViewBackground.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageViewBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(labelBetAmount)
        labelBetAmount.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        labelBetAmount.widthAnchor.constraint(equalToConstant: 150).isActive = true
        labelBetAmount.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelBetAmount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        addSubview(buttonLeave)
        buttonLeave.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        buttonLeave.widthAnchor.constraint(equalToConstant: 120).isActive = true
        buttonLeave.heightAnchor.constraint(equalToConstant: 30).isActive = true
        buttonLeave.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true

        let gamePlayStack = UIStackView(arrangedSubviews: [braindelearDeck,viewGameActions,brainplayerDeck])
        gamePlayStack.translatesAutoresizingMaskIntoConstraints = false
        gamePlayStack.alignment = .fill
        gamePlayStack.axis = .vertical
        gamePlayStack.distribution = .fill
        
        
        addSubview(gamePlayStack)
        gamePlayStack.topAnchor.constraint(equalTo: buttonLeave.bottomAnchor,constant: 10).isActive = true
        gamePlayStack.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
        gamePlayStack.bottomAnchor.constraint(equalTo:self.safeAreaLayoutGuide.bottomAnchor,constant: -50).isActive = true
        gamePlayStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true

        braindelearDeck.heightAnchor.constraint(equalToConstant: 180).isActive = true
        brainplayerDeck.heightAnchor.constraint(equalToConstant: 180).isActive = true

        
        addSubview(labelBankAmount)
        labelBankAmount.topAnchor.constraint(equalTo: gamePlayStack.bottomAnchor,constant: 10).isActive = true
        labelBankAmount.widthAnchor.constraint(equalToConstant: 150).isActive = true
        labelBankAmount.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelBankAmount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        
        addSubview(viewBet)
        viewBet.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        viewBet.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        viewBet.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        viewBet.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }

}
