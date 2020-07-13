//
//  UIFonts+.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-12.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

extension UIFont {
    
    
    class var semiBoldAction: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    
    class var semiBoldTitle: UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    class var semiBoldChip: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    class var heavyAppTitle: UIFont {
        return UIFont.systemFont(ofSize: 40, weight: .heavy)
    }
    
    class var mediumAppInfo: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    class var regularAppDisclaimer: UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .regular)
    }
}
