//
//  MapWebView.swift
//  GoogleLiveLocationAwareness
//
//  Created by Dayo Banjo on 10/15/22.
//

import UIKit
import WebKit
import GoogleMaps

class MapViewController: UIViewController{

    lazy var camera = GMSPanoramaCamera(heading: .pi, pitch: 100, zoom: 2)
    var mapView = GMSMapView(frame: UIScreen.main.bounds)   
    var locationManager = CLLocationManager()
    
    let defaultLocationCoordinate = CLLocationCoordinate2D(latitude: 48.858, longitude: 2.294)
    var panoView : GMSPanoramaView?
    var panoViewIsShown : ((Bool)->())?
    let lbl1 = UILabel(frame: CGRect.init(x: 12, y: 18, width: 180, height: 15))
    lazy var lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: 180, height: 15))
    let markerView = UIImageView(image: "😆".image() ?? UIImage())

    var currentPlace : Place? {
        didSet{
            if let place = currentPlace {
                lbl1.text = place.title
                lbl2.text = "\(place.time) \(place.date)"
                markerView.image = place.icon.image() ?? "😆".image()
                mapView.selectedMarker?.tracksInfoWindowChanges = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViews()
    }
    

    // MARK: - Set up Subviews 
    func setUpViews() {
//        GMSServices.provideAPIKey("AIzaSyAGvevR06dHNue-yPyWTQuJVTi47Q23lh8")
               // self.view = panoView
        view.addSubview(mapView)
        mapView.delegate = self
     

        //Location Manager code to fetch current location
        mapView.isMyLocationEnabled = true
        self.locationManager.delegate = self
        self.locationManager.requestLocation()
        self.locationManager.startUpdatingLocation()
       // addPanoramaView()
    }
    
    func addPanoramaView() {
        guard panoView == nil else {
            return
        }
        panoView = GMSPanoramaView(frame: CGRect(origin: .zero, size: CGSize(width: 320, height: 240)))
        
        guard let panoView = panoView, let place = currentPlace else {
            return
        }
        let coord = CLLocationCoordinate2D(latitude: -33.732, longitude: 150.312)
        self.view.addSubview(panoView) 
        panoViewIsShown?(true)
        panoView.moveNearCoordinate(coord)
       // panoView.moveNearCoordinate(CLLocationCoordinate2D(latitude: place.latitiude, longitude: place.longitude))
        panoView.layer.cornerRadius = 12

        panoView.translatesAutoresizingMaskIntoConstraints = false
        panoView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil,
                        padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0),
                        size: CGSize(width: 320, height: 240))
        panoView.clipsToBounds = true
        panoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let cancelButton = UIButton(frame: .zero)
        cancelButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        cancelButton.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.layer.cornerRadius = 20
        cancelButton.clipsToBounds = true
        cancelButton.tintColor = .white
        panoView.addSubview(cancelButton)
        cancelButton.anchor(top: panoView.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: panoView.trailingAnchor,
                            padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10),
                            size: CGSize(width: 40, height: 40))
        cancelButton.addTarget(self, action: #selector(removePanoramaView), for: .touchUpInside)
    }
    
    @objc func removePanoramaView() {
        panoViewIsShown?(false)
        panoView?.removeFromSuperview()
        panoView = nil
    }

    func showCurrentLocationOnMap(){
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        let camera = GMSCameraPosition.camera(withLatitude: 11.11, longitude: 12.12, zoom: 14.0) //Set default lat and long
      
//        for data in nearByPlacesArray!{
//            
//            let location = CLLocationCoordinate2D(latitude: data.latitude!, longitude: data.longitude!)
//            print("location: \(location)")
//            let marker = GMSMarker()
//            marker.position = location
//            marker.snippet = data.name!
//            marker.map = mapView
//        }
    }
    
  
}


extension MapViewController : GMSPanoramaViewDelegate {
    
}

extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude ), longitude: (location.coordinate.longitude ), zoom: 17.0)
            self.mapView.animate(to: camera)
            
            let marker = GMSMarker()
            
            marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            marker.layer.cornerRadius = 10
            marker.layer.masksToBounds = false
           // marker.layer.masksToBounds = true
            
            
            marker.iconView = markerView
            marker.title = "New Delhi"
            marker.snippet = "India"
            marker.map = mapView
            marker.isTappable = true
            //comment this line if you don't wish to put a callout bubble
            mapView.selectedMarker = marker
        }
       
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
 
}

extension MapViewController: GMSMapViewDelegate{
    /* handles Info Window tap */
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf")
    }
    
    /* handles Info Window long press */
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("didLongPressInfoWindowOf")
    }
    
    /* set a custom Info Window */
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        view.layer.cornerRadius = 6
        view.clipsToBounds = true        
       // visualEffect.fillSuperview()
        view.backgroundColor = .black.withAlphaComponent(0.3)

        
        lbl1.text = "Hi there!"
        view.addSubview(lbl1)
        lbl1.textColor = .black
        lbl1.font = UIFont.systemFont(ofSize: 14, weight: .bold)
       
        lbl2.text = "14: 00 PM, 12/09/45"
        lbl2.textColor = .black
        lbl2.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.addSubview(lbl2)
        // 4
        
        
        return view
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
        //Your custom logic to move to another VC
        print("tapping")
        return true
    }
}
