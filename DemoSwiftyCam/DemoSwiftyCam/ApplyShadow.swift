// MARK: IMPORT STATEMENTS
import UIKit

// MARK: EXTENSION
extension UIView {
    
    // MARK: APPLY SHADOW - FUNCTION
    func applyShadow(y: CGFloat, radius: CGFloat, opacity: Float) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: y)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    
}
