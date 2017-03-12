//
//  MainViewController.swift
//  DouYuTV
//
//  Created by 王新宇 on 2017/3/12.
//  Copyright © 2017年 王新宇. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC(storyBoardName: "home")
        addChildVC(storyBoardName: "Live")
        addChildVC(storyBoardName: "Follow")
        addChildVC(storyBoardName: "Profile")
    }

    private func addChildVC(storyBoardName:String) {
        let childVC = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}
