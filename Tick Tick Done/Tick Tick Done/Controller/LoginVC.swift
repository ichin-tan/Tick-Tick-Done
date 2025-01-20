//
//  LoginVC.swift
//  Tick Tick Done
//
//  Created by CP on 19/12/24.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginVC: UIViewController {
    
    //MARK: - Outlets & Variables -
        
    @IBOutlet weak var txtLoginEmail: UITextField!
    @IBOutlet weak var txtLoginPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    //MARK: - Lifecycle methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyle()
        self.setUp()
    }
    
    //MARK: - Custom methods -
    
    func setUp() {
        self.title = AppMessages.login
        self.txtLoginPassword.delegate = self
        self.txtLoginEmail.delegate = self
    }
    
    func applyStyle() {
        GlobalFunctions.setMainBackground(for: self.view)
        self.txtLoginEmail.superview?.layer.borderWidth = 2
        self.txtLoginPassword.superview?.layer.borderWidth = 2
        self.txtLoginEmail.superview?.layer.borderColor = UIColor.appGreen.cgColor
        self.txtLoginPassword.superview?.layer.borderColor = UIColor.appGreen.cgColor
        self.txtLoginEmail.superview?.layer.cornerRadius = 15
        self.txtLoginPassword.superview?.layer.cornerRadius = 15
        self.txtLoginEmail.textColor = UIColor.appGreen
        self.txtLoginPassword.textColor = UIColor.appGreen
        self.btnLogin.superview?.layer.cornerRadius = 15
        self.btnLogin.layer.cornerRadius = 15
        self.txtLoginPassword.isSecureTextEntry = true
        self.btnEye.setBackgroundImage(UIImage(systemName: "eye.fill"), for: .normal)
        self.txtLoginEmail.keyboardType = .emailAddress
    }
    
    func login() {
        if isValidated() {
            let strEmail = self.txtLoginEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let strPassword = self.txtLoginPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            FirebaseManager.shared.signIn(email: strEmail, password: strPassword) { userId in
                FirebaseManager.shared.getUser(docId: userId) { user in
                    currentUser = user
                    SCENE_DELEGATE.setTabbar()
                }
            } failure: { errorMessage in
                self.showAlert(message: errorMessage)
            }
        }
    }
    
    func isValidated() -> Bool {
        let strEmail = self.txtLoginEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let strPassword = self.txtLoginPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if (strEmail.isEmpty) {
            self.showAlert(message: AppMessages.enterEmail)
            return false
        } else if !(GlobalFunctions.isValidEmail(strEmail)) {
            self.showAlert(message: AppMessages.enterValidEmail)
            return false
        } else if (strPassword.isEmpty) {
            self.showAlert(message: AppMessages.enterPassword)
            return false
        }
        return true
    }
    
    //MARK: - Action methods -
    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        self.login()
    }
    
    @IBAction func btnSignupTapped(_ sender: UIButton) {
        let signupVC = STORYBOARD.instantiateViewController(identifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func btnEyeTapped(_ sender: UIButton) {
        self.txtLoginPassword.isSecureTextEntry.toggle()
        
        let backImg = self.txtLoginPassword.isSecureTextEntry ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        
        self.btnEye.setImage(backImg, for: .normal)
    }
    
    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        self.showAlertWithTextfield(title: AppMessages.forgotPassword, message: AppMessages.enterEmail, actionTitle: AppMessages.send) { email in
            
            // Have to check if email is registered or not
            FirebaseManager.shared.resetPassword(email: email) {
                self.showAlert(message: AppMessages.emailSent + "\n\n" + email)
            } failure: { errorMEssage in
                self.showAlert(message: errorMEssage)
            }
        }
    }
}

//MARK: - UITextfield delegate -

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == self.txtLoginEmail) {
            self.txtLoginPassword.becomeFirstResponder()
        } else {
            self.txtLoginPassword.resignFirstResponder()
        }
        return true
    }
    
}
