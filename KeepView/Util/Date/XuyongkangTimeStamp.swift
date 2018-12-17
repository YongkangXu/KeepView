//
//  XuyongkangTimeStamp.swift 
//
//  Created by Xuyongkang on 17/1/7.
//  Copyright © 2017年 Xuyongkang. All rights reserved.
//

import Foundation

public enum XuyongkangTimeStamp{
    
    case since1970, since2001
    
    public var timeInterval : TimeInterval {
        switch self {
        case .since1970: return Date().timeIntervalSince1970
        case .since2001: return Date().timeIntervalSinceReferenceDate
        }
    }
    
    public var int64 : Int64 {
        return Int64(self.timeInterval)
    }
    
    public var string : String{
        return String(self.int64)
    }
    
    public func string(_ timeStamp : TimeInterval, _ dateFormat : String = "yyyy-MM-dd hh:mm") -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: {
            switch self {
            case .since1970: return Date(timeIntervalSince1970: timeStamp)
            case .since2001: return Date(timeIntervalSinceNow: timeStamp)
            }
        }())
    }
    
    public func date(_ timeStamp : TimeInterval) -> Date{
        
        switch self{
        case .since1970: return Date(timeIntervalSince1970: timeStamp)
        case .since2001: return Date(timeIntervalSinceReferenceDate: timeStamp)
        }
    }
}
















