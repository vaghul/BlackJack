//
//  SettingsViewController.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-11.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var viewComponent: SettingsView! { return self.view as? SettingsView }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view = SettingsView(frame: self.view.frame)
        
        viewComponent.delegate = self

    }


}

extension SettingsViewController : GameViewDelegate{
    func onClickLeave() {
        self.navigationController?.popViewController(animated: false)
    }
}
