//
//  AddTaskVC.swift
//  Tick Tick Done
//
//  Created by CP on 25/12/24.
//

import Foundation
import UIKit

class AddTaskVC: UIViewController {
    
    //MARK: - Outlets & Variables -
    
    //MARK: - Life cycle methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyle()
        self.setUp()
    }
    
    //MARK: - Custom methods -
    
    func setUp() {
        
    }
    
    func applyStyle() {
        GlobalFunctions.setMainBackground(for: self.view)
    }
    
    //MARK: - Action methods -
}
