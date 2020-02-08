//
//  ViewController.swift
//  WIKIapp
//
//  Created by Shashila Heshan on 8/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit

class WikiViewController: UIViewController {

    @IBOutlet weak var txtDesc: UILabel!
    
    @IBOutlet weak var txtImage: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtQuery: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func clearFields()  {
        self.txtImage.image = nil
        self.txtDesc.text = "Title"
        self.txtDesc.text = "Description"
    }
    @IBAction func searchData(_ sender: Any) {
        let query = self.txtQuery.text
       
        if(query!.count > 0) {
           
            
            ApiService.getDataFromWikiApi(query: query!){
                (succes, data1) in
                if succes {
                    self.clearFields()
                    let title = data1?.title
                self.txtTitle.text = title!
                    let desc = data1?.extract
                    self.txtDesc.text = desc!
                    let image = data1?.thumbnail
                    let url = URL(string: image!)
            
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url!)
                        DispatchQueue.main.async {
                            self.txtImage!.image = UIImage(data: data!)

                        }
                    }
                } else {
                   
                }
            }
            
        }
    }
    
}

