//
//  ViewController.swift
//  Instagrid
//
//  Created by Elodie Desmoulin on 29/01/2020.
//  Copyright © 2020 Elodie Desmoulin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Public

    // MARK: Outlet

    @IBOutlet weak var centralView: CentralView!
    @IBOutlet weak var layoutButton1: UIButton!
    @IBOutlet weak var layoutButton2: UIButton!
    @IBOutlet weak var layoutButton3: UIButton!
    @IBOutlet weak var swipeMessage: UILabel!
    @IBOutlet var gridImages: [UIButton]!

    // MARK: App Running

    override func viewDidLoad() {
        super.viewDidLoad()
        centralView.layout = model.layout
        imagePicker.delegate = self

        // Swipe in Portrait Mode
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(whichSwipe(_:)))
        centralView.addGestureRecognizer(swipeUp)
            swipeUp.direction = .up

        // Swipe in Landscape Mode
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(whichSwipe(_:)))
        centralView.addGestureRecognizer(swipeLeft)
            swipeLeft.direction = .left

        // Notification listener
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(deviceOrientationChanged),
                                       name: Notification.Name("UIDeviceOrientationDidChangeNotification"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(updateLayout),
                                       name: Notification.Name("layoutUpdated"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(updateImage),
                                       name: Notification.Name("imageUpdated"), object: nil)
        //Default Layout selected
        didTapLayoutButton(layoutButton3)
    }

    // MARK: Device Rotation

    // Get orientation
    @objc func deviceOrientationChanged() {
        didRotate(interfaceOrientation: UIApplication.shared.statusBarOrientation)
    }

    // MARK: Layout Button

    // Say to Model which LayoutBtn tapped
    @IBAction func didTapLayoutButton(_ button: UIButton) {
        switch button {
        case layoutButton1:
            model.layout = .topRectangle
        case layoutButton2:
            model.layout = .bottomRectangle
        case layoutButton3:
            model.layout = .fourSquare
        default:
            break
        }
    }

    // Mark the selected layout button as it
    @objc func updateLayout() {
        switch model.layout {
        case .topRectangle:
            layoutButton1.setImage(UIImage(named: "Selected"), for: .normal)
            layoutButton2.setImage(nil, for: .normal)
            layoutButton3.setImage(nil, for: .normal)
            // Adjust CentralView on 1st Layout
            centralView.layout = .topRectangle
        case .bottomRectangle:
            layoutButton1.setImage(nil, for: .normal)
            layoutButton2.setImage(UIImage(named: "Selected"), for: .normal)
            layoutButton3.setImage(nil, for: .normal)
            // Adjust CentralView on 2nd Layout
            centralView.layout = .bottomRectangle
        case .fourSquare:
            layoutButton1.setImage(nil, for: .normal)
            layoutButton2.setImage(nil, for: .normal)
            layoutButton3.setImage(UIImage(named: "Selected"), for: .normal)
            // Adjust CentralView on 3rd Layout
            centralView.layout = .fourSquare
        }
    }

    // MARK: Add Pictures

    // Open library when AddButton tapped
    @IBAction func didTapeButton(_ sender: Any) {
            let alert = UIAlertController(title: "Choose a photo", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.tappedButton = sender as? UIButton
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(imagePicker, animated: true, completion: nil)
        }

    // Set image from library into selected box
    @objc func updateImage() {
        guard let image = self.selectedImage else {
            presentAlert(title: "Error", message: "No Image Selected")
            return
        }
        self.tappedButton?.setImage(image, for: UIControl.State.normal)
        self.tappedButton?.imageView?.contentMode = .scaleAspectFill
    }

    // MARK: Swipe and Share

    // Manage swipe direction depending on screen orientation
    @objc func whichSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .up && UIScreen.main.bounds.size.height > UIScreen.main.bounds.size.width {
            CentralView.animate(withDuration: 1) {
            self.centralView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            }
            self.shareCentralView()
        } else if sender.direction == .left &&  UIScreen.main.bounds.size.height < UIScreen.main.bounds.size.width {
            CentralView.animate(withDuration: 1) {
            self.centralView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            }
            self.shareCentralView()
        }
    }

    // MARK: - Private

    private let imagePicker = UIImagePickerController()
    private var tappedButton: UIButton?
    private var selectedImage: UIImage?
    private let model = Model()

    // Change swipe text depending on screen orientation
    private func didRotate(interfaceOrientation: UIInterfaceOrientation) {
        switch interfaceOrientation {
        case .portrait:
            swipeMessage.text = "Swipe up to share"
        default:
            swipeMessage.text = "Swipe left to share"
        }
    }

    // Share grid if full
    private func shareCentralView() {
        if model.hasCentralViewEmptyBox {
            presentAlert(title: "Error", message: "Missing Image")
            CentralView.animate(withDuration: 0.5, animations: {
            self.centralView.transform = .identity
            })
        } else {
            guard let imageCentralView = convertToImage() else {
                presentAlert(title: "Error", message: "Can't convert grid into image")
                return
            }
        let activityApplicationsView = UIActivityViewController(activityItems: [imageCentralView],
                                                                applicationActivities: nil)
        present(activityApplicationsView, animated: true, completion: nil)
        activityApplicationsView.completionWithItemsHandler = { _, _, _, _ in
            CentralView.animate(withDuration: 0.5, animations: {
                self.centralView.transform = .identity
            })
            }
        }
    }

    // Convert the central grid into an image
    private func convertToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(centralView.bounds.size, true, 0)
        centralView.drawHierarchy(in: centralView.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

    // MARK: - Extension

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = pickedImage
            model.emptyBoxes[self.tappedButton!.tag] = false
        }
        dismiss(animated: true, completion: nil)
    }

    private func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
