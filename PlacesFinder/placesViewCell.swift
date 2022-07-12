//
//  placesViewCell.swift
//  PlacesFinder
//
//  Created by New User on 12/07/22.
//

import UIKit
import CoreLocation
protocol showMap{
    func didClickOnMap(index : IndexPath)
}
class placesViewCell: UITableViewCell {

//    let feedItem : mapResponse
    var index : IndexPath?
    var delegate : showMap?
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellSubtitle: UILabel!
    @IBOutlet weak var showInMapButton: UIButton!
    static let cellIdentifier = "placesViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func showInMapButton(_ sender: Any) {
        delegate?.didClickOnMap(index: self.index ?? IndexPath(row: 0, section: 0))
    }
    
}
