//
//  TabbarVC.swift
//  Tick Tick Done
//
//  Created by CP on 24/12/24.
//

import Foundation
import UIKit

public class TabBarVC: UITabBarController {
    
    private let middleButton = UIButton()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyle()
        self.setupViewControllers()
        self.setupMiddleButton()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let newTabBarHeight = self.tabBar.frame.height + 10.0

        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight

        tabBar.frame = newFrame
    }

    func setupMiddleButton() {
        self.middleButton.frame = CGRect(x: (self.tabBar.bounds.width / 2) - 35,
                                     y: -15,
                                     width: 70,
                                     height: 70)
        self.middleButton.layer.cornerRadius = 35
        self.middleButton.setImage(UIImage(named: "circle"), for: .normal)
        self.middleButton.tintColor = .white
        self.middleButton.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)
        self.middleButton.layer.shadowColor = UIColor.black.cgColor
        self.middleButton.layer.shadowOpacity = 0.7
        self.middleButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.middleButton.layer.shadowRadius = 10
        self.tabBar.addSubview(self.middleButton)
        self.tabBar.bringSubviewToFront(self.middleButton)
    }

    @objc func middleButtonTapped() {
        self.selectedIndex = 2
    }

    
    
    func applyStyle() {
        self.tabBar.tintColor = Utility.shared.getColorFrom(hexString: "#52A356")
        self.tabBar.backgroundColor = UIColor.appGreen
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.layer.cornerRadius = 25
    }

    func setupViewControllers() {
        let homeVC = STORYBOARD.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        homeVC.tabBarItem.image = UIImage(systemName: "house.fill")
        homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        let homeNav = UINavigationController(rootViewController: homeVC)

        let profileVC = STORYBOARD.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        profileVC.tabBarItem.image = UIImage(systemName: "person.fill")
        profileVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        let profileNav = UINavigationController(rootViewController: profileVC)

        let addTaskVC = STORYBOARD.instantiateViewController(withIdentifier: "AddTaskVC") as! AddTaskVC
        addTaskVC.tabBarItem.isEnabled = false
        let addTaskNav = UINavigationController(rootViewController: addTaskVC)

        let historyVC = STORYBOARD.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
        historyVC.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.fill")
        historyVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        let historyNav = UINavigationController(rootViewController: historyVC)

        let settingVC = STORYBOARD.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        settingVC.tabBarItem.image = UIImage(systemName: "gearshape.fill")
        settingVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        let settingNav = UINavigationController(rootViewController: settingVC)

        viewControllers = [homeNav, profileNav, addTaskNav, historyNav, settingNav]
    }
}
