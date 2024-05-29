//
//  LoginViewModel.swift
//  Nertflix
//
//  Created by Lily Tran on 29/05/2024.
//

import Foundation
import UIKit

class UserViewModel {
    
    let userDefault = UserDefaults.standard
    
    func validInputInfo(username: String?, password: String?) -> Bool {
        guard let username = username, let password = password else { return false }
        if username.isEmpty || username.count < 6 {
            return false
        }
        if password.isEmpty || password.count < 6 {
            return false
        }
        return true
    }
    
    func getUserInfo(for username: String) -> User? {
        let password = userDefault.string(forKey: username)
        if let password = password {
            return User(username: username, password: password)
        }
        return nil
    }
    
    func checkLogin(with username: String, password: String) -> Bool {
        let userInfo = self.getUserInfo(for: username)
        guard let userInfo = userInfo else { return false }
        return userInfo.password == password
    }
    
    func saveUserInfo(username: String?, password: String?, repassword: String?) -> (Bool, Error?) {
        guard let username = username,
                let password = password,
                let repassword = repassword else {
            let error = NSError(domain: "com.nertflix.giang", code: 402, userInfo: [NSLocalizedDescriptionKey: "Thông tin đăng nhập null"])
            return (false, error)
        }
        
        if userDefault.string(forKey: username) != nil {
            let error = NSError(domain: "com.nertflix.giang", code: 400, userInfo: [NSLocalizedDescriptionKey: "Tài khoản đã tồn tại"])
            return (false, error)
        }
        if password != repassword {
            let error = NSError(domain: "com.nertflix.giang", code: 401, userInfo: [NSLocalizedDescriptionKey: "Mật khẩu không trùng khớp"])
            return (false, error)
        }
        userDefault.setValue(password, forKey: username)
        return (true, nil)
    }
    
}
