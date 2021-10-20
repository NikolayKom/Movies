//
//  NSLayoutConstraint+useAndActivateConstraints.swift
//
//  Created by Николай on 30.09.2021.
//

import UIKit

extension NSLayoutConstraint {

	class func useAndActivateConstraints(_ constraints: [NSLayoutConstraint]) {
		constraints.forEach { constraint in
			if let view = constraint.firstItem as? UIView {
				view.translatesAutoresizingMaskIntoConstraints = false
			}
		}
		activate(constraints)
	}
}

