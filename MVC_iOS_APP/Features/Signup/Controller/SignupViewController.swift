//
//  SignupViewController.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 17/11/23.
//

import UIKit

class SignupViewController: MainViewController {
    // MARK: UI Objects
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    // MARK: View values constants and variants
    /// Save check box policy status
    private var isAgreePolicy = false
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomizeTextFields()
    }

    // MARK: Buttons events
    @IBAction func signupButton(_ sender: UIButton) {
       checkPolicy()
    }
    
    @IBAction func policyButton(_ sender: UIButton) {
        checkBoxPolicy(sender: sender)
    }
    
    @IBAction func signinButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: Tap Enter Keyboard
    /// Hides the keyboard on the device when the "enter" key is pressed for all TextFields
    private func addDetectEnterTapKeyboard() {
        firstName.delegate = self
        lastName.delegate = self
        mailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    // MARK: Custom Views Run Time
    /// Sets up the layout for TextFields programmatically, as requested since it couldn't be done visually.
    private func setCustomizeTextFields() {
        firstName.setBorderAndColor()
        firstName.setPlaceHolder(textPlaceHolder: "First name")
        firstName.addPadding()
        lastName.setBorderAndColor()
        lastName.setPlaceHolder(textPlaceHolder: "Last name")
        lastName.addPadding()
        mailTextField.setBorderAndColor()
        mailTextField.setPlaceHolder(textPlaceHolder: "Email")
        mailTextField.addPadding()
        passwordTextField.setBorderAndColor()
        passwordTextField.setPlaceHolder(textPlaceHolder: "Password")
        passwordTextField.addPadding()
        confirmPasswordTextField.setBorderAndColor()
        confirmPasswordTextField.setPlaceHolder(textPlaceHolder: "Confirm password")
        confirmPasswordTextField.addPadding()
    }
    
    // MARK: CheckBox Policy
    /// Check if the user accepted the privacy policy before validating other fields.
    private func checkPolicy() {
        if (isAgreePolicy) {
            checkUserField()
        } else {
            self.createSimpleAlert(
                title: "Atention",
                message: "You need to accept policy and privacy before Sign up on the app.",
                buttonText: "Ok"
            )
        }
    }
    
    /// Change the button's image to look like a checkbox manually to simulate the component.
    /// - Parameter sender: Needs reference to button for change Image
    private func checkBoxPolicy(sender: UIButton) {
        isAgreePolicy = !isAgreePolicy
        if (isAgreePolicy) {
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "squareshape"), for: .normal)
        }
    }
    
    // MARK: Validate fields
    /// Check if the user field is not empty or null.
    private func checkUserField() {
        let user = mailTextField.text
        
        if let user, !user.isEmpty {
            if (isValidEmail(email: user)) {
                checkPasswordsFiels(user: user)
            } else {
                self.createSimpleAlert(
                    title: "EMAIL",
                    message: "Please verify email format.",
                    buttonText: "Ok"
                )
            }
        } else {
            mandatoryField(fielName: "user")
        }
    }
    
    /// Check if the password and confirm password fields are not empty or null and validate the same input.
    /// - Parameter user: Need user for consume Login API service
    private func checkPasswordsFiels(user: String) {
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        
        if let password, !password.isEmpty {
            if let confirmPassword, !confirmPassword.isEmpty {
                if (confirmPassword == password) {
                    if(checkNameFiends()) {
                        serviceLogin(user: user, password: password)
                    } else {
                        mandatoryField(fielName: "first name and last name")
                    }
                } else {
                    self.createSimpleAlert(
                        title: "The passwords are not the same",
                        message: "Please verify the entered passwords.",
                        buttonText: "Ok"
                    )
                }
            } else {
                mandatoryField(fielName: "confirm password")
            }
        } else {
            mandatoryField(fielName: "password")
        }
    }
    
    /// Check if the first name and last name fields are not empty or null.
    private func checkNameFiends() -> Bool {
        let firstNameCheck = firstName.text ?? ""
        let lastNameCheck = lastName.text ?? ""
        
        var isOk = true
        isOk = isOk && !firstNameCheck.isEmpty
        isOk = isOk && !lastNameCheck.isEmpty
        
        return isOk
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
    
    /// Check if the email has the correct format.
    /// - Parameter email: Needs mail for REGex
    private func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // MARK: Consume API rest
    // Consuming the relevant service and updating the UI with a notice regarding the query result. Adding thread change up to this point to accommodate potential future tasks such as storing or processing data from an API response; it's advisable to use DispatchQueue.main.sync up to this point.
    private func serviceLogin(user: String, password: String) {
        APILogin().getServiceLogin(email: user, password: password) { result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let isOk): self.successResponse(isOk)
                case .failure(let error): self.errorResponse(error)
                }
            }
        }
    }
    
    private func successResponse(_ isOk: Bool) {
        if(isOk) {
            self.createSimpleAlert(
                title: "Success",
                message: "Registered user!",
                buttonText: "Ok"
            )
        }
    }
    
    private func errorResponse(_ error: APIError) {
        self.createSimpleAlert(
            title: "Error Response",
            message: "Description: \(error.localizedDescription)",
            buttonText: "Ok"
        )
    }
}
