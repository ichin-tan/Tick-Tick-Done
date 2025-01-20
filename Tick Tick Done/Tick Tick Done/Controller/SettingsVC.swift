//
//  SettingsVC.swift
//  Tick Tick Done
//
//  Created by CP on 24/12/24.
//

import Foundation
import UIKit

class SettingsVC: UIViewController {
    
    //MARK: - Outlets & Variables -
        
    @IBOutlet weak var tblSettings: UITableView!
    
    var arrSettings : [String] = ["Logout", "Set 1", "Set 2"]
    
    //MARK: - Life cycle methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyle()
        self.setUp()
    }

    //MARK: - Custom methods -
    
    func setUp() {
        self.setNavigationBar(title: "Settings",backgroundColor: .clear)
        self.tblSettings.delegate = self
        self.tblSettings.dataSource = self
    }
    
    func applyStyle() {
        GlobalFunctions.setMainBackground(for: self.view)
    }
}

//MARK: - UITableview delegate & datasource -

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        let setting = self.arrSettings[indexPath.row]
        cell.lblSetting.text = setting
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = self.arrSettings[indexPath.row]
        switch(setting) {
        case "Logout":
            print("Code to logout")
        default:
            print("Setting not found!")
        }
    }
}
