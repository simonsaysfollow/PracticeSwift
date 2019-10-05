//
//  ViewController.swift
//  DropDownPractice
//
//  Created by Simon Tekeste on 9/18/19.
//  Copyright © 2019 Simon Tekeste. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    var charlength: Int?  
    var count:Int = 5
    var check:Bool = false
    var whichTextField:Int!
    var length: Int?
    let test: [String] = ["Hello","World","I", "WIll", "Get", "this", "to", "work", "!"]
    
    
    var departing: departingText!
    var returning: returningText!
    
    
    @IBOutlet weak var passangerTable: UITableView!
    
     @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
            self.count = 4
           
            passangerTable.reloadData()
            print(sender.selectedSegmentIndex)
            
        }else {
            
            self.count = 5
            passangerTable.reloadData()
        }
    
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        whichTextField = textField.tag
        
        
   
        if let charlength = charlength {
            
            if (passangerTable.cellForRow(at: IndexPath.init(row: 1, section: textField.tag)) != nil) {
                print("checking on you")
                passangerTable.beginUpdates()
                
                for item in 1...test.count {
                    
                    passangerTable.deleteRows(at: [NSIndexPath(row: item, section: textField.tag) as IndexPath], with: .automatic)
                }
                
                passangerTable.endUpdates()
                
            }
            
            
            if charlength > textField.text!.count {
               
                passangerTable.beginUpdates()
                
                for item in 1...test.count {
                
                passangerTable.deleteRows(at: [NSIndexPath(row: item, section: textField.tag) as IndexPath], with: .automatic)
                }
                
                passangerTable.endUpdates()
            }
        
            if textField.text!.count > 0 {
                check = true
                
                passangerTable.beginUpdates()
                
                for item in 1...test.count {

                    passangerTable.insertRows(at: [NSIndexPath(row: item, section: textField.tag) as IndexPath], with: .automatic)
                   
                }
                
                passangerTable.endUpdates()
                
            }
            
            if textField.text!.count == 0 {
                
                check = false
                passangerTable.reloadData()
                
            }
        
        }
        
       charlength = textField.text!.count
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
        passangerTable.delegate = self
        passangerTable.dataSource = self
        passangerTable.bounces = false
        configureTableView()
        
    }
    

}


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if check {
            if section == 0 && whichTextField == 0 {
                return test.count + 1
            }
            
            if section == 1 && whichTextField == 1 {
                return test.count + 1
            }
        }
        
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell()
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                self.departing = passangerTable.dequeueReusableCell(withIdentifier: "departingText", for: indexPath ) as? departingText
                self.departing.departingField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                departing.selectionStyle = .none
                return departing
            }else{
//                let departing  = passangerTable.dequeueReusableCell(withIdentifier: "departingText", for: indexPath )
                if whichTextField == 0 {
                    cell.textLabel?.text = test[indexPath.row-1]
                    return cell
                }
            }
            
        }
        
        if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                self.returning = passangerTable.dequeueReusableCell(withIdentifier: "returningText", for: indexPath )as? returningText
                self.returning.returningField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                returning.selectionStyle = .none
                return returning
            }else {
                if whichTextField == 1 {
                    cell.textLabel?.text = test[indexPath.row-1]
                    return cell
                }
            }
            
        }
        
        if indexPath.section == 2 {
            
            let segmented  = passangerTable.dequeueReusableCell(withIdentifier: "segmentedCell", for: indexPath )
            segmented.selectionStyle = .none
            return segmented
        }
        
        if indexPath.section == 3  {
            
           let departingBtn = passangerTable.dequeueReusableCell(withIdentifier: "departingCell", for: indexPath ) as! departingCells
            departingBtn.selectionStyle = .none
            return departingBtn
        }
        
        if indexPath.section == 4 {
          let returningBtn = passangerTable.dequeueReusableCell(withIdentifier: "returningCell", for: indexPath ) as! returningCells
            returningBtn.selectionStyle = .none
            return returningBtn
          
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 1 {return 60}
        if indexPath.section ==  2 {return 80}
        if indexPath.section == 3 || indexPath.section == 4 {return 90}
       return 30
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        return 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .white
        return footerView
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if check {
                self.departing.departingField.text = test[indexPath.row-1]
                check = false
                passangerTable.reloadData()
            }
            
        }
        if indexPath.section == 1 {
            if check {
                self.returning.returningField.text = test[indexPath.row-1]
                check = false
                passangerTable.reloadData()
            }
        }
        
    }
    
    func configureTableView() {
        passangerTable.rowHeight = UITableView.automaticDimension
        passangerTable.estimatedRowHeight = 120
    }
    

    
}

