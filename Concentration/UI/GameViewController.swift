//
//  GameViewController.swift
//  Concentration
//
//  Created by User on 07.03.2018.
//  Copyright © 2018 SMS inc. All rights reserved.
//

import UIKit

final class GameViewController: UIViewController {
    
    @IBOutlet private weak var bipTextField: UITextField! {
        didSet{ bipTextField.text = "\(kDefaultBipValue)" }
    }
    private var bipValue: Int {
        get { return Int(bipTextField.text!)! }
    }
    @IBOutlet private weak var bopTextField: UITextField! {
        didSet{ bopTextField.text = "\(kDefaultBopValue)" }
    }
    private var bopValue: Int {
        get { return Int(bopTextField.text!)! }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var numberOfItemsTotal = 1_00//0_000
    var numberOfItemsOnPage = 20//0_000
    
    private var brain: Brain?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain = Brain(initWithRequiredNumber: numberOfItemsTotal, andDelegate: self,cellsPerPage: numberOfItemsOnPage)
        tableView.dataSource = brain
        tableView.delegate = self
        
        hideKeyboardOnTap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        updateNumbers(total: numberOfItemsTotal / 2, perPage: numberOfItemsOnPage / 2)
        
        if let brain = brain, brain.updateBecauseMemoryWarning(total: numberOfItemsTotal, perPage: numberOfItemsOnPage) == true {
            tableView.reloadData()
        }
    }
    
    //MARK: - Actions
    func updateNumbers(total: Int, perPage: Int) {
        numberOfItemsTotal = total
        if perPage > 50 {
            numberOfItemsOnPage = perPage
        }
    }
    
    @IBAction private func textFieldValueChanged(_ sender: UITextField) {
        brain?.updateItemsWith(bip: bipValue, bop: bopValue)
        if let visibleCells = tableView.indexPathsForVisibleRows {
            tableView.reloadRows(at: visibleCells, with: .automatic)
        } else {
            tableView.reloadData()
        }
    }
}

//MARK: - TableVeiw Datasource, Textfield delegate, ScrollView Delegate
extension GameViewController : BrainDelegate, UITableViewDelegate, UITextFieldDelegate {
    func brainDidFinishLaunching() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            if let shouldReload = brain?.increaceCellsToShowCount(), shouldReload == true {
                tableView.reloadData()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string != "" { textField.text = string }
        return false
    }
}

//MARK: - Storyboard protocol
extension GameViewController: StoryboardInstantiatable {
    static var storyboardIdentifier = "GameViewController"
    static var StoryboardName = "Main"
}
