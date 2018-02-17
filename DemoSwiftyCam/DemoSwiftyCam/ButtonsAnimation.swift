// MARK: IMPORT STATEMENTS
import UIKit

// MARK: EXTENSION
extension UIButton {
    
    func addAnimations() {
        self.addTarget(self, action: #selector(buttonTouchDown(sender:)), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTouchUpInside(sender:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonTouchUp(sender:)), for: .touchUpOutside)
        self.addTarget(self, action: #selector(buttonTouchUp(sender:)), for: .touchDragExit)
        self.addTarget(self, action: #selector(buttonTouchUp(sender:)), for: .touchCancel)
    }
    
    // MARK: BUTTON TOUCH - FUNCTIONS
    @objc func buttonTouchDown(sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.alpha = 0.5
        }
    }
    
    @objc func buttonTouchUp(sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.alpha = 1.0
        }
    }
    
    @objc func buttonTouchUpInside(sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.alpha = 1.0
        }
    }
    
}
