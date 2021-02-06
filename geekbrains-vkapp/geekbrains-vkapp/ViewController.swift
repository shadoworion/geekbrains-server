//
//  ViewController.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 05/02/2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    private let username = "test"
    private let password = "test"

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var bottomStackViewConstrait: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        usernameField.tag = 0
        passwordField.delegate = self
        passwordField.tag = 1
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)

        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    @objc func keyboardWillAppear(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, animations: {
                self.bottomStackViewConstrait.constant = keyboardSize.height
                self.view.layoutIfNeeded()
            })
        }
    }

    @objc func keyboardWillDisappear(notification: NSNotification) {
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomStackViewConstrait.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            signInButton.sendActions(for: .touchUpInside)
            return true;
        }
        return false;
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "login"){
            if signIn() {
                return true
            } else {
                let alert = UIAlertController(title: "Error", message: "Wrong email or password", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: {_ in
                    self.usernameField.text = nil
                    self.passwordField.text = nil
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
        return true
    }
    
    func signIn() -> Bool {
        return usernameField.text == username && passwordField.text == password
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if let regUrl = URL(string: "https://vk.com/join") {
            UIApplication.shared.open(regUrl)
        }
    }
}

