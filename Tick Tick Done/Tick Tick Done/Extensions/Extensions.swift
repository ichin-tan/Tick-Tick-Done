//
//  Extensions.swift
//  Tick Tick Done
//
//  Created by CP on 19/12/24.
//

import Foundation
import UIKit

// MARK: - UIView Extension

extension UIView {
    func setGradientWith(hex1: String = "", hex2: String = "",  locations: [NSNumber] = [0.0, 1.0]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        let color1 = Utility.shared.getColorFrom(hexString: hex1).cgColor
        let color2 = Utility.shared.getColorFrom(hexString: hex2).cgColor

        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = locations
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientWith(color1: UIColor, color2: UIColor, locations: [NSNumber] = [0.0, 1.0]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = locations
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

//MARK: - UIViewController Extension -

extension UIViewController {
    func showAlertWithTwoAction(title: String = "", message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true)
        }
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message: String, completion: (() -> ())? = nil) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true) {
                if let completion = completion {
                    completion()
                }
            }
        }
                    
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithTextfield(title: String, message: String, placeholder: String = "", actionTitle: String, completion: ((String)->())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = placeholder
        }
        
        let okAction = UIAlertAction(title: actionTitle, style: .default) { _ in
            if let textField = alert.textFields?[0] {
                completion?(textField.text ?? "")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)
    }
    
    func setNavigationBar(title: String = "", backgroundColor: UIColor = .systemBackground, titleColor: UIColor = .label, tintColor: UIColor = .systemBlue, titleFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .medium)) {
        
        self.navigationItem.title = title
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: titleColor, .font: titleFont]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        navigationController?.navigationBar.tintColor = tintColor
    }
    
    func setNavigationBarWithBackButton(title: String = "", backgroundColor: UIColor = .systemBackground, titleColor: UIColor = .label, tintColor: UIColor = .systemBlue, titleFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .medium)) {
        
        setNavigationBar(title: title, backgroundColor: backgroundColor, titleColor: titleColor, tintColor: tintColor, titleFont: titleFont)
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}
