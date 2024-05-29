//
//  SignupViewController.swift
//  Nertflix
//
//  Created by Lily Tran on 21/5/24.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var pass: UITextField!
    
    @IBOutlet weak var pass2: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        username.attributedPlaceholder = NSAttributedString(
            string: "Email or phone number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        pass.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        pass2.attributedPlaceholder = NSAttributedString(
            string: "Enter password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        setupBackButton()
        // Do any additional setup after loading the view.
    }

    @IBAction func signup(_ sender: Any) {
        
        if let username = username.text{
            if UserDefaults.standard.string(forKey: username) != nil{
                return
            }
            if let pass = pass.text, let pass2 = pass2.text {
                if pass.isEqual(pass2){
                    UserDefaults.standard.setValue(pass, forKey: username)
                    self.navigationController?.popViewController(animated: true)

                }
            }
        }
        else{
            
        }
    }
    
    private func setupBackButton() {
            let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
            navigationItem.leftBarButtonItem = backButton
        }
        
        @objc private func backButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
}
