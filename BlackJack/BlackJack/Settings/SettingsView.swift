//
//  SettingsView.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-11.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    weak var delegate:GameViewDelegate?
    
    let imageViewBackground:UIImageView = {
        let view = UIImageView(image: UIImage(named: "Background"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    
    let buttonLeave:ButtonGame = {
        let view = ButtonGame()
        view.setTitle(Constants.shared.PlaceholderTitleMainMenu, for: .normal)
        view.titleLabel?.font = .regularAppDisclaimer
        return view
    }()
    
    
    let buttonAddBalance:ButtonGame = {
        let view = ButtonGame()
        view.tag = 0
        view.setTitle(Constants.shared.PlaceholderTitleAddBalance, for: .normal)
        return view
    }()
    
    let buttonMinBet:ButtonGame = {
        let view = ButtonGame()
        view.tag = 1
        view.setTitle(Constants.shared.PlaceholderTitleChangeMinBet, for: .normal)
        return view
    }()
    
    let buttonRules:ButtonGame = {
        let view = ButtonGame()
        view.tag = 2
        view.setTitle(Constants.shared.PlaceholderTitleGameInstruction, for: .normal)
        return view
    }()
    
    let viewBet:viewBets = {
        let view = viewBets()
        view.isHidden = true
        return view
    }()
    
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
        
        addSubview(buttonLeave)
        buttonLeave.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        buttonLeave.widthAnchor.constraint(equalToConstant: 120).isActive = true
        buttonLeave.heightAnchor.constraint(equalToConstant: 30).isActive = true
        buttonLeave.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        let menuStack = UIStackView(arrangedSubviews: [buttonAddBalance,buttonMinBet,buttonRules])
        menuStack.translatesAutoresizingMaskIntoConstraints = false
        menuStack.alignment = .center
        menuStack.distribution = .fillEqually
        menuStack.spacing = 20
        menuStack.axis = .vertical
        
        buttonAddBalance.widthAnchor.constraint(equalToConstant: 150).isActive = true
        buttonMinBet.widthAnchor.constraint(equalToConstant: 150).isActive = true
        buttonRules.widthAnchor.constraint(equalToConstant: 150).isActive = true

        let numberofButton = 3
        let buttonHeight = (40 * numberofButton) + (20 * (numberofButton - 1))
        addSubview(menuStack)
        menuStack.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20).isActive = true
        menuStack.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20).isActive = true
        menuStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        menuStack.heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)).isActive = true
        
        buttonAddBalance.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        buttonMinBet.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        buttonRules.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        
        addSubview(viewBet)
        viewBet.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        viewBet.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        viewBet.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        viewBet.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    @objc func onClickButton(_ sender: UIButton) {
        delegate?.onClickInteraction(index: sender.tag)
    }
    
    
}
