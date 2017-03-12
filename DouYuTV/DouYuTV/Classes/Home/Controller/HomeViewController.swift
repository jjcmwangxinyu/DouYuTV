//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by 王新宇 on 2017/3/12.
//  Copyright © 2017年 王新宇. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
}

extension HomeViewController {
   fileprivate func setUpUI(){
        navigationItem.title = "首页"
        setNavigationBar()
    }
    fileprivate func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")//设置左侧按钮
        let size = CGSize(width: 40, height: 40)//设置右侧按钮
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}
