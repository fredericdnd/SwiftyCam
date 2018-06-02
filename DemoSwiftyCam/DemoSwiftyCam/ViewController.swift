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

// MARK: IMPORT STATEME?TS
import UIKit

// MARK: VIEW CONTROLLER - CLASS
class ViewController: SwiftyCamViewController {
    
    // MARK: PROPERTIES
    private let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var captureButton: SwiftyRecordButton!
    @IBOutlet weak var flipCameraButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: VIEW DID LOAD - FUNCTION
	override func viewDidLoad() {
		super.viewDidLoad()
		cameraDelegate = self
		maximumVideoDuration = 10.0
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = true
        flipCameraButton.addAnimations()
        flashButton.addAnimations()
        promptPrivacyAlert = false
        
        flipCameraButton.setImage(#imageLiteral(resourceName: "flipCamera"), for: .normal)
        flipCameraButton.setImage(#imageLiteral(resourceName: "flipCamera"), for: .highlighted)
        
        closeButton.setImage(#imageLiteral(resourceName: "closeButton"), for: .normal)
        closeButton.setImage(#imageLiteral(resourceName: "closeButton"), for: .highlighted)
        closeButton.addAnimations()
	}

    // MARK: VIEW DID APPEAR - FUNCTION
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
        captureButton.delegate = self
	}

    // MARK: CAMERA SWITCH TAPPED - FUNCTION
    @IBAction func cameraSwitchTapped(_ sender: Any) {
        switchCamera()
    }
    
    // MARK: TOGGLE FLASH TAPPED - FUNCTION
    @IBAction func toggleFlashTapped(_ sender: Any) {
        flashEnabled = !flashEnabled
        
        if flashEnabled == true {
            flashButton.setImage(#imageLiteral(resourceName: "flashOn"), for: .normal)
            flashButton.setImage(#imageLiteral(resourceName: "flashOn"), for: .highlighted)
        } else {
            flashButton.setImage(#imageLiteral(resourceName: "flashOff"), for: .normal)
            flashButton.setImage(#imageLiteral(resourceName: "flashOff"), for: .highlighted)
        }
    }
    
    // MARK: DISMISS - FUNCTION
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: PREFERRED STATUS BAR STYLE - VARIABLE
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension ViewController: SwiftyCamViewControllerDelegate {
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        guard let photoViewController = mainStoryboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else {
            return
        }
        
        photoViewController.backgroundImage = photo
        photoViewController.modalTransitionStyle = .crossDissolve
        self.present(photoViewController, animated: true, completion: nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did Begin Recording")
        captureButton.growButton()
        UIView.animate(withDuration: 0.25, animations: {
            self.flashButton.alpha = 0.0
            self.flipCameraButton.alpha = 0.0
        })
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did finish Recording")
        captureButton.shrinkButton()
        UIView.animate(withDuration: 0.25, animations: {
            self.flashButton.alpha = 1.0
            self.flipCameraButton.alpha = 1.0
        })
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        guard let videoViewController = mainStoryboard.instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController else {
            return
        }
        
        videoViewController.videoURL = url
        videoViewController.modalTransitionStyle = .crossDissolve
        self.present(videoViewController, animated: true, completion: nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }, completion: { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }, completion: { (success) in
                focusView.removeFromSuperview()
            })
        })
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        print(zoom)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        print(camera)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error) {
        print(error)
    }
    
}

