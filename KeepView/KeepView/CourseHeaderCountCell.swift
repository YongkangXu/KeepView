//
//  CourseHeaderCountCell.swift
//  MagicApp
//
//  Created by maple on 2018/12/7.
//  Copyright © 2018年 Xuyongkang. All rights reserved.
//

import UIKit

class CourseHeaderCountCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var contContainView: UIView!
    @IBOutlet weak var heightForCount: NSLayoutConstraint!
    
    
    
    var gradienLayer:CAGradientLayer!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contContainView.layer.cornerRadius = 20
        contContainView.layer.masksToBounds = true
        
        
    }
    
    internal func setContentWith(_ rate:CGFloat, isselected:Bool) {
        
        self.countLbl.alpha = isselected ? 1.0:0.4
        self.titleLbl.alpha = isselected ? 1.0:0.4
        
        self.heightForCount.constant = (self.frame.size.height - 40) * rate
        
    
        if gradienLayer != nil {
            gradienLayer.removeFromSuperlayer()
        }
        
        if isselected == true {
            
            gradienLayer = CAGradientLayer.init()
            gradienLayer.frame = CGRect.init(x: 0, y: 0, width: 40, height: self.heightForCount.constant-20)
            gradienLayer.colors = [UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.white.withAlphaComponent(0.8).cgColor]
            gradienLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradienLayer.endPoint = CGPoint.init(x: 0, y: 1)
            gradienLayer.locations = [0.1, 1]
            self.contContainView.layer.addSublayer(gradienLayer)
            
        } else {
            gradienLayer = CAGradientLayer.init()
            gradienLayer.frame = CGRect.init(x: 0, y: 0, width: 40, height: self.heightForCount.constant-20)
            gradienLayer.colors = [UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.white.withAlphaComponent(0).cgColor]
            gradienLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradienLayer.endPoint = CGPoint.init(x: 0, y: 1)
            gradienLayer.locations = [0.1, 1]
            self.contContainView.layer.addSublayer(gradienLayer)
        }
        
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
