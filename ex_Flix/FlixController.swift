//
//  FlixController.swift
//  ex_Flix
//
//  Created by Fung on 2/20/19.
//  Copyright © 2019 fungyung. All rights reserved.
//

import UIKit

class FlixController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movies = [[String:Any]]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //print(dataDictionary)
                
                self.movies = dataDictionary["results"] as! [[String:Any]]
                self.tableView.reloadData()//use this to call numberOfRowsInSection then call cellForRowAtß
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//                let cell = UITableViewCell()
//                cell.textLabel?.text = "This is row \(indexPath.row)"
//
//                return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell

        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let dsc = movie["overview"] as! String
        
        let baseUrl = ""
        let posterPath = movie[""] as! String
        let posterUrl = URL(String: baseUrl + posterPath)
        
        cell.titleLbl.text = title
        cell.desLbl.text = dsc
        
        return cell
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
