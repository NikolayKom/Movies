//
//  ChangeColorLabel.swift
//  Movies
//
//  Created by Николай on 08.10.2021.
//

import UIKit

extension UILabel {
    
     func changeColorBy(rating: Double) {
        switch rating {
        case 5...6:
            textColor = UIColor(red: 0.372, green: 0.372, blue: 0.372, alpha: 1.0)
        case 0..<5:
            textColor = UIColor(red: 1, green: 0.004, blue: 0.004, alpha: 1.0)
        default:
            textColor = UIColor(red: 0, green: 0.48, blue: 0, alpha: 1.0)
        }
    }
}
