//
//  PageContentView.swift
//  DouYuTV
//
//  Created by 王新宇 on 2017/3/12.
//  Copyright © 2017年 王新宇. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:class {
    func pageContentOffset(pageContent:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

class PageContentView: UIView {
    
    fileprivate var childVCS : [UIViewController]
    fileprivate weak var paratents : UIViewController?
    fileprivate var startOffset:CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate:PageContentViewDelegate?
    init(frame: CGRect,childVCS :[UIViewController],paratents:UIViewController?) {
        self.childVCS = childVCS
        self.paratents = paratents
        super.init(frame:frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate lazy var collectionView:UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "coll")
        return collectionView
    }()
}

extension PageContentView {
    func setScrollOffset(index:Int) {
        // 1.记录需要进制执行代理方法
        isForbidScrollDelegate = true
        // 2.滚动正确的位置
        let offsetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

extension PageContentView {
    fileprivate func setUpUI() {
        for child in childVCS {
            paratents?.addChildViewController(child)
        }
        self.addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}
extension PageContentView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCS.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coll", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let child = childVCS[indexPath.item]
        child.view.frame = cell.contentView.frame
        cell.contentView.addSubview(child.view)
        return cell
    }
}
extension PageContentView:UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffset = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        var progress:CGFloat = 0
        var sourceIndex:Int = 0
        var targetIndex:Int = 0
        
        //判断滑动方向
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.size.width
        if currentOffsetX > startOffset {//左滑
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCS.count {
                targetIndex = childVCS.count - 1
            }
            //完全滑过去
            if currentOffsetX - startOffset == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else {//右滑
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            targetIndex = Int(currentOffsetX/scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCS.count {
                sourceIndex = childVCS.count - 1
            }
//            //完全滑过去
            if currentOffsetX - startOffset == -scrollViewW {
                progress = 1
                sourceIndex = targetIndex
            }
        }
        delegate?.pageContentOffset(pageContent: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}

















