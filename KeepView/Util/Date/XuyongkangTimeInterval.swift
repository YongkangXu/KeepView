//
//  XuyongkangTimeInterval.swift 
//
//  Created by Xuyongkang on 16/11/23.
//  Copyright © 2016年 cn.Xuyongkang. All rights reserved.
//

import Foundation

public struct XuyongkangTimeInterval{
 
    private init() { }
    
    public enum Digital{
        
        case hour(String, String, String)
        case minute(String, String)
        case second(String)
    }
    
    public static func string(_ digital : XuyongkangTimeInterval.Digital, timeInterval : TimeInterval) -> String {
        
        guard timeInterval >= 60 else{
            
            switch digital{
            case .hour(let hour, let minute, let second):
                return String(format: "00\(hour)00\(minute)%02d\(second)", Int(timeInterval))
            case .minute(let minute, let second):
                return String(format: "00\(minute)%02d\(second)", Int(timeInterval))
            case .second(let second):
                return String(format: "%02d\(second)", Int(timeInterval))
            }
        }
        
        switch digital{
        case .hour(let hourString, let minuteString, let secondString):
            let hour   : Int =  Int(timeInterval) / 3600
            let minute : Int =  Int(timeInterval) % 3600 / 60
            let second : Int =  Int(timeInterval) % 60
            return String(format: "%02d\(hourString)%02d\(minuteString)%02d\(secondString)String", hour, minute, second)
        case .minute(let minuteString, let secondString):
            let minute : Int =  Int(timeInterval) / 60
            let second : Int =  Int(timeInterval) % 60
            return String(format: "%02d\(minuteString)%02d\(secondString)", minute, second)
        case .second(let secondString):
            return String(format: "%02d\(secondString)", Int(timeInterval))
        }
    }
}










