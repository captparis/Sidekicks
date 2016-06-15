//
//  FilterManager.swift
//  Sidekicks
//
//  Created by mac rent on 21/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import Foundation
import CoreImage
import UIKit

class FilterManager {
 
    var filterList: [CIFilter] = []
    
    var sepiaFilter: CIFilter!
    var vignetteFilter: CIFilter!
    var blurFilter: CIFilter!
    var bloomFilter: CIFilter!
    
    var beginImage: CIImage!
    var context: CIContext!
    
    init(){
        //sepiaFilter = CIFilter(name: "CISepiaTone")
        //vignetteFilter = CIFilter(name: "CIVignette")
        context = CIContext(options:nil)
    }
    
    
    
    func setupFilter (toFilter: UIImage){
        //let fileURL = NSBundle.mainBundle().URLForResource("image", withExtension: "png")
        //let vignette = CIFilter(name:"CIVignette")
        beginImage = CIImage(image: toFilter)
        sepiaFilter = CIFilter(name: "CISepiaTone")
        sepiaFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        vignetteFilter = CIFilter(name: "CIVignette")
        vignetteFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        blurFilter = CIFilter(name: "CIBoxBlur")
        blurFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        bloomFilter = CIFilter(name: "CIBloom")
        bloomFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        
        //let newImage = UIImage(CIImage: filter.outputImage!)
        context = CIContext(options:nil)
        
        //return newImage
        
    }
    
    
    
    func shiftFilter (toFilter: UIImage, shiftNum: Int) -> UIImage{
        if (shiftNum == 0){
            
        }
        
        beginImage = CIImage(image: toFilter)
        let filter = filterList[shiftNum]
        let newImage = UIImage(CIImage: filter.outputImage!)
        
        return newImage
    }
    
    func sepiaSliderFilter(inputImage: UIImage, value: Float) -> UIImage{
        let sliderValue = value
        sepiaFilter.setValue(sliderValue, forKey: kCIInputIntensityKey)
        let outputImage = sepiaFilter.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newImage = UIImage(CGImage: cgimg)
        return newImage
        
    }
    
    func vignetteSliderFilter(inputImage: UIImage, value: Float) -> UIImage{
        let sliderValue = value
        vignetteFilter.setValue(sliderValue, forKey: kCIInputIntensityKey)
        let outputImage = vignetteFilter.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newImage = UIImage(CGImage: cgimg)
        return newImage
        
    }
    
    func bloomSliderFilter(inputImage: UIImage, value: Float) -> UIImage{
        let sliderValue = value
        bloomFilter.setValue(sliderValue, forKey: kCIInputIntensityKey)
        bloomFilter.setValue(sliderValue*10, forKey: "inputRadius")
        var outputImage = bloomFilter.outputImage
        outputImage = outputImage!.imageByCroppingToRect(beginImage.extent)
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newImage = UIImage(CGImage: cgimg)
        return newImage
        
    }
    
    func blurSliderFilter(inputImage: UIImage, value: Float) -> UIImage {
        let sliderValue = value
        blurFilter.setValue(sliderValue*10, forKey: "inputRadius")
        var outputImage = blurFilter.outputImage
        outputImage = outputImage!.imageByCroppingToRect(beginImage.extent)
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newImage = UIImage(CGImage: cgimg)
        return newImage
    }
}
