//
//  PageTitleView.swift
//  DYZB
//
//  Created by 杨琦 on 2016/10/13.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

private let KScrollLineH : CGFloat = 2
private let KNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let KSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {


    var currentIndex : Int = 0
    var titles : [String] = []
    weak var delegate : PageTitleViewDelegate?
    
    lazy var titleLabels : [UILabel] = [UILabel]()
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollLine : UIView = {
    
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView {

    func setupUI() {
    
        addSubview(scrollView)
        scrollView.frame = bounds
        
        
        
    }
    
    func setupTitleLabels() {
    
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - KScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.0)
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action:#selector(titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
        
        func setupBottomLineAndScrollLine() {
        
            let bottomLine = UIView()
            bottomLine.backgroundColor = UIColor.lightGray
            let lineH : CGFloat = 0.5
            bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
            addSubview(bottomLine)
            
            
        }
    }
}

extension PageTitleView {
 
    @objc func titleLabelClick(tapGes : UITapGestureRecognizer) {
    
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
        
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}




