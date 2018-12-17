//
//  J0Date.swift
//
//  Created by Chen on 12/31/15.
//  Copyright © 2015 cn.j0. All rights reserved.
//

import Foundation

fileprivate struct J0DateConst{
    
    public static let YearString         = NSLocalizedString("年", comment: "")
    public static let MonthString        = NSLocalizedString("月", comment: "")
    public static let DayString          = NSLocalizedString("日", comment: "")
    public static let HourString         = NSLocalizedString("时", comment: "")
    public static let MinuteString       = NSLocalizedString("分", comment: "")
    public static let SecondString       = NSLocalizedString("秒", comment: "")
    
    public static let JustString         = NSLocalizedString("刚刚", comment: "")
    
    public static let AgoSecondString    = NSLocalizedString("秒前", comment: "")
    public static let AfterSecondString  = NSLocalizedString("秒后", comment: "")
    
    public static let AgoMinuteString    = NSLocalizedString("分钟前", comment: "")
    public static let AfterMinuteString  = NSLocalizedString("分钟后", comment: "")
    
    public static let YesterdayString = NSLocalizedString("昨天", comment: "")
    public static let NowadaysString  = NSLocalizedString("今天", comment: "")
    public static let TomorrowString  = NSLocalizedString("明天", comment: "")
}

public class J0Date{
    
    private init(){}
    
    public static var nowString : String{
        return J0Date.stringFrom(formatterString: "yyyy-MM-dd HH:mm:ss")
    }
    
    public static func stringFrom(formatterString : String) -> String {
        return self.stringFrom(date: Date(), formatterString: formatterString)
    }
    
    public static func stringFrom(date : Date, formatterString : String) -> String {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = formatterString
        dateFormatter.amSymbol = "上午"
        dateFormatter.pmSymbol = "下午"
        return dateFormatter.string(from: date)
    }
    
    public static func stringFrom(date : Date, formatterStyle : DateFormatter.Style) -> String {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = formatterStyle
        dateFormatter.timeStyle = formatterStyle
        dateFormatter.amSymbol = "上午"
        dateFormatter.pmSymbol = "下午"
        return dateFormatter.string(from: date)
    }
    
    public static func dateFrom(dateString : String, formatterString : String) -> Date? {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = formatterString
        dateFormatter.amSymbol = "上午"
        dateFormatter.pmSymbol = "下午"
        return dateFormatter.date(from: dateString)
    }
    
    public static func dateFrom(dateString : String, formatterStyle : DateFormatter.Style) -> Date? {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.amSymbol = "上午"
        dateFormatter.pmSymbol = "下午"
        dateFormatter.dateStyle = formatterStyle
        dateFormatter.timeStyle = formatterStyle
        return dateFormatter.date(from: dateString)
    }
    
    
    public static func isDay(date : Date, fromDate : Date = Date()) -> Bool{
        return J0Date.integer(date: date) == J0Date.integer(date: fromDate)
    }
    
    public static func isYear(date : Date, yearDate : Date = Date()) -> Bool{
        return J0Date.stringFrom(date: date, formatterString: "yyyy") == J0Date.stringFrom(date: yearDate, formatterString: "yyyy")
    }
    
    public static func integer(date : Date) -> Int?{
        return Int(J0Date.stringFrom(date: date, formatterString: "yyyyMMdd"))
    }
    
    public static func dateComponents(_ date : Date, components : Set<Calendar.Component> = [.year, .month, .era, .weekday, .day, .hour, .minute, .second]) -> DateComponents{
        return Calendar.current.dateComponents(components, from: date)
    }
    
    public static func dateComponents(_ fromDate : Date, toDate: Date, components : Set<Calendar.Component> = [.year, .month, .weekday, .era, .day, .hour, .minute, .second]) -> DateComponents{
        return Calendar.current.dateComponents(components, from: fromDate, to: toDate)
    }
    
    public static func getZeroWithDate(_ date:Date) -> TimeInterval {
        
        let dateFormater = DateFormatter.init()
        dateFormater.dateFormat = "yyyy年MM月dd日"
        
        let original = dateFormater.string(from: date)
        
        let zeroDate = dateFormater.date(from: original)
        
        return zeroDate?.timeIntervalSince1970 ?? Date().timeIntervalSince1970
        
    }
}


fileprivate typealias J0DateMethod = J0Date
public extension J0DateMethod{

    public static func friendly(date: Date) -> String {
        
        let calendar = Calendar.current
        let components : Set<Calendar.Component> = [.year, .month, .era, .day, .hour, .minute, .second];
        
        let compsDate    = calendar.dateComponents(components, from: date)
        let newCompsDate = calendar.dateComponents(components, from: Date())
        
        if compsDate.year != newCompsDate.year{
            return J0Date.stringFrom(date: date, formatterString: "yyyy\(J0DateConst.YearString)MM\(J0DateConst.MonthString)dd\(J0DateConst.DayString) a HH:mm")
        }
        
        if let compsDateDay = compsDate.day, let newCompsDateDay = newCompsDate.day {
            
            if let compsDateMonth = compsDate.month, let newCompsDateMonth = newCompsDate.month, compsDateMonth != newCompsDateMonth || abs(compsDateDay - newCompsDateDay) > 1 {
                
                return J0Date.stringFrom(date: date, formatterString: "MM\(J0DateConst.MonthString)dd\(J0DateConst.DayString) a HH:mm")
                
            } else if compsDateDay == newCompsDateDay + 1 {
                
                return J0DateConst.TomorrowString + " | " + J0Date.stringFrom(date: date, formatterString: "a HH:mm")
                
            } else if compsDateDay == newCompsDateDay - 1{
                
                return J0DateConst.YesterdayString + " | " + J0Date.stringFrom(date: date, formatterString: "a HH:mm")
            }
        }
        
        if let compsDateHour = compsDate.hour, let newCompsDateHour = newCompsDate.hour, let compsDateMinute = compsDate.minute, let newCompsDateMinute = newCompsDate.minute{
            
            let difference = (compsDateHour * 60 + compsDateMinute) - (newCompsDateHour * 60 + newCompsDateMinute)
            
            if difference >= -1 && difference <= 1{
                
                if difference == 1 {
                    return "\(1)" + J0DateConst.AfterMinuteString
                } else if difference <= -1{
                    return "\(1)" + J0DateConst.AgoMinuteString
                } else if let compsDateSecond : Int = compsDate.second, let newCompsDateSecond : Int = newCompsDate.second{
                    
                    let differenceSecond : Int = compsDateSecond - newCompsDateSecond
                    
                    if differenceSecond > 0{
                        return "\(differenceSecond)" + J0DateConst.AfterSecondString
                    }
                    else if differenceSecond < 0{
                        return "\(abs(differenceSecond))" + J0DateConst.AgoSecondString
                    }
                }
                return J0DateConst.JustString
            } else if difference > 0 && difference < 60{
                return "\(difference)" + J0DateConst.AfterMinuteString
            } else if difference < 0 && difference > -60{
                return "\(abs(difference))" + J0DateConst.AgoMinuteString
            }
        }
        
        return J0DateConst.NowadaysString + " | " + J0Date.stringFrom(date: date, formatterString: "a HH:mm")
    }
    
    
    public static func friendly(dateString: String , formatterString : String) -> String? {
        
        if let date = J0Date.dateFrom(dateString: dateString, formatterString: formatterString){
            return self.friendly(date: date)
        }
        return nil
    }
    
    
    
    public static func nearFuture(date: Date) -> String {
        
        let calendar = Calendar.current
        let components : Set<Calendar.Component> = [.year, .month, .era, .day, .hour, .minute, .second];
        
        let compsDate    = calendar.dateComponents(components, from: date)
        let newCompsDate = calendar.dateComponents(components, from: Date())
        
        if compsDate.year != newCompsDate.year{
            return J0Date.stringFrom(date: date, formatterString: "yyyy\(J0DateConst.YearString)MM\(J0DateConst.MonthString)dd\(J0DateConst.DayString) ")
        }
        
        if let compsDateDay = compsDate.day, let newCompsDateDay = newCompsDate.day {
            
            if let compsDateMonth = compsDate.month, let newCompsDateMonth = newCompsDate.month, compsDateMonth != newCompsDateMonth || abs(compsDateDay - newCompsDateDay) > 1 {
                
                return J0Date.stringFrom(date: date, formatterString: "MM\(J0DateConst.MonthString)dd\(J0DateConst.DayString)")
                
            } else if compsDateDay == newCompsDateDay + 1 {
                
                return J0DateConst.TomorrowString + " | " + J0Date.stringFrom(date: date, formatterString: "a HH:mm")
                
            } else if compsDateDay == newCompsDateDay - 1{
                
                return J0DateConst.YesterdayString + " | " + J0Date.stringFrom(date: date, formatterString: "a HH:mm")
            }
        }
        
        if let compsDateHour = compsDate.hour, let newCompsDateHour = newCompsDate.hour, let compsDateMinute = compsDate.minute, let newCompsDateMinute = newCompsDate.minute{
            
            let difference = (compsDateHour * 60 + compsDateMinute) - (newCompsDateHour * 60 + newCompsDateMinute)
            
            if difference >= -1 && difference <= 1{
                
                if difference == 1 {
                    return "\(1)" + J0DateConst.AfterMinuteString
                } else if difference <= -1{
                    return "\(1)" + J0DateConst.AgoMinuteString
                } else if let compsDateSecond : Int = compsDate.second, let newCompsDateSecond : Int = newCompsDate.second{
                    
                    let differenceSecond : Int = compsDateSecond - newCompsDateSecond
                    
                    if differenceSecond > 0{
                        return "\(differenceSecond)" + J0DateConst.AfterSecondString
                    }
                    else if differenceSecond < 0{
                        return "\(abs(differenceSecond))" + J0DateConst.AgoSecondString
                    }
                }
                return J0DateConst.JustString
            } else if difference > 0 && difference < 60{
                return "\(difference)" + J0DateConst.AfterMinuteString
            } else if difference < 0 && difference > -60{
                return "\(abs(difference))" + J0DateConst.AgoMinuteString
            }
        }
        
        return J0DateConst.NowadaysString + " | " + J0Date.stringFrom(date: date, formatterString: "a HH:mm")
    }
}




