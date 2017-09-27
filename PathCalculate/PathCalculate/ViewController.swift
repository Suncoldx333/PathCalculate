//
//  ViewController.swift
//  PathCalculate
//
//  Created by 11111 on 2017/9/27.
//  Copyright © 2017年 Suncoldx3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var calculateBt: UIButton = {
        let inner = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        inner.titleLabel?.text = "Calculate"
        inner.backgroundColor = ColorMethodho(hexValue: 0xb2b2b2)
        return inner
    }()
    
    func initData() {
        
    }
    
    func initUI() {
        self.view.backgroundColor = ColorMethodho(hexValue: 0xffffff)
        
        calculateBt.addTarget(self, action: #selector(calculatePointPath), for: .touchUpInside)
        self.view.addSubview(calculateBt)
    }
    
    func calculatePointPath() {
        
        let lats = ["30.214898","30.215370","30.214021","30.214360","30.213502"]
        let lons = ["120.204429","120.205466","120.205103","120.203441","120.203993"]
        var models = [PointModel]()
        
        for index in 1..<6 {
            let model1 = PointModel.init()
            model1.pointFlag = "1505359921000"
            model1.pointId = String.init(format: "%d", index)
            model1.pointLat = lats[index - 1]
            model1.pointLon = lons[index - 1]
            model1.pointIsFixed = index == 1 ? "1" : "0"
            models.append(model1)
        }
        
        let manage = SWPointPathManage.shareInstance
        var duration : Double = 0
        let timeFor = DateFormatter.init()
        timeFor.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
        //性能计时
        for _ in 0..<100 {
            let beginDate = Date.init()
            let begin : Double = beginDate.timeIntervalSince1970 * 1000
            let _ = manage.exhaustionAllSatisfedPath(models, queueMemberCount: 4, minLength: 800)
            //            guard let error = result.error else {
            //                let _ = result.result.map({ (model) in
            //                    print("id = \(model.pointId),sequence = \(model.pointSequence)")
            //                })
            //                return
            //            }
            //            printWithTime("error = \(error)")
            let endDate = Date.init()
            let end : Double = endDate.timeIntervalSince1970 * 1000
            duration = duration + end - begin
        }
        print("duration = \(duration)")
        
    }

}

