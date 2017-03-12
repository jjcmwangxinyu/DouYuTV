//
//  PageTitleView.swift
//  DouYuTV
//
//  Created by 王新宇 on 2017/3/12.
//  Copyright © 2017年 王新宇. All rights reserved.
//

import UIKit
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
protocol PageTitleViewDelegate :class{
    func returnValue(_ titleView:PageTitleView ,selectIndex index:Int)
}
class PageTitleView: UIView {
    weak var delegate:PageTitleViewDelegate?
    fileprivate var titles :[String]
    //定义懒加载属性
    fileprivate lazy var titleLabels :[UILabel] = [UILabel]()
    fileprivate var currentIndex:Int = 0
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
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            let labelx :CGFloat = labelw * CGFloat(index)
            label.frame = CGRect(x: labelx, y: labely, width: labelw, height: labelh)
            scroll.addSubview(label)
            titleLabels.append(label)
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.tapClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
}

extension PageTitleView {
    func setPageOffset(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        //取出 source target 对应的label
        let source = titleLabels[sourceIndex]
        let target = titleLabels[targetIndex]
        //处理滑块逻辑
        let moveTotal = target.frame.origin.x - source.frame.origin.x
        let moveX = moveTotal*progress
        scrollLine.frame.origin.x = source.frame.origin.x+moveX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2.变化sourceLabel
        source.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        target.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        currentIndex = targetIndex;
    }
}

extension PageTitleView {
    @objc fileprivate func tapClick(_ tap:UITapGestureRecognizer) {
        guard  let currentLabel = tap.view as? UILabel else {return}
        let oldLabel = titleLabels[currentIndex]
        currentIndex = currentLabel.tag
        if currentLabel.tag == oldLabel.tag {
            return
        }
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        delegate?.returnValue(self, selectIndex: currentLabel.tag)
        
        // 5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
    }
}
