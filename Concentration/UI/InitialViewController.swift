//
//  InitialViewController
//  Concentration
//
//  Created by User on 07.03.2018.
//  Copyright © 2018 SMS inc. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var viewToRound: UIView!
    @IBOutlet var textFieldsCollection: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()

        viewToRound.layer.cornerRadius = view.bounds.width * 0.33
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowGame" {
            let controller = (segue.destination as! UINavigationController).topViewController as! SplitDetailViewController
            
            let numbersValues = numbers()
            controller.setupNumbers(total: numbersValues.total, perPage: numbersValues.perPage)
        }
    }
    
    private func numbers() -> (total: Int,perPage: Int) {
        var total = kDefaultCellsToShowValue
        var perPage = kDefaultCellsPerPageValue
        for field in textFieldsCollection {
            if field.tag == 0,field.text!.count > 0 {
                total = Int(field.text!)!
                if total > Int.max {
                    total = Int.max
                }
            } else if field.tag == 1,field.text!.count > 0 {
                perPage = Int(field.text!)!
                if perPage > 1_000_000 {
                    perPage = 1_000_000
                }
            }
        }
        
        return (total,perPage)
    }
}

extension InitialViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let count = textField.text?.count, count > 8 {
            return false
        }
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

//(Should take ~1hour to complete)
//
//Interactive prototype
//https://xd.adobe.com/view/cce3301c-dfa4-4a5b-83ef-8c71fb5f0672/
//
//The exercise is based on a popular mental math game. Children usually sit around a table, first player says "1", and each next player counts up. The numbers which are divisible by either 3 or 5 are replaced with the corresponding word, in our case "Bip" and "Bop". If the number is divisible by both numbers, it becomes "Bip Bop". If a player makes a mistake, or takes too long, they are eliminated from the game.
//This app generates a correct game sequence for selected numbers.
//
//The task:
//- Create a simple iOS app with 3 screens, using the provided design
//- You can use either ObjC or Swift
//- The app should list at least first 1000 results for the game sequence
//    - "Play BipBop" and "Explanation" should be child controllers of a container

