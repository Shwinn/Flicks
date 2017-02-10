//
//  DetailViewController.swift
//  Flicks
//
//  Created by Ashwin Gupta on 2/5/17.
//  Copyright © 2017 Ashwin Gupta. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        print(movie)
        
        let title = movie["title"] as? String
        titleLabel.text = title
        let overview = movie["overview"] as? String
        overviewLabel.text = overview
        
        overviewLabel.sizeToFit()
        
        /*let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        if let posterPath = movie["poster_path"] as? String {
            print(posterPath)
            let imageUrl = URL(string: baseUrl + posterPath)
            print("imageURL: \(imageUrl)")
            posterImageView.setImageWith(imageUrl!)
        } */
        
        
        
        //let imageUrl = URL(string: "http://image.tmdb.org/t/p/w500" + (movie["poster_path"] as? String)!)
        //posterImageView.setImageWith(imageUrl!)
        
        if let posterPath = movie["poster_path"] as? String {
            //print("got in")
            //let imageUrl = URL(string: "http://image.tmdb.org/t/p/w500" + posterPath)
            //posterImageView.setImageWith(imageUrl!)
            
            let smallImageRequest = URLRequest(url: URL(string: "http://image.tmdb.org/t/p/w45" + posterPath)!)
            print(smallImageRequest)
            let largeImageRequest = URLRequest(url: URL(string: "http://image.tmdb.org/t/p/w500" + posterPath)!)
            print(largeImageRequest)
            
            self.posterImageView.setImageWith(smallImageRequest, placeholderImage: nil, success: {
                (smallImageRequest, smallImageResponse, smallImage) -> Void in
                
                self.posterImageView.alpha = 0.0
                self.posterImageView.image = smallImage
                print("Small Image Set")
                
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.posterImageView.alpha = 1.0
                }, completion: {
                    (success) -> Void in
                    
                    self.posterImageView.setImageWith(largeImageRequest, placeholderImage: smallImage, success: {
                        (largeImageRequest, largeImageResponse, largeImage) -> Void in
                    
                        self.posterImageView.image = largeImage
                        print("Large Image Set")
                        
                    }, failure: {
                        (request, response, error) -> Void in
                    
                        print("Fail on large image request")
                    })
                })
                
            }, failure: {
                (request, response, error) -> Void in
                
                print("Fail on small image request")
            })
            print("Finished")
            
            
            //let imageUrl = URL(string: "http://image.tmdb.org/t/p/w500" + posterPath)
            //posterImageView.setImageWith(imageUrl!)
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
