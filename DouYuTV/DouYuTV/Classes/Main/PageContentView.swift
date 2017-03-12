//
//  PageContentView.swift
//  DouYuTV
//
//  Created by 王新宇 on 2017/3/12.
//  Copyright © 2017年 王新宇. All rights reserved.
//

import UIKit

class PageContentView: UIView {
    fileprivate var childVCS : [UIViewController]
    fileprivate var paratents : UIViewController?
    init(frame: CGRect,childVCS :[UIViewController],paratents:UIViewController) {
        self.childVCS = childVCS
        self.paratents = paratents
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
