//
//  SettingsViewController.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-11.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit
import SafariServices

class SettingsViewController: UIViewController {

    var viewComponent: SettingsView! { return self.view as? SettingsView }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view = SettingsView(frame: self.view.frame)
        
        viewComponent.delegate = self
        viewComponent.viewBet.delegate = self
    }


}

extension SettingsViewController : GameViewDelegate, viewBetsDelegate{
    func onClickLeave() {
        self.navigationController?.popViewController(animated: false)
    }
    func onClickInteraction(index: Int) {
        if index == 0 {
            shoeLoadMoney()
        }else if index == 1{
            viewComponent.viewBet.isHidden = false
        }else if index == 2{
            if let url = URL(string: "http://en.wikipedia.org/wiki/Blackjack") {
                let safariVC = SFSafariViewController(url: url)
                safariVC.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(safariVC, animated: true)
            }
        }
    }
    
    func onClickClose() {
        viewComponent.viewBet.isHidden = true
    }
    func shoeLoadMoney() {
        let alertController = UIAlertController(title: "Load Bank", message: "Enter the amount to load", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "amount"
            textField.keyboardType = .numberPad
        }
        let saveAction = UIAlertAction(title: "Add", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            if let val = Int(firstTextField.text ?? "0") {
                if val != 0 {
                    GameHelper.shared.saveGameSetting(minAmount: nil, bank: val)
                    self.showAlert(message: "$\(val) loaded")
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func onClickChip(value: Int) {
        GameHelper.shared.saveGameSetting(minAmount: value, bank: nil)
        viewComponent.viewBet.isHidden = true
    }
    
    func showAlert(message:String) {
          
        // the alert view
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
}
