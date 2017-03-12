//
//  UIBarButtonItemExtension.swift
//  DouYuTV
//
//  Created by 王新宇 on 2017/3/12.
//  Copyright © 2017年 王新宇. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
//    class func createItem(imageName:String,highImageName:String, size:CGSize) -> UIBarButtonItem {
//        let btn = UIButton()
//        btn.setImage(UIImage(named:imageName), for: UIControlState.normal)
//        btn.setImage(UIImage(named:highImageName), for: UIControlState.highlighted)
//        btn.frame.size = size
//        return UIBarButtonItem(customView: btn)
//    }
    convenience init(imageName:String,highImageName:String = "",size:CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: UIControlState.normal)
        if highImageName != "" {
            btn.setImage(UIImage(named:highImageName), for: UIControlState.highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView:btn)
    }
}
