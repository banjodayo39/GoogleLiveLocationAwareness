//
//  ViewController.swift
//  GoogleLiveLocationAwareness
//
//  Created by Dayo Banjo on 10/15/22.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    let mapController = MapViewController()
    let searchController = SearchController()
    lazy var viewControllerToPresent = UINavigationController(rootViewController: searchController)
    
    let viewModel = HomeViewModel()
    
    let drawerButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    let showPanoramaButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    var canShowPresentationSheet = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChildController()
    }

    // MARK: Set up map controller 
    
    func setUpChildController() {
        view.addSubview(mapController.view)        
        addChild(mapController)
        mapController.didMove(toParent: parent)
        mapController.view.frame = view.bounds  
        
        view.addSubviews(drawerButton, showPanoramaButton)
        drawerButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, 
                            bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, 
                            padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 20), 
                            size: CGSize(width: 40, height: 40))
        drawerButton.addTarget(self, action: #selector(didTapOnDrawerButton), for: .touchUpInside)
        
        showPanoramaButton.anchor(top: drawerButton.bottomAnchor, leading: nil, 
                            bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, 
                            padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 20), 
                            size: CGSize(width: 40, height: 40))
        showPanoramaButton.addTarget(self, action: #selector(didTapOnShowPanoramaButton), for: .touchUpInside)
        
        mapController.panoViewIsShown = {[weak self] isShown in
            
            self?.showPanoramaButton.isHidden = isShown
            self?.drawerButton.isHidden = isShown
        }
        
        mapController.currentPlace = viewModel.currentData[0]
        searchController.currentData = viewModel.currentData 
        
        searchController.loadDataForAlert = {[weak self] in
            self?.viewModel.loadDataForAlert()
            self?.searchController.currentData = self?.viewModel.currentData ?? []
        }
        
        searchController.loadDataForEvent = {[weak self] in
            self?.viewModel.loadDataForEvent()
            self?.searchController.currentData = self?.viewModel.currentData ?? []
        }
        
        searchController.loadDataForHealth = {[weak self] in
            self?.viewModel.loadDataForHealth()
            self?.searchController.currentData = self?.viewModel.currentData ?? []
        }
        
        searchController.loadDataForNigeriaFlood = {[weak self] in
            self?.viewModel.loadDataForNigeriaFlood()
            self?.searchController.currentData = self?.viewModel.currentData ?? []
        }
        
        searchController.updateMarker = {[weak self] row in
            self?.mapController.currentPlace = self?.viewModel.currentData[row] 
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showMyViewControllerInACustomizedSheet()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewControllerToPresent.dismiss(animated: false)
    }
    
    func showMyViewControllerInACustomizedSheet() {
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true

            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(viewControllerToPresent, animated: true, completion: {
            self.canShowPresentationSheet = true
        })
    }
    
    //MARK: BUTTON ACTION
    
    @objc func didTapOnDrawerButton() {
        if canShowPresentationSheet {
        }
        showMyViewControllerInACustomizedSheet()

    }
    
    @objc func didTapOnShowPanoramaButton() {
        mapController.currentPlace = viewModel.currentData[0]

        mapController.addPanoramaView()    
       // hideButtonVisibility()
    }
    
    //MARK:  button element visibility
    func hideButtonVisibility() {
        showPanoramaButton.isHidden = true
        showPanoramaButton.isHidden = true
    }

    func showButtonVisibility() {
        showPanoramaButton.isHidden = false
        showPanoramaButton.isHidden = false
    }

}


