//
//  Extensions.swift
//  Concentration
//
//  Created by User on 07.03.2018.
//  Copyright © 2018 SMS inc. All rights reserved.
//

import UIKit

protocol StoryboardInstantiatable {
    static var StoryboardName: String { get }
    static var storyboardIdentifier: String { get }
}

extension StoryboardInstantiatable {
    
    static var StoryboardName: String { return String(describing: Self.self) }
    static var storyboardIdentifier: String { return String(describing: Self.self) }
    
    static func instantiate() -> Self {
        return instantiateWithName(name: StoryboardName)
    }
    
    static func instantiateWithName(name: String) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else{
            fatalError("failed to load \(name) storyboard file.")
        }
        return vc
    }
}

extension UIViewController {
    func add(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.view.frame = view.bounds
        child.view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        child.didMove(toParentViewController: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
    
    
    func hideKeyboardOnTap() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tap() {
        view.endEditing(true)
    }
    
    
}
