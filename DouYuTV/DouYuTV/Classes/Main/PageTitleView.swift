//
//  PageTitleView.swift
//  DouYuTV
//
//  Created by 王新宇 on 2017/3/12.
//  Copyright © 2017年 王新宇. All rights reserved.
//

import UIKit
private let kScrollLineH : CGFloat = 2
class PageTitleView: UIView {
    fileprivate var titles :[String]
    //定义懒加载属性
    fileprivate lazy var titleLabels :[UILabel] = [UILabel]()
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置UI
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate lazy var scroll:UIScrollView = {
       let scroll = UIScrollView()
        scroll.isPagingEnabled = false
        scroll.bounces = false
        scroll.showsHorizontalScrollIndicator  = false
        scroll.scrollsToTop = false
        return scroll
    }()
    fileprivate lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
}

extension PageTitleView {
    fileprivate func setUpUI()  {
        //添加scrolview
        self.addSubview(scroll)
        scroll.frame = bounds
        //添加label
        setTitleLabels()
        //设置底线
        setBottomLine()
    }
    
    fileprivate func setBottomLine() {
        //设置底线
        let bottomeLine = UIView()
         bottomeLine.backgroundColor = UIColor.lightGray
        let bottomH :CGFloat = 0.5
        bottomeLine.frame = CGRect(x: 0, y: frame.height-bottomH, width: frame.width, height: bottomH)
        addSubview(bottomeLine)
       
        //
        guard let firstLabel = titleLabels.first else{return}
        firstLabel.textColor = UIColor.orange
        scroll.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
    }
    
    fileprivate func setTitleLabels() {
        //设置label frame
        let labelw :CGFloat = frame.width/CGFloat(titles.count)
        let labelh :CGFloat = frame.size.height-kScrollLineH
        let labely :CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()//创建label
            //设置label属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 17)
            label.textColor = UIColor.lightGray
            label.textAlignment = .center
            
            let labelx :CGFloat = labelw * CGFloat(index)
            label.frame = CGRect(x: labelx, y: labely, width: labelw, height: labelh)
            scroll.addSubview(label)
            titleLabels.append(label)
        }
    }
}
