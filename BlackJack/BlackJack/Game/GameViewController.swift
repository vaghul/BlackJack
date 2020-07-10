//
//  GameViewController.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-09.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var viewComponent: GameView! { return self.view as? GameView }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view = GameView(frame: self.view.frame)
        
        viewComponent.delegate = self

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GameViewController : GameViewDelegate {
    func onClickLeave() {
        self.navigationController?.popViewController(animated: false)
    }
}
