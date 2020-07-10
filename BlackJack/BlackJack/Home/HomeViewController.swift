//
//  HomeViewController.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-09.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var viewComponent: HomeView! { return self.view as? HomeView }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        self.view = HomeView(frame: self.view.frame)
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

extension HomeViewController:HomeViewDelegate {
    func onClickGameMenu(index: Int) {
        if index == 0 {
            
        }else if index == 1{
            let gameVc = GameViewController()
            self.navigationController?.pushViewController(gameVc, animated: false)
        }else if index == 2{
            
        }
    }
}
