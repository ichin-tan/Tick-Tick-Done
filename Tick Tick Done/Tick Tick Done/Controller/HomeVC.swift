//
//  HomeVC.swift
//  Tick Tick Done
//
//  Created by CP on 24/12/24.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    //MARK: - Outlets & Variables -
    
    @IBOutlet weak var lblTitle: UILabel!
    
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
