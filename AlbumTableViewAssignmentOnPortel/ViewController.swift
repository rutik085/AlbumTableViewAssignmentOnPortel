//
//  ViewController.swift
//  AlbumTableViewAssignmentOnPortel
//
//  Created by Mac on 04/01/24.
//

import UIKit

class ViewController: UIViewController {
     
    @IBOutlet weak var postTableView: UITableView!
    
    var posts : [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        initilizeTableView()
        registerXIBWithTableView()
    }
    func initilizeTableView(){
        postTableView.delegate = self
        postTableView.dataSource = self
    }
    func registerXIBWithTableView(){
        let uiNib = UINib(nibName: "TableViewCell", bundle: nil)
        postTableView.register(uiNib, forCellReuseIdentifier: "TableViewCell")
    }
    func fetchData(){
        let postUrlString = "https://jsonplaceholder.typicode.com/albums"
        let postUrl = URL(string: postUrlString)
        
        var postUrlRequest = URLRequest(url: postUrl!)
        postUrlRequest.httpMethod = "GET"
        
        let postUrlSesson = URLSession(configuration: .default)
        
        var postdataTask = postUrlSesson.dataTask(with: postUrlRequest) { postData, postUrlResponse, postError in
            
            let postResponse = try! JSONSerialization.jsonObject(with: postData!) as! [[String : Any]]
            for eachResponse in postResponse
            {
                let postDictonary = eachResponse as! [String : Any]
                let postuserId = postDictonary["userId"] as! Int
                let postid = postDictonary["id"] as! Int
                let posttitle = postDictonary["title"] as! String
                let postObject = Post(userId: postuserId, id: postid, title: posttitle)
                self.posts.append(postObject)
            }
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        }
        postdataTask.resume()
    }
}
extension ViewController : UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200.0
    }
}



extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postTableViewCell = self.postTableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        postTableViewCell.userId.text = String(posts[indexPath.row].userId)
        postTableViewCell.id.text = String(posts[indexPath.row].id)
        postTableViewCell.title.text = (posts[indexPath.row].title)
        return postTableViewCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
}
