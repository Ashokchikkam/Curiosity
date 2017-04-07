//
//  ViewController.swift
//  Curiosity
//
//  Created by Ashok on 4/6/17.
//  Copyright © 2017 Ashok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Mark: Properties
    @IBOutlet weak var bgImageView: UIImageView!
    
    private weak var timer: Timer?
    private var imageSet = [UIImage]()
    var x = 0
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To load BackGround images from web.
        loadBgImages()
        
        //Calling changeBGImage every 4 seconds gives the changing background.
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true){_ in
            self.changeBGImage()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func loadBgImages(){
        
        //Add any background images to the bgSet.
        var bgSet = [String]()
        let bg01 = "https://www.nasa.gov/centers/ames/images/content/671125main_msl20110519_PIA14156.jpg"
        let bg02 = "http://www.manilalivewire.com/wp-content/uploads/2015/08/Mars-Curiosity-Rover-with-Laser-0301-960x700.jpg"
        let bg03 = "http://news.nationalgeographic.com/content/dam/news/photos/000/578/57828.jpg"
        let bg04 = "http://www.hdwallpapers.org/walls/nasa-curiosity-mars-rover-wide.jpg"
        //let bg05 = "https://www.nasa.gov/centers/ames/images/content/671125main_msl20110519_PIA14156.jpg"

        
        bgSet += [bg01, bg02, bg03, bg04]
        
        for bg in bgSet{
            loadImage(url: bg)
        }
    }
    
    //To load the images from the web.
    func loadImage(url: String){
        let url = URL(string: url)!
        var bgImage: UIImage?
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.global().sync {
                    bgImage = UIImage(data: data)
                    self.imageSet.append(bgImage!)
                    
                    //self.videoPreviewImage.image = UIImage(data: data)
                }
            } catch  {
                print("unable to find the image at the given url")
                //handle the error
            }
        }
    }
    
    //To change BackGround Images continously.
    func changeBGImage(){
        let crossFading: CABasicAnimation = CABasicAnimation(keyPath: "contents")

        if(x == imageSet.count-1){

            x=0
        }
        crossFading.duration = 2
        crossFading.fromValue = imageSet[x].cgImage
        crossFading.toValue = imageSet[x + 1].cgImage
        bgImageView.image = imageSet[x+1]
        bgImageView.layer.add(crossFading, forKey: "animateContents")
        
        x += 1
    }
    
}
