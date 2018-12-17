//
//  KeepModel.swift
//  KeepView
//
//  Created by maple on 2018/12/17.
//  Copyright © 2018年 Xuyongkang. All rights reserved.
//

import UIKit

class KeepModel {

    var beginTime: Int64                   //开始时间
    
    var endTime : Int64                    //开始时间
    
    var medalTotalCount : Int              //评价数
    
    var time : String                      //时间戳
    
    var emptyTime : Int64 = 0              //壳子时间戳
    
    
    init(info:[String:Any]) {
        
        beginTime = info["beginTime"] as? Int64 ?? Int64(0)
        
        endTime = info["endTime"] as? Int64 ?? Int64(0)
        
        time = info["time"] as? String ?? ""
        
        medalTotalCount = info["medalTotalCount"] as? Int ?? Int(0)
        
        
    }
    
    
}
