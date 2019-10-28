//
//  ViewController.swift
//  TableView
//
//  Created by Mohamed on 10/28/19.
//  Copyright © 2019 Mohamed74. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let url_data = "http://192.168.1.2/iOSApp/ApiData.php"

    let session = URLSession.shared
    
    var dataModel: [DataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        guard let url = URL(string: url_data) else {return}

        getTableViewData(url)
        
    }
    
    
    func getTableViewData(_ url: URL){
    
        
        session.dataTask(with: url) { (data, response, error) in
            
            
            if error == nil{
                
                if let data = data{
                    
                    do{
                        
                        let decode = try JSONDecoder().decode([DataModel].self , from: data)
                        self.dataModel = decode
                        DispatchQueue.main.async {
                            
                            self.tableView.reloadData()
                        }
                        
                    }catch{
                        
                        print("error \(error.localizedDescription)")
                    }
                }
                
                
            }else{
                
                
                print("error")
            }
            
        }.resume()
        
        
    }
}


extension ViewController : UITableViewDataSource , UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellItem", for: indexPath) as! CustomCellTableViewCell
        
        cell.titleLabel.text = dataModel[indexPath.row].title
        cell.descriptionLabel.text = dataModel[indexPath.row].description
        cell.imageView?.image = UIImage(named: dataModel[indexPath.row].image!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
}

