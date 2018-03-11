//
//  Brain.swift
//  Concentration
//
//  Created by User on 10.03.2018.
//  Copyright © 2018 SMS inc. All rights reserved.
//

import Foundation
import UIKit

protocol BrainDelegate: AnyObject {
    func brainDidFinishLaunching()
}

class Brain: NSObject {

    private var items = [Int]()
    private var count: Int
    private var bip = kDefaultBipValue
    private var bop = kDefaultBopValue
    private var initialCellsCountToShow: Int
    private var cellsToShowCount: Int
    
    weak var delegate: BrainDelegate?
    
    init(initWithRequiredNumber totalTumber: Int,andDelegate aDelegate: BrainDelegate,cellsPerPage numberPerPage: Int) {
        assert(totalTumber > numberPerPage, "Number of cells per page muse be bigger than number of total cells")
        items.reserveCapacity(totalTumber)
        delegate = aDelegate
        count = totalTumber
        initialCellsCountToShow = numberPerPage
        cellsToShowCount = numberPerPage
        
        for i in 0..<count {
            items.append(i)
        }
        
        super.init()
        aDelegate.brainDidFinishLaunching()
    }
    
    convenience init(initWithRequiredNumber number: Int,andDelegate aDelegate: BrainDelegate) {
        self.init(initWithRequiredNumber: number, andDelegate: aDelegate,cellsPerPage: kDefaultCellsToShowValue)
    }
    
    func updateItemsWith(bip bipValue: Int, bop bopValue: Int) {
        bip = bipValue
        bop = bopValue
    }
    
    func updateBecauseMemoryWarning(total: Int, perPage: Int) -> Bool {
        count = total
        initialCellsCountToShow = perPage
        cellsToShowCount = perPage
        items.removeAll(keepingCapacity: false)
        for i in 0..<count {
            items.append(i)
        }
        return true
    }
    
    func increaceCellsToShowCount() -> Bool {
        if cellsToShowCount + initialCellsCountToShow <= count {
            cellsToShowCount += initialCellsCountToShow
            return true
        }
        return false
    }
}

extension Brain: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsToShowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: kCellStandartIdentifier) {
            setup(cell: cell,withNumber: indexPath.row + 1)
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: kCellStandartIdentifier)
            return cell
        }
    }

    func setup(cell: UITableViewCell,withNumber number: Int) {
        var cellText = ""
        if number % bip == 0 { cellText += "Bip" }
        if number % bop == 0 { cellText += "Bop" }
        cell.textLabel?.text = (cellText.count > 0) ? cellText : "\(number)"
    }
    
}


