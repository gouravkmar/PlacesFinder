//
//  Home.swift
//  PlacesFinder
//
//  Created by New User on 11/07/22.
//

import UIKit
//mapResponse
class Home: UIViewController {
    var dataManager = DataManager()
    var nextMapFeed : [mapResponse] = []
    @IBAction func showAllItemsInMap(_ sender: Any) {
        nextMapFeed = dataManager.feed
        performSegue(withIdentifier: "mapSegue", sender: self)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: placesViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: placesViewCell.cellIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshView), name: NSNotification.Name(rawValue: "placefinder.locationsUpdated"), object: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mapobj = segue.destination as? Map
        mapobj?.feed = nextMapFeed
        
    }
    @objc func refreshView(){
        tableView.reloadData()
    }
    
}

extension Home :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: placesViewCell.cellIdentifier, for: indexPath) as? placesViewCell
        cell?.cellTitle.text = dataManager.feed[indexPath.row].name
        //        cell?.cellImage.image = UIImage.init(named: "center-icon-4")
        cell?.delegate = self
        cell?.index = indexPath
        if(cell == nil )
        { return  UITableViewCell(style: .default, reuseIdentifier: placesViewCell.cellIdentifier)}
        
        return cell!
    }
    
    
    
    
}
extension Home : showMap{
    func didClickOnMap(index: IndexPath) {
        if index.row < dataManager.feed.count{
            let mapItem = dataManager.feed[index.row]
            nextMapFeed = [mapItem]
            performSegue(withIdentifier: "mapSegue", sender: self)
        }
    }
    
    
}
