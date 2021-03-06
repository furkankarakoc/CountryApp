//
//  DetailCountryViewController.swift
//  CountryApp
//
//  Created by furkankarakoc on 21.05.2022.
//

import UIKit
import MapKit

class DetailCountryViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell)
        return table
    }()

    var country: Countries?
    let sectionTitles = ["Flag", "Currency Unit", "Languages", "Map"]
    
    private var cellHight: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
        
        title = country?.name.common
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
                
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension DetailCountryViewController: UITableViewDelegate, UITableViewDataSource {

    func showLocation(_ mapView: MKMapView, location:CLLocation) {
        let orgLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)

        let dropPin = MKPointAnnotation()
        dropPin.coordinate = orgLocation
        mapView.addAnnotation(dropPin)
        mapView.setRegion(MKCoordinateRegion(center: orgLocation, latitudinalMeters: 500000, longitudinalMeters: 500000), animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(section)
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            
            guard let languages = country?.languages else { return 0 }
            
            return Array(languages).count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)
        
        guard let country = country else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            cellHight = 80
            cell.textLabel?.text = country.flag
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 100)
        } else if indexPath.section == 1 {
            cellHight = 40
            
            let key = country.currencies?.keys.first!
            
            let name = country.currencies?[key!]??["name"]
            let symbol = country.currencies?[key!]??["symbol"]
            
            cell.textLabel?.text = symbol! + " " + name!
        } else if indexPath.section == 2 {
            cellHight = 40
            cell.textLabel?.text = Array(country.languages!)[indexPath.row].value
            
        } else {
            cellHight = 400
            let mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cellHight))
            cell.contentView.addSubview(mapView)
            
            
            let orgLocation = CLLocation(latitude: CLLocationDegrees(country.latlng![0]),
                                         longitude: CLLocationDegrees(country.latlng![1]))
            showLocation(mapView, location: orgLocation)
        }
        
        return cell
    }
}

