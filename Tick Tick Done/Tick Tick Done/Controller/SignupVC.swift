//
//  SignupVC.swift
//  Tick Tick Done
//
//  Created by CP on 30/12/24.
//

import Foundation
import UIKit
import FirebaseAuth

class SignupVC: UIViewController {
    
    //MARK: - Outlets & Variables -
    
    @IBOutlet weak var txtSignupEmail: UITextField!
    @IBOutlet weak var txtSignupPassword: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnEye: UIButton!
    
    //MARK: - Lifecycle methods -

    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyle()
        self.setUp()
    }
        
    //MARK: - Custom methods -
    
    func setUp() {
        self.txtSignupEmail.delegate = self
        self.txtSignupPassword.delegate = self
    }
    
    func applyStyle() {
        self.title = AppMessages.signup
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.addBackButton()
        GlobalFunctions.setMainBackground(for: self.view)
        self.txtSignupEmail.superview?.layer.borderWidth = 2
        self.txtSignupPassword.superview?.layer.borderWidth = 2
        self.txtSignupEmail.superview?.layer.borderColor = UIColor.appGreen.cgColor
        self.txtSignupPassword.superview?.layer.borderColor = UIColor.appGreen.cgColor
        self.txtSignupEmail.superview?.layer.cornerRadius = 15
        self.txtSignupPassword.superview?.layer.cornerRadius = 15
        self.txtSignupEmail.textColor = UIColor.appGreen
        self.txtSignupPassword.textColor = UIColor.appGreen
        self.btnSignup.superview?.layer.cornerRadius = 15
        self.btnSignup.layer.cornerRadius = 15
        self.txtSignupPassword.isSecureTextEntry = true
        self.btnEye.setBackgroundImage(UIImage(systemName: "eye.fill"), for: .normal)
        self.txtSignupEmail.keyboardType = .emailAddress
    }
    
    func addBackButton() {
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        backbutton.tintColor = UIColor.appGreen
        backbutton.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    func isValidated() -> Bool {
        let strEmail = self.txtSignupEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let strPassword = self.txtSignupPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
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
    
    func signup() {
        if(self.isValidated()) {
            let strEmail = self.txtSignupEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let strPassword = self.txtSignupPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            FirebaseManager.shared.signUp(email: strEmail, password: strPassword) {
                self.showAlert(message: AppMessages.userCreated) {
                    let user = User(userID: Auth.auth().currentUser?.uid ?? "", email: strEmail)
                    FirebaseManager.shared.addUser(user: user) {
                        currentUser = user
                        SCENE_DELEGATE.setTabbar()
                    } failure: { errorMessage in
                        self.showAlert(message: errorMessage)
                    }
                }
            } failure: { errorMessage in
                self.showAlert(message: errorMessage)
            }
        }
    }
    
    //MARK: - Action methods -
        
    @IBAction func btnSignupTapped(_ sender: UIButton) {
        self.signup()
    }
    
    @IBAction func btnEyeTapped(_ sender: UIButton) {
        self.txtSignupPassword.isSecureTextEntry.toggle()
        
        let backImg = self.txtSignupPassword.isSecureTextEntry ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        
        self.btnEye.setImage(backImg, for: .normal)
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITextfield delegate -

extension SignupVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == self.txtSignupEmail) {
            self.txtSignupPassword.becomeFirstResponder()
        } else {
            self.txtSignupPassword.resignFirstResponder()
        }
        return true
    }
    
}
