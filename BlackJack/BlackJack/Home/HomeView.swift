//
//  HomeView.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-09.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

protocol HomeViewDelegate:class {
    func onClickGameMenu(index:Int)
}

class HomeView: UIView {
    
    weak var delegate:HomeViewDelegate?
    
    let imageViewBackground:UIImageView = {
        let view = UIImageView(image: UIImage(named: "Background"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let imageViewHeader:UIImageView = {
        let view = UIImageView(image: UIImage(named: "aces"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let labelTitle:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        view.text = "Black Jack"
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    
    let buttonResume:ButtonGame = {
        let view = ButtonGame()
        view.tag = 0
        view.setTitle("Resume Game", for: .normal)
        return view
    }()
    
    let buttonNewGame:ButtonGame = {
        let view = ButtonGame()
        view.tag = 1
        view.setTitle("New Game", for: .normal)
        return view
    }()
    
    let buttonSetting:ButtonGame = {
        let view = ButtonGame()
        view.tag = 2
        view.setTitle("Setting", for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          backgroundColor = .white
          layoutSetup()
          
        buttonResume.addTarget(self, action: #selector(onClickMenu(_:)), for: .touchUpInside)
        buttonNewGame.addTarget(self, action: #selector(onClickMenu(_:)), for: .touchUpInside)
        buttonSetting.addTarget(self, action: #selector(onClickMenu(_:)), for: .touchUpInside)
      }
    
    @objc func onClickMenu(_ sender:UIButton) {
        delegate?.onClickGameMenu(index: sender.tag)
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
        
        
        addSubview(imageViewHeader)
        imageViewHeader.topAnchor.constraint(equalTo: self.topAnchor,constant: 30).isActive = true
        imageViewHeader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageViewHeader.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageViewHeader.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        addSubview(labelTitle)
        labelTitle.topAnchor.constraint(equalTo: imageViewHeader.bottomAnchor,constant: 20).isActive = true
        labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20).isActive = true
        
        
        let menuStack = UIStackView(arrangedSubviews: [buttonResume,buttonNewGame,buttonSetting])
        menuStack.translatesAutoresizingMaskIntoConstraints = false
        menuStack.alignment = .center
        menuStack.distribution = .fillEqually
        menuStack.spacing = 20
        menuStack.axis = .vertical
        
        buttonResume.widthAnchor.constraint(equalToConstant: 150).isActive = true
        buttonNewGame.widthAnchor.constraint(equalToConstant: 150).isActive = true
        buttonSetting.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        addSubview(menuStack)
        menuStack.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20).isActive = true
        menuStack.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20).isActive = true
        menuStack.topAnchor.constraint(equalTo: labelTitle.bottomAnchor,constant: 50).isActive = true
        menuStack.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }

}
