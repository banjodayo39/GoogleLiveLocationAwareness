//
//  ActivityDetailViewController.swift
//  GoogleLiveLocationAwareness
//
//  Created by Dayo Banjo on 11/7/22.
//

import UIKit
import SwiftUI

class ActivityDetailViewController: UIViewController {
    
    var place : Place?
    var type = 0
    
    let titleLabel  =  UILabel(frame: .zero)
    let locationLabel  =  UILabel(frame: .zero)
    let descriptionLabel  =  UILabel(frame: .zero)
    var graphDelegate = GraphDelegate()

    
    lazy var thumbnailImageView = UIImageView(image: UIImage(named: place?.thumbnail ?? ""))

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubView()
        // Do any additional setup after loading the view.
        switch type{
            case 0 :
                setUpViewEventForAlert()
                break
            case 1:
                setUpViewForEvent()
                break
            case 2:
                setUpViewEventForAlert()
                break
            default:
                break
        }
        fetchChartData()

    }
    
    func initSubView() {
        guard let place = place else {
            return 
        }
        view.backgroundColor = .black
        thumbnailImageView.reSize(size: CGSize(width: 200, height: 200))
        
        view.addSubviews(thumbnailImageView,locationLabel,  descriptionLabel, titleLabel) 
        titleLabel.textColor = .white.withAlphaComponent(0.6)
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        titleLabel.text = place.title
        
        locationLabel.textColor = .white
        locationLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        locationLabel.text = place.description
        
        thumbnailImageView.layer.cornerRadius = 4
        thumbnailImageView.clipsToBounds = true
        
        thumbnailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        thumbnailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true  
   
    }

    func setUpViewForEvent() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 16, bottom: 16, right: 16)) 
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.text = place?.information
        
        let dummytext = " The holiday is celebrated annually by the government of Nigeria. The festivities begin with the President's address to the people, which is broadcast on radio and television.[6] There are also celebrations across all sectors in Nigeria, including the Nigerian Armed Forces, the Nigeria Police Force, the Ministry of Foreign Affairs, the workforce and national education services. For instance, the primary and secondary schools perform a ceremonial marchpast in various state capitals and local government areas where they are located.[7] The streets are filled with celebrations as individuals and groups troupe to the streets wearing green-white-green.[8] Offices and markets are closed in Nigeria on 1 October."
        
        let confettiView = SwiftConfettiView(frame: self.view.bounds)
        view.addSubviews(confettiView)
        confettiView.type = .confetti
        confettiView.colors = [UIColor.red, UIColor.green, UIColor.blue]
        confettiView.intensity = 0.9

        confettiView.startConfetti()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { 
            confettiView.stopConfetti()
        }
    }
    
    func setUpViewEventForAlert() {
        var chartView = LineGraphView()
        lazy var menuViewController = UIHostingController(rootView: chartView)
        chartView.delegate = graphDelegate
        
        add(menuViewController)
        menuViewController.didMove(toParent: self)
        view.addSubviews(menuViewController.view)
        
        menuViewController.view.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 16, bottom: 16, right: 16)) 
        menuViewController.view.backgroundColor = .black
        menuViewController.view.heightAnchor.constraint(equalToConstant: 800).isActive = true
        menuViewController.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    func setUpViewForHealth() {
        
    }
    
    
    func fetchChartData() {
        graphDelegate.chartData = [ProgressItemModel(name: "12-03-94", progressValue: 0.64),
                                   ProgressItemModel(name: "12-03-95", progressValue: 0.35),
                                   ProgressItemModel(name: "12-0304", progressValue: 0.6),
                                   ProgressItemModel(name: "12-03-04", progressValue: 0.42),
                                   ProgressItemModel(name: "12-03-04", progressValue: 0.33)]
    }
    
  

}
