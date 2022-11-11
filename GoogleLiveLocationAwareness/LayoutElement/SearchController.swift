//
//  SearchController.swift
//  GoogleLiveLocationAwareness
//
//  Created by Dayo Banjo on 10/15/22.
//

import UIKit
import CoreLocation

class SearchController: UIViewController {

    let handlerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
    let categorySegmentedControl = UISegmentedControl (items: ["Alert","Event","Health"])
        
    var currentData = [Place]() {
        didSet{
            activityListView.reloadData()
        }
    }
    
    var updateMarker : ((Int)->())?
    
    let titleLabel = UILabel(frame: .zero)
    
    private let activityListView : UITableView = {
        let table = UITableView()
        table.register(PlaceViewCell.self, forCellReuseIdentifier: PlaceViewCell.identifier)
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.backgroundColor = .clear
        table.rowHeight = 100
        return table
    }()
    
    var loadDataForAlert : (()->())?
    var loadDataForHealth : (()->())?
    var loadDataForEvent: (()->())?
    var loadDataForNigeriaFlood : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        view.backgroundColor = .black
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
                
        view.addSubviews(categorySegmentedControl, titleLabel, activityListView)
        categorySegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        categorySegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        categorySegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categorySegmentedControl.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30).isActive = true
        categorySegmentedControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
        categorySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        categorySegmentedControl.selectedSegmentIndex = 1
        categorySegmentedControl.selectedSegmentTintColor = .blue
        categorySegmentedControl.layer.cornerRadius = 24
        
        titleLabel.text = "Learn about the latest events"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .white
        
        titleLabel.anchor(top: categorySegmentedControl.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16))
        
        activityListView.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        activityListView.backgroundColor = .clear
        activityListView.delegate = self
        activityListView.dataSource = self
    
    }
    
 
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        switch(sender.selectedSegmentIndex){
            case 0 : 
                loadDataForAlert?()
            case 1:
                loadDataForEvent?()
            case 2: 
                loadDataForHealth?()
                
            default:
                break
        }
        
        activityListView.reloadData()
    }

    
    func loadActivityViewController(with place : Place) {
        let activityDetailController = ActivityDetailViewController()
        activityDetailController.place = place
        activityDetailController.type = categorySegmentedControl.selectedSegmentIndex
        navigationController?.pushViewController(activityDetailController, animated: true)
    }
 
    

}

extension SearchController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceViewCell.identifier, for: indexPath) as? PlaceViewCell 
        cell?.setUp(place:  currentData[indexPath.row])
        cell?.onButtonTap = {
            self.loadActivityViewController(with: self.currentData[indexPath.row])
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // loadActivityViewController(with: currentData[indexPath.row])
        updateMarker?(indexPath.row)
    }

    
}


extension SearchController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            loadDataForNigeriaFlood?()
        }
    }
        
}
