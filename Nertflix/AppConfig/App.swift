//
//  App.swift
//  Nertflix
//
//  Created by Lily Tran on 21/5/24.
//

import Foundation
import UIKit

final class App: NSObject {
    
    static let shared: App = App()
    
    let app = UIApplication.shared
    
    public var isLogin: Bool {
        return false
    }
}

// MARK: - Window
extension App {
    
    enum RootType {
        case login
        case main
    }
    
    public var window: UIWindow? {
        return UIApplication.shared._keyWindow
    }
    
    private(set) var root: UIViewController? {
        set {
            window?.rootViewController = newValue
        }
        get {
            return window?.rootViewController
        }
    }
    
    public func setRoot(_ viewController: UIViewController, animated: Bool = false, completion: (() -> Void)? = nil) {
        guard let window = self.window else { return }
        if animated {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                self.root = viewController
                UIView.setAnimationsEnabled(oldState)
                window.makeKeyAndVisible()
            }, completion: { (_) in
                completion?()
            })
        } else {
            root = viewController
            window.makeKeyAndVisible()
            completion?()
        }
    }
    
    public func switchRoot(type: RootType, animated: Bool = false, completion: (() -> Void)? = nil) {
        let vc = viewController(type: type)
        setRoot(vc, animated: animated, completion: completion)
    }
}

private extension App {
    func viewController(type: RootType) -> UIViewController {
        switch type {
        case .login:
            let nav = UINavigationController(rootViewController: LoginViewController())
            nav.setNavigationBarHidden(false, animated: false)
            return nav
        case .main:
            let navTabController = MainTabBarViewController()
            let nav = UINavigationController(rootViewController: navTabController)
            nav.setNavigationBarHidden(true, animated: false)
            return nav
        }
    }
}

extension UIApplication {
    var _keyWindow: UIWindow? {
        var sceneWindows: [UIWindow]?
        
        if #available(iOS 13.0, *) {
            sceneWindows = connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first { $0 is UIWindowScene }
                .flatMap { $0 as? UIWindowScene }?.windows
        }
        
        let windows = sceneWindows ?? self.windows
        return windows.first(where: \.isKeyWindow) ?? windows.first
    }
}
