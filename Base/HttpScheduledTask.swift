//
//  HttpScheduledTask.swift
//  WepictureSDK
//
//  Created by bi we on 2018/11/20.
//  Copyright © 2018 bi we. All rights reserved.
//

import Foundation
import Alamofire

public class HttpScheduledTask {
    //请求地址
    var url:String?
    
    //请求参数
    var params:[String:Any]?
    
    //定时请求时间间隔
    var timeInterval:TimeInterval!
    
    //请求响应回调
    var callBack:(Data)->Void
    
    //定时任务Timer，用于停止定时任务
    var timer:Timer?
    
    //初始化。参数默认为空，时间间隔默认为1秒，默认没用回调处理。
    public init(url:String, params:[String:Any] = [:],timeInterval:TimeInterval = 1,
                callBack:@escaping (Data)->Void = {_ in}) {
        self.url = url
        self.params = params
        self.timeInterval = timeInterval
        self.callBack = callBack
    }
    
    //启动任务
    public func start(){
        //如果之前有定时任务，先停止
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: self.timeInterval,
                                          target:self,selector:#selector(onTime),
                                          userInfo:nil,repeats:true)
    }
    
    //时间到，开始请求
    @objc func onTime() {
        Alamofire.request(self.url!, parameters: params).response { (response) in
            if let data = response.data {
                //调用回调函数
                self.callBack(data)
            }
        }
        
    }
    
    //停止任务
    public func stop() {
        self.timer?.invalidate()
    }
}

