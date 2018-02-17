/*Copyright (c) 2016, Andrew Walz.

Redistribution and use in source and binary forms, with or without modification,are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */

// MARK: IMPORT STATEMENTS
import UIKit

// MARK: PHOTO VIEW CONTROLLER - CLASS
class PhotoViewController: UIViewController {
    
    // MARK: PROPERTIES
	public var backgroundImage: UIImage!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK: VIEW DID LOAD - FUNCTION
	override func viewDidLoad() {
		super.viewDidLoad()
        
        closeButton.setImage(#imageLiteral(resourceName: "closeButton"), for: .normal)
        closeButton.setImage(#imageLiteral(resourceName: "closeButton"), for: .highlighted)
        closeButton.addAnimations()
        
		backgroundImageView.image = backgroundImage
	}
    
    // MARK: DISMISS
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: PREFERRED STATUS BAR STYLE - VARIABLE
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
