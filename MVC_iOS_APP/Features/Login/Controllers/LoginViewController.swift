//
//  LoginViewController.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 17/11/23.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomizeTextFields()
    }

    // MARK: Buttons events
    @IBAction func loginButton(_ sender: UIButton) {
    }
    
    @IBAction func signupButton(_ sender: Any) {
        let signupViewController = SignupViewController()
        //signupViewController.presentationController =
        present(signupViewController, animated: true)
    }
    
    // MARK: Tap View Hide Keyboard
    private func addDetectTapViewHideKeyboard() {
        let tapGesniture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesniture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Tap Enter Keyboard
    private func addDetectEnterTapKeyboard() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: Custom Views Run Time
    private func setCustomizeTextFields() {
        emailTextField.setBorderAndColor()
        emailTextField.setPlaceHolder(textPlaceHolder: "User name")
        emailTextField.addPadding()
        passwordTextField.setBorderAndColor()
        passwordTextField.setPlaceHolder(textPlaceHolder: "Password")
        passwordTextField.addPadding()
    }
}

// MARK: Tap Enter Keyboard
extension LoginViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
