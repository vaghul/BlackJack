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
        view.setTitle("Main Menu", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
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

    }

}
