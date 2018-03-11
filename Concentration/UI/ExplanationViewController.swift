//
//  ExplanationViewController.swift
//  Concentration
//
//  Created by User on 07.03.2018.
//  Copyright © 2018 SMS inc. All rights reserved.
//

import UIKit

final class ExplanationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }    
}

extension ExplanationViewController: StoryboardInstantiatable {
    static var storyboardIdentifier = "ExplanationViewController"
    static var StoryboardName = "Main"
}
