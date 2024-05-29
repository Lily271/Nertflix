//
//  LoginViewController.swift
//  Nertflix
//
//  Created by Lily Tran on 21/5/24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailtxt: UITextField!
    
    @IBOutlet weak var passtxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailtxt.attributedPlaceholder = NSAttributedString(
            string: "Email or phone number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        passtxt.attributedPlaceholder = NSAttributedString(
            string: "Enter password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signup(_ sender: Any) {
        let signup = SignupViewController()
        self.navigationController?.pushViewController(signup, animated: true)
        
    }
    @IBAction func signin(_ sender: Any) {
//        UserDefaults.standard.setValue(passtxt.text, forKey: emailtxt.text)
    var pass : String?
      pass =  UserDefaults.standard.string(forKey: emailtxt?.text ?? "")
        if let pass = pass {
            if(pass.isEqual(passtxt.text)){
//                let mainBar = MainTabBarViewController()
//                self.navigationController? .pushViewController(mainBar, animated: true)
                App.shared.switchRoot(type: .main)
                UserDefaults.standard.setValue(true, forKey: "IsLogin")
            }
        }
        else {
            
        }
    }
    
}
