//
//  ClassVideoHeaderView.swift
//  MagicApp
//
//  Created by maple on 2018/12/5.
//  Copyright © 2018年 Xuyongkang. All rights reserved.
//

import UIKit

class ClassVideoHeaderView: UIView {

    enum Status {
        case statusPulling
        case statusNormal
        case statusRefreshing
    }
    
    fileprivate var contentView : UIView?
    @IBOutlet weak var collectionview: UICollectionView!
    
    var models:[KeepModel] = [KeepModel]()
    
    var oldStatus:Status = .statusNormal
    
    /**
     方便左右刷新
     */
    var status:Status = .statusNormal {
        willSet {
            self.oldStatus = status
        }
        didSet{
            switch status {
            case .statusNormal:
                if self.oldStatus == .statusRefreshing {
                    UIView.animate(withDuration: 0.25) {
                        self.collectionview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                    }
                }
                break
            case .statusRefreshing:
                UIView.animate(withDuration: 0.25) {
                    self.collectionview.setContentOffset(CGPoint.init(x: -50, y: 0), animated: true)
                    self.actionLoadMoreData()
                }
            default:
                break
            }
        }
    }
    
    /**
     点击或者滑动停留返回的下标
     */
    var indexBlock:((Int)->())?
    var selectIndex:Int = 0
    
    /**
     加载更多
     */
    var loadMoreBlock:(()->())?
    
    deinit {
        debugPrint("deinit:\(self.classForCoder)")
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        self.initNib()
    }
    
    internal override func awakeFromNib() {
        self.initNib()
    }
    
    private func initNib(){
        
        let nibName = String(describing: type(of: self))
        let nibBundle = Bundle(for: type(of: self))
        
        guard let nibView = UINib(nibName: nibName, bundle: nibBundle).instantiate(withOwner: self, options: nil).first as? UIView else{
            return
        }
        
        nibView.frame = bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(nibView)
        self.contentView = nibView
        self.contentView?.backgroundColor = UIColor.clear
        self.collectionview.showsHorizontalScrollIndicator = false
        
        self.initView()
    }

    fileprivate func initView(){
        
        self.collectionview.register(UINib(nibName: "CourseHeaderCountCell", bundle: nil), forCellWithReuseIdentifier: "CourseHeaderCountCell")
    
        self.collectionview.register(CourseHeaderReuseView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CourseHeaderReuseView")
        self.collectionview.register(CourseHeaderReuseView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CourseHeaderReuseView")

        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        self.collectionview.backgroundColor = UIColor.clear
        
    }
    
    /**
     models: 数据源
     selectIndex : 选中下标
     isMore :  是否加载更多
     */
    //MARK:- 赋值
    internal func setcontentWith(_ models:[KeepModel], selectIndex:Int, isMore:Bool) {
        
        self.selectIndex = selectIndex
        
        self.models = models
        self.collectionview.reloadData()
        
        if isMore != true {
            self.collectionview.scrollToItem(at: IndexPath.init(item: self.models.count-1, section: 0), at: .centeredHorizontally, animated: false)
            if self.indexBlock != nil {
                self.indexBlock!(self.models.count-1)
                
                self.selectIndex = self.models.count-1
                
            }
        }else {
            self.collectionview.scrollToItem(at: IndexPath.init(item: self.selectIndex, section: 0), at: .centeredHorizontally, animated: false)
        }

    }
    
    //MARK:- 加载更多
    fileprivate func actionLoadMoreData() {
        
        if self.loadMoreBlock != nil {
            self.loadMoreBlock!()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: UInt64(Int(1)))) {
            
            self.status = .statusNormal
            
        }
        
    }
    
    fileprivate func getMaxCountFromModels() -> (maxcount:Int, index:Int) {
        
        var maxCount = 0
        var index = 0
        for i in 0..<self.models.count {
            
            let item = self.models[i]
            
            if item.medalTotalCount > maxCount {
                index = i
                maxCount = item.medalTotalCount
            }
            
        }
        
        return (maxCount,index)
    }
    
}

typealias collectionview_ClassVideoHeaderView = ClassVideoHeaderView
extension collectionview_ClassVideoHeaderView:UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout , UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseHeaderCountCell", for: indexPath)
        
        if let cell = cell as? CourseHeaderCountCell{
            
            cell.countLbl.text = "\(self.models[indexPath.item].medalTotalCount)次"
            
            cell.titleLbl.text = XuyongkangDate.stringFrom(date: Date.init(timeIntervalSince1970: TimeInterval(self.models[indexPath.item].beginTime)), formatterString: "MM/dd")

            cell.setContentWith( CGFloat(self.getMaxCountFromModels().maxcount) > 0 ? CGFloat(self.models[indexPath.item].medalTotalCount)/CGFloat(self.getMaxCountFromModels().maxcount) : 0.0, isselected: self.selectIndex == indexPath.item ? true:false)
            
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.collectionview.reloadData()
        self.collectionview.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        self.selectIndex = indexPath.item
        self.collectionview.reloadData()
        
        if self.indexBlock != nil {
            self.indexBlock!(indexPath.item)
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 50, height: self.collectionview.frame.size.height )
 
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let reusebleview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CourseHeaderReuseView", for: indexPath) as! CourseHeaderReuseView
            return reusebleview
        } else  {
            let reusebleview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CourseHeaderReuseView", for: indexPath) as! CourseHeaderReuseView
            return reusebleview
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionview.frame.size.width / 2 - 25, height: self.collectionview.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionview.frame.size.width / 2 - 25, height: self.collectionview.frame.size.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isDragging {
            if scrollView.contentOffset.x > -50 {
                if self.status == .statusPulling {
                    self.status = .statusNormal
                }
    
            } else {
                if self.status == .statusNormal {
                    self.status = .statusPulling
                }
            }
        } else {
            if self.status == .statusPulling {
                self.status = .statusRefreshing
            }
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexpaths = self.collectionview.indexPathsForVisibleItems
        var spaceArr :[Float: IndexPath] = [:]
        for indexpath in indexpaths {
            if let cell = self.collectionview.cellForItem(at: indexpath) as? CourseHeaderCountCell {
                let cellInCollection = collectionview.convert(cell.frame, to: self.collectionview)
                let cellInSuperview = collectionview.convert(cellInCollection, to: self)
                let space = fabsf((Float(cellInSuperview.origin.x - UIScreen.main.bounds.size.width / 2)))
                
                spaceArr[space] = indexpath
            }
        }
    
        if let minSpace = spaceArr.keys.min() {
            if let indexpath = spaceArr[minSpace] {
                
                self.collectionview.scrollToItem(at: indexpath , at: .centeredHorizontally, animated: true)
                
                self.selectIndex = indexpath.item
                self.collectionview.reloadData()
                
                if self.indexBlock != nil {
                    self.indexBlock!(indexpath.item)

                }
                
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        debugPrint("decelerate===\(decelerate)")
        if decelerate == false {
            let indexpaths = self.collectionview.indexPathsForVisibleItems
            var spaceArr :[Float: IndexPath] = [:]
            for indexpath in indexpaths {
                if let cell = self.collectionview.cellForItem(at: indexpath) as? CourseHeaderCountCell {
                    
                    let cellInCollection = collectionview.convert(cell.frame, to: self.collectionview)
                    let cellInSuperview = collectionview.convert(cellInCollection, to: self)
                    let space = fabsf((Float(cellInSuperview.origin.x - UIScreen.main.bounds.size.width / 2)))
                    
                    spaceArr[space] = indexpath
                }
            }
            
            if let minSpace = spaceArr.keys.min() {
                if let indexpath = spaceArr[minSpace] {
                    
                    self.collectionview.scrollToItem(at: indexpath , at: .centeredHorizontally, animated: true)
                    
                    self.selectIndex = indexpath.item
                    self.collectionview.reloadData()
                    
                    if self.indexBlock != nil {
                        self.indexBlock!(indexpath.item)

                    }
                    
                }
            }
        }
    }
}
