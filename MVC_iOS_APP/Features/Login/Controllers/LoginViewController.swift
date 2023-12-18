//
//  LoginViewController.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 17/11/23.
//

import UIKit

class LoginViewController: MainViewController {
    // MARK: UI Objects
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private let clientDefaults = ClientDefaults.shared
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomizeTextFields()
        checkExistSession()
    }

    // MARK: Buttons events
    @IBAction func loginButton(_ sender: UIButton) {
        checkUserField()
    }
    
    @IBAction func signupButton(_ sender: Any) {
       goToSighnUp()
    }
    
    // MARK: Navigate to XIB
    /// Display the session registration form over this view, in full-screen mode.
    private func goToSighnUp() {
        let signupViewController = SignupViewController()
        signupViewController.modalPresentationStyle = .fullScreen
        signupViewController.isModalInPresentation = true
        present(signupViewController, animated: true)
    }
    
    // MARK: Validate fields
    /// Check if the user field is not empty or null.
    private func checkUserField() {
        let user = emailTextField.text
        
        if let user, !user.isEmpty {
            checkPasswordFiel(user: user)
        } else {
            mandatoryField(fielName: "user")
        }
    }
    
    /// Check if the password field is not empty or null.
    /// - Parameter user: Need user for consume Login API service
    private func checkPasswordFiel(user: String) {
        let password = passwordTextField.text
        
        if let password, !password.isEmpty {
            serviceLogin(user: user, password: password)
        } else {
            mandatoryField(fielName: "password")
        }
    }
    
    /// Make a general alert to show for a required text field.
    /// - Parameter fieldName: For field name to make custom alert.
    private func mandatoryField(fielName: String) {
        self.createSimpleAlert(
            title: "Mandatory field",
            message: "You must fill in the \(fielName) field to continue.",
            buttonText: "Ok"
        )
    }
    
    // MARK: Consume API rest
    /// Consuming the relevant service and updating the UI with a notice regarding the query result. Adding thread change up to this point to accommodate potential future tasks such as storing or processing data from an API response; it's advisable to use DispatchQueue.main.sync up to this point.
    /// - Parameter user: Content email text field
    /// - Parameter password: Content password text field if password and confirm password are same
    private func serviceLogin(user: String, password: String) {
        APILogin().getServiceLogin(email: user, password: password) { result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let statusLogin): self.successResponse(statusLogin: statusLogin)
                case .failure(let error): self.errorResponse(error: error)
                }
            }
        }
    }
    
    private func successResponse(statusLogin: Bool) {
        if(statusLogin) {
            goToMovies()
        }
    }
    
    private func errorResponse(error: APIError) {
        self.createSimpleAlert(
            title: "Error Response",
            message: "Description: \(error.localizedDescription)",
            buttonText: "Ok")
    }
    
    // MARK: Tap Enter Keyboard
    /// Hides the keyboard on the device when the "enter" key is pressed for all TextFields
    private func addDetectEnterTapKeyboard() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: Custom Views Run Time
    /// Sets up the layout for TextFields programmatically, as requested since it couldn't be done visually.
    private func setCustomizeTextFields() {
        emailTextField.setBorderAndColor()
        emailTextField.setPlaceHolder(textPlaceHolder: "User name")
        emailTextField.addPadding()
        passwordTextField.setBorderAndColor()
        passwordTextField.setPlaceHolder(textPlaceHolder: "Password")
        passwordTextField.addPadding()
    }
    
    private func checkExistSession() {
        let userToken = clientDefaults.getToken
        if (userToken == "") {
            goToMovies()
            print("El usuario ya inicio sesión antes")
        }
    }
    
    private func goToMovies() {
        let moviesViewController = MoviesViewController()
        moviesViewController.modalPresentationStyle = .fullScreen
        moviesViewController.isModalInPresentation = true
        present(moviesViewController, animated: true, completion: nil)
    }
}
