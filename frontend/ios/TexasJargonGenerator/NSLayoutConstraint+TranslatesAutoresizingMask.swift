import Foundation
import UIKit

// Taken from https://www.innoq.com/en/blog/ios-auto-layout-problem/
extension NSLayoutConstraint {
    public class func useAndActivateConstraints(_ constraints: [NSLayoutConstraint]) {
        for constraint in constraints {
            if let view = constraint.firstItem as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }

        activate(constraints)
    }
}
