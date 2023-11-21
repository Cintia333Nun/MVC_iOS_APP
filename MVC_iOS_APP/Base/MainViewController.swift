//
//  MainViewController.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 19/11/23.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        addDetectTapViewHideKeyboard()
    }
    
    // MARK: Tap View Hide Keyboard
    private func addDetectTapViewHideKeyboard() {
        let tapGesniture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesniture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: Tap Enter Keyboard
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
