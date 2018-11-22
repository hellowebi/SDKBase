//
//  ImageProcessor.swift
//  WepictureSDK
//
//  Created by bi we on 2018/11/20.
//  Copyright © 2018 bi we. All rights reserved.
//

import UIKit

public class ImageProcessor {
    //保存原始图片
    var image:UIImage?
    
    lazy var context: CIContext = {
        return CIContext(options: nil)
    }()
    
    //初始化
    public init(image:UIImage?) {
        self.image = image
    }
    
    //返回像素化后的图片
    public func pixellated(scale:Int = 30) -> UIImage? {
        if image == nil {
            return nil
        }
        //使用像素化滤镜
        let filter = CIFilter(name: "CIPixellate")!
        let inputImage = CIImage(image: image!)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        //设置像素版半径，值越大马赛克就越大
        filter.setValue(scale, forKey: kCIInputScaleKey)
        let fullPixellatedImage = filter.outputImage
        
        let cgImage = context.createCGImage(fullPixellatedImage!,
                                            from: fullPixellatedImage!.extent)
        return UIImage(cgImage: cgImage!)
    }
    
    //返回高斯模糊后的图片
    public func blured(radius:Int = 40) -> UIImage? {
        if image == nil {
            return nil
        }
        //使用高斯模糊滤镜
        let filter = CIFilter(name: "CIGaussianBlur")!
        let inputImage = CIImage(image: image!)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        //设置模糊半径值（越大越模糊）
        filter.setValue(radius, forKey: kCIInputRadiusKey)
        let outputCIImage = filter.outputImage
        let rect = CGRect(origin: CGPoint.zero, size: image!.size)
        let cgImage = context.createCGImage(outputCIImage!, from: rect)
        return UIImage(cgImage: cgImage!)
    }

}
