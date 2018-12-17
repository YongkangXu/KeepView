//
//  ViewController.swift
//  KeepView
//
//  Created by maple on 2018/12/17.
//  Copyright © 2018年 Xuyongkang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /**
     基本数据模型
     */
    var keepModels:[KeepModel] = []
    
    /**
     下标
     */
    var currentIndex:Int = 0
    
    fileprivate lazy var keepView:ClassVideoHeaderView = {
        
        let view1 = ClassVideoHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300))
        
        return view1
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: UInt64(1))) {
            self.initData()
            
        }
        
    }


    fileprivate func  initViews() {
        
        self.view.addSubview(self.keepView)
        
        self.keepView.center = self.view.center
        
        self.keepView.indexBlock = {[weak self] index in
             self?.currentIndex = index
        }
        
    }
    
    
    fileprivate func initData() {

        let dayLong = 24 * 60 * 60
  
        let startTime = Int64(XuyongkangDate.getZeroWithDate(Date()))
        let endTime = Int64(self.stringToTimeStamp(stringTime: "2018年09月05日"))
        let daySpace = startTime - endTime!
        let daycount = Int(daySpace / Int64(dayLong))
        
        for i in 0..<daycount+2 {
            let detail = KeepModel.init(info: [:])
            
            detail.medalTotalCount = Int(arc4random_uniform(UInt32(100)))
            
            let gregorian = Calendar(identifier: .gregorian)
            if let titledate = gregorian.date(byAdding: .day, value: -i, to: Date.init(timeIntervalSince1970: XuyongkangDate.getZeroWithDate(Date()))) {
                
                detail.beginTime = Int64(titledate.timeIntervalSince1970)
            }
  
            self.keepModels.insert(detail, at: 0)
            
        }
        
        
        self.currentIndex = self.keepModels.count-1
        
        //赋值
        self.keepView.setcontentWith(self.keepModels, selectIndex: self.currentIndex, isMore: false)
        
    }
    
}

extension ViewController {
    
    fileprivate func stringToTimeStamp(stringTime:String) -> String {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        let date = dfmatter.date(from: stringTime)
        
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        print(dateSt)
        return String(dateSt)
        
    }
    
}

