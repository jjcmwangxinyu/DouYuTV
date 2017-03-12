//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by 王新宇 on 2017/3/12.
//  Copyright © 2017年 王新宇. All rights reserved.
//

import UIKit

private let kTitleViewH :CGFloat = 40

class HomeViewController: UIViewController {
    //系统会掉函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    fileprivate lazy var pageTitleView:PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame:titleFrame,titles:titles)
       // titleView.backgroundColor = UIColor.orange
        return titleView
    }()
    
    fileprivate lazy var pageContentView:PageContentView = {
        let contentFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH+kTitleViewH, width: kScreenW, height: kScreenH-kStatusBarH-kNavigationBarH-kTitleViewH)
        var childs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor  = UIColor.randomColor()
            childs.append(vc)
        }
        
        let contentView = PageContentView(frame:contentFrame ,childVCS:childs,paratents:self)
        
         return contentView
    }()
}

extension HomeViewController {
   fileprivate func setUpUI(){
        navigationItem.title = "首页"
        setNavigationBar()//设置导航
        self.view.addSubview(pageTitleView)
       self.view.addSubview(pageContentView)
    pageContentView.backgroundColor = UIColor.orange
    automaticallyAdjustsScrollViewInsets = false
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
