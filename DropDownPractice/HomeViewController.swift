//
//  HomeViewController.swift
//  DropDownPractice
//
//  Created by Simon Tekeste on 10/3/19.
//  Copyright © 2019 Simon Tekeste. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    var roundtrip: Bool = true
    
    var check: Bool = false
    
    @IBOutlet weak var departingCity: UITextField!
    @IBOutlet weak var arrivingCity: UITextField!
    
    let newTest : [String] = ["String", "Checking", "Money", "Savings", "game", "party", "top", "shot","!","String", "Checking", "Money", "Savings", "game", "party", "top", "shot","!"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableVIew.delegate = self
        tableVIew.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        departingCity.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        arrivingCity.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tableVIew.tableFooterView = UIView()
    }
    
    @objc func textFieldDidChange(_ textfield:UITextField) {
        
        assigningDelegate(textfield: textfield)
        
        if textfield.text!.count > 0 {
            check = true
            tableVIew.reloadData()
        }else {
            check = false
            tableVIew.reloadData()
        }
        
    }
    
    func assigningDelegate( textfield: UITextField) {
     
        if textfield.tag == 0 {
            departingCity.delegate = self
        }else {
            departingCity.delegate = nil
        }
        
        if textfield.tag == 1 {
            arrivingCity.delegate = self
        }else {
            arrivingCity.delegate = nil
        }
        
    }
    
    
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if roundtrip {
            return 4
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && check { return newTest.count }
        if section == 0 && !check { return 0 }
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
//        cell.backgroundColor  = .red
        
        if indexPath.section == 0  {
            cell.textLabel?.text = newTest[indexPath.row]
        }
        
        if !check {
            
            if indexPath.section == 1 {
                cell = tableVIew.dequeueReusableCell(withIdentifier: "segmentedCell", for: indexPath )
                
            }
            
            if indexPath.section == 2 {
                cell = tableVIew.dequeueReusableCell(withIdentifier: "departing", for: indexPath )
            }
            
            if indexPath.section == 3 {
                cell = tableVIew.dequeueReusableCell(withIdentifier: "returning", for: indexPath )
            }
            
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("nasty\(indexPath.row)")
        
        if departingCity.delegate != nil {
            departingCity.text = newTest[indexPath.row]
        }
        
        if arrivingCity.delegate != nil {
            arrivingCity.text = newTest[indexPath.row]
        }
  
    }
    
}
