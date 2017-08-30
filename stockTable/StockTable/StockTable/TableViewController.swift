//
//  ViewController.swift
//  StockTable
//
//  Created by Isaac Kim on 8/29/17.
//  Copyright © 2017 Isaac Kim. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [StockList]()

    var otherItems = [StockList]()
    var allItems = [[StockList]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return allItems[section].count
        let addedRow = isEditing ? 1:0
        
        return allItems[section].count + addedRow
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if indexPath.row >= allItems[indexPath.section].count, isEditing{
            cell.textLabel?.text = "Add New Stocks Pick"
            cell.detailTextLabel?.text = nil
        } else {
            let item = allItems[indexPath.section][indexPath.row]
            
            cell.textLabel?.text = item.stockName
            cell.detailTextLabel?.text = String(item.rating)
            
        }
        return cell
    
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Portfolio #\(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
                    allItems[indexPath.section].remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
           } else if editingStyle == .insert {
            let newData = StockList()
            allItems[indexPath.section].append(newData)
            tableView.insertRows(at: [indexPath],with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        let sectionItems = allItems[indexPath.section]
        if indexPath.row >= sectionItems.count {
            return .insert
        } else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath)-> IndexPath? {
        let sectionItems = allItems[indexPath.section]
        if isEditing && indexPath.row < sectionItems.count {
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionItems = allItems[indexPath.section]
        if indexPath.row >= sectionItems.count && isEditing {
            self.tableView(tableView, commit: .insert, forRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let sectionItems = allItems[indexPath.section]
        if indexPath.row >= sectionItems.count && isEditing{
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = allItems[sourceIndexPath.section][sourceIndexPath.row]
        allItems[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        if sourceIndexPath.section == destinationIndexPath.section {
            allItems[sourceIndexPath.section].insert(itemToMove, at: destinationIndexPath.row)
        } else {
            allItems[destinationIndexPath.section].insert(itemToMove, at:destinationIndexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        let sectionItems = allItems[proposedDestinationIndexPath.section]
        if proposedDestinationIndexPath.row >= sectionItems.count {
            return IndexPath(row: sectionItems.count - 1, section: proposedDestinationIndexPath.section)
        }
        return proposedDestinationIndexPath
    }

    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            tableView.beginUpdates()
            
            for (index, sectionItems) in allItems.enumerated(){
                let indexPath = IndexPath(row: sectionItems.count, section: index)
                tableView.insertRows(at: [indexPath], with: .fade)
                
            }
            
            tableView.endUpdates()
            tableView.setEditing(true, animated: true)
        } else{
            tableView.beginUpdates()
            
            for(index, sectionItems) in allItems.enumerated(){
                let indexPath = IndexPath(row: sectionItems.count, section: index)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
            tableView.endUpdates()
            tableView.setEditing(false, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.allowsSelectionDuringEditing = true
        navigationItem.leftBarButtonItem = editButtonItem
        automaticallyAdjustsScrollViewInsets = false
        
        for i in 1...11{
            if i > 10 {
                items.append(StockList())
            } else{
                items.append(StockList())
            }
        }
        
        for i in 1...11{
            if i > 10 {
                otherItems.append(StockList())
            } else{
                otherItems.append(StockList())
            }
        }
        allItems.append(items)
        allItems.append(otherItems)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}


