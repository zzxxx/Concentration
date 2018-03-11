//
//  DetailViewController.swift
//  Concentration
//
//  Created by User on 07.03.2018.
//  Copyright © 2018 SMS inc. All rights reserved.
//

import UIKit

fileprivate enum CurrentVC {
    case Game
    case Explanation
}

class SplitDetailViewController: UIViewController {
    
    private var gameViewCtontroller = GameViewController.instantiate()
    private var currentViewController = CurrentVC.Game
    
    lazy private var explanationViewCtontroller = {
        return ExplanationViewController.instantiate()
    }()
    
    @IBOutlet weak private var containerView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(gameViewCtontroller)
    }
    
    func setupNumbers(total: Int, perPage: Int) {
        gameViewCtontroller.updateNumbers(total: total,perPage: perPage)
    }
    
    @IBAction private func showPlayingScreen(_ sender: UIButton) {
        if currentViewController == .Explanation {
            currentViewController = .Game
            explanationViewCtontroller.remove()
            add(gameViewCtontroller)
        }
    }
    
    @IBAction private func showExplanationScreen(_ sender: UIButton) {
        if currentViewController == .Game {
            currentViewController = .Explanation
            gameViewCtontroller.remove()
            add(explanationViewCtontroller)
        }
    }
}


