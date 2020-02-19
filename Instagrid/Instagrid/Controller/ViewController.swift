//
//  ViewController.swift
//  Instagrid
//
//  Created by Elodie Desmoulin on 29/01/2020.
//  Copyright © 2020 Elodie Desmoulin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var centralView: CentralView!
    @IBOutlet weak var layoutButton1: UIButton!
    @IBOutlet weak var layoutButton2: UIButton!
    @IBOutlet weak var layoutButton3: UIButton!
    @IBOutlet weak var swipeMessage: UILabel!
    @IBOutlet var gridImages: [UIButton]!

    let imagePicker = UIImagePickerController()
    var tappedButton: UIButton?
    var viewIsEmpty = [1: true, 2: true, 3: true, 4: true]
    // MARK: - App Running

    override func viewDidLoad() {
        super.viewDidLoad()
        tappedLayoutButton(layoutButton3)
        imagePicker.delegate = self
    // Swipe in Portrait Mode
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(whichSwipe(_:)))
        centralView.addGestureRecognizer(swipeUp)
            swipeUp.direction = .up

    // Swipe in Landscape Mode
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(whichSwipe(_:)))
        centralView.addGestureRecognizer(swipeLeft)
            swipeLeft.direction = .left

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(deviceOrientationChanged),
                                       name: Notification.Name("UIDeviceOrientationDidChangeNotification"), object: nil)
    }

    // MARK: - Device Rotation

    private func didRotate(interfaceOrientation: UIInterfaceOrientation) {
        switch interfaceOrientation {
        case .portrait:
            swipeMessage.text = "Swipe up to share"
        default:
            swipeMessage.text = "Swipe left to share"
        }
    }

    @objc func deviceOrientationChanged() {
        didRotate(interfaceOrientation: UIApplication.shared.statusBarOrientation)
    }

    // MARK: - Add Pictures

        @IBAction func didTapeButton(_ sender: Any) {
            let alert = UIAlertController(title: "Choose a photo", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.tappedButton = sender as? UIButton
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(imagePicker, animated: true, completion: nil)
        }

    // MARK: - Swipe and Share

    @objc func whichSwipe(_ sender: UISwipeGestureRecognizer) {
        checkIfCentralViewEmpty()
        if sender.direction == .up && UIScreen.main.bounds.size.height > UIScreen.main.bounds.size.width {
            UIView.animate(withDuration: 1) {
            self.centralView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
                self.shareCentralView()
            }
        } else if sender.direction != .up &&  UIScreen.main.bounds.size.height < UIScreen.main.bounds.size.width {
            UIView.animate(withDuration: 1) {
            self.centralView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
                self.shareCentralView()
            }
        }
    }

    /// Check if CentralView is empty != sharable or it is not = sharable
    private func checkIfCentralViewEmpty() {
        let alert = UIAlertController(title: "Empty Grid", message: "Your grid is fully or partly empty. Complete it.",
                                      preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                self.centralView.transform = .identity}))
            if !isCentralViewEmpty() {
                self.present(alert, animated: true)
            } else {
                shareCentralView()
            }
        }

    func isCentralViewEmpty() -> Bool {
        switch centralView.layout {
        case .topRectangle:
            return !viewIsEmpty[1]! && !viewIsEmpty[3]! && !viewIsEmpty[4]!
        case .bottomRectangle:
            return !viewIsEmpty[1]! && !viewIsEmpty[2]! && !viewIsEmpty[3]!
        case .fourSquare:
            return !viewIsEmpty[1]! && !viewIsEmpty[2]! && !viewIsEmpty[3]! && !viewIsEmpty[4]!
        }
    }

    private func shareCentralView() {
        let alert = UIAlertController(title: "Error", message: "Can't convert grid into image",
                                  preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        guard let imageCentralView = convertToImage() else {
            self.present(alert, animated: true)
            return
        }
        let activityApplicationsView = UIActivityViewController(activityItems: [imageCentralView],
                                                                applicationActivities: nil)
        present(activityApplicationsView, animated: true, completion: nil)
        activityApplicationsView.completionWithItemsHandler = { _, _, _, _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.centralView.transform = .identity
            })
        }
    }

    /// Convert the central grid into an image
    private func convertToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(centralView.bounds.size, true, 0)
        centralView.drawHierarchy(in: centralView.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    // MARK: - Layout Button

    @IBAction func tappedLayoutButton(_ button: UIButton) {
        switch button {
        case layoutButton1:
            layoutButton1.setImage(UIImage(named: "Selected"), for: .normal)
            layoutButton2.setImage(nil, for: .normal)
            layoutButton3.setImage(nil, for: .normal)
            // Adjust CentralView on 1st Layout
            centralView.layout = .topRectangle
        case layoutButton2:
            layoutButton1.setImage(nil, for: .normal)
            layoutButton2.setImage(UIImage(named: "Selected"), for: .normal)
            layoutButton3.setImage(nil, for: .normal)
            // Adjust CentralView on 2nd Layout
            centralView.layout = .bottomRectangle
        case layoutButton3:
            layoutButton1.setImage(nil, for: .normal)
            layoutButton2.setImage(nil, for: .normal)
            layoutButton3.setImage(UIImage(named: "Selected"), for: .normal)
            // Adjust CentralView on 3rd Layout
            centralView.layout = .fourSquare
        default:
            break
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.tappedButton?.setImage(pickedImage, for: UIControl.State.normal)
            self.tappedButton?.imageView?.contentMode = .scaleAspectFill
            guard let button = self.tappedButton else {return}
            viewIsEmpty[button.tag] = false
        }
        dismiss(animated: true, completion: nil)
    }

    // When user cancelled image picking
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
