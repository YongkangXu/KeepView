# KeepView
仿keep数据中心 滑动图表

![image](https://github.com/YongkangXu/KeepView/blob/master/KEEPVIEW.gif)


# 调用方法

初始化赋值

        fileprivate lazy var keepView:ClassVideoHeaderView = {
        
            let view1 = ClassVideoHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300))
        
            return view1
        }()


        self.view.addSubview(self.keepView)
        
        self.keepView.center = self.view.center
        
        // 实现下标回调
        self.keepView.indexBlock = {[weak self] index in
             self?.currentIndex = index
        }
        
        //数据源赋值
        self.keepView.setcontentWith(self.keepModels, selectIndex: self.currentIndex, isMore: false)
