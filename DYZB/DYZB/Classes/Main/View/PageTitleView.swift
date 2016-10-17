//
//  PageTitleView.swift
//  DYZB
//
//  Created by 杨琦 on 2016/10/13.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

//定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

//定义常量
private let KScrollLineH : CGFloat = 2
private let KNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let KSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
private let KTitleMargin : CGFloat = 0

//定义PageTitleView类
class PageTitleView: UIView {

    //定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    fileprivate var isScrollEnable : Bool
    weak var delegate : PageTitleViewDelegate?
    
    //懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //自定义构造函数
    init(frame: CGRect, isScrollEnable : Bool, titles : [String]) {
        self.isScrollEnable = isScrollEnable
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 设置UI界面
extension PageTitleView {

    fileprivate func setupUI() {
        //添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加title对应的Labels
        setupTitleLabels()
        
        //设置底线和滚动滑块
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels() {
    
        //确定label的一些frame值
        let labelH : CGFloat = frame.height - KScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //创建UILabel
            let label = UILabel()
            //设置Label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.0)
            label.textAlignment = .center
            
            //设置Label的frame
            var labelW : CGFloat = 0
            var labelX : CGFloat = 0
            
            if !isScrollEnable {
                labelW = frame.width / CGFloat(titles.count)
                labelX = labelW * CGFloat(index)
            } else {
                let size = (title as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: label.font], context: nil)
                labelW = size.width
                if index != 0 {
                    labelX = titleLabels[index - 1].frame.maxX + KTitleMargin // _Swift_3.0_
                }
            }
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //将Label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action:#selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    //添加底线
    fileprivate func setupBottomLineAndScrollLine() {

        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2)
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - KScrollLineH, width: firstLabel.frame.width, height: KScrollLineH)
    }
}

// 监听Label的点击
extension PageTitleView {
 
    @objc fileprivate func titleLabelClick(tapGes : UITapGestureRecognizer) {
    
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        if currentLabel.tag == currentIndex { return }
        
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor(r: KSelectColor.0, g: KSelectColor.1, b:KSelectColor.2)
        oldLabel.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//对外暴露的方法
extension PageTitleView {

    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //颜色渐变，取出变化的范围
        let colorDelta = (KSelectColor.0 - KNormalColor.0, KSelectColor.1 - KNormalColor.1, KSelectColor.2 - KNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: KSelectColor.0 - colorDelta.0 * progress, g: KSelectColor.1 - colorDelta.1 * progress, b: KSelectColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: KNormalColor.0 + colorDelta.0 * progress, g: KNormalColor.1 + colorDelta.1 * progress, b: KNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex
    }
}


