//
//  HomeViewModel .swift
//  GoogleLiveLocationAwareness
//
//  Created by Dayo Banjo on 10/29/22.
//

import Foundation

class HomeViewModel {
    
    var currentData = [Place]()
    
    init() {
        currentData = eventDataSource
    }
    
     let eventDataSource  = [
            Place(title: "Election Day", description: "War Memorial Park", thumbnail: "f1",
                  time: "04: 56 PM", date: "11/11/2012", icon: "🇺🇸", type: .event, latitiude: 34.748535, longitude: -92.330319, information: " Go Vote 🇺🇸. Midterm election for key Senate, House and state races"),
            Place(title: "Veterans day", description: "War memorial Stadium", thumbnail: "f2",
                  time: "04: 56 PM", date: "11/11/2012", icon: "🥳", type: .event,latitiude: 34.749972, longitude: -92.330072, information: ""),
        ]
    
    
    let alertDataSource  = [
        Place(title: "Amber Alert", description: "War memorial Stadium", thumbnail: "f1",
              time: "04: 56 PM", date: "09/10/2012", icon: "🔔", type: .alert, latitiude: 34.749972, longitude: -92.330072, information: "A young man is missing"),
        Place(title: "Camo Alert", description: "Stadium Drive", thumbnail: "f2",
              time: "04: 56 PM", date: "09/10/2012", icon: "🚨", type: .alert,latitiude: 34.750745, longitude: -92.329057, information: "A missing armed forces with mental illness"),
        Place(title: "Wireless Emergency"  , description: "War Memorial Park", thumbnail: "f3",
              time: "04: 56 PM", date: "09/10/2012", icon: "‼️", type: .alert,latitiude: 34.748535, longitude: -92.330319, information: ""),
        Place(title: "UV Alert", description: "Jim Dailey Fitness", thumbnail: "f4",
              time: "04: 56 PM", date: "09/10/2012", icon: "☀️", type: .alert,latitiude: 34.747785, longitude: -92.329041, information: "UV Index above 6, protect oneself from the sun's UV radiation."),
    ]
    
    let healthDataSource  = [
        Place(title: "Covid 19", description: "War memorial Stadium", thumbnail: "f1",
              time: "04: 56 PM", date: "09/10/2012", icon: "⛑️", type: .health, latitiude: 34.749972, longitude: -92.330072, information: "COVID-19 is caused by a coronavirus called SARS-CoV-2"),
    ]
    
    
    let nigEventDataSource  = [
        Place(title: "Independent day", description: "Ikorodu, Lagos", thumbnail: "f1",
              time: "04: 56 PM", date: "10/01/2012", icon: "🇳🇬", type: .health, latitiude: 6.6194, longitude: 3.5105, information: "COVID-19 is caused by a coronavirus called SARS-CoV-2"),
    ]
    
    let nigAlertDataSource  = [
        Place(title: "Flood Alert", description: "Ikorodu, Lagos", thumbnail: "f1",
              time: "04: 56 PM", date: "09/10/2012", icon: "🌊", type: .health, latitiude: 6.6194, longitude: 3.5105, information: "The 2022 Nigeria floods have affected many parts of the country. Nigeria is suffering its worst flooding in a decade, with vast areas of farmland, infrastructure and 200,000 homes partly or wholly destroyed."),
    ]
    
    func loadDataForEvent() {
        currentData = eventDataSource
    }
    
    func loadDataForAlert() {
        currentData = alertDataSource
    }
    
    func loadDataForHealth() {
        currentData = healthDataSource
    }
    
    func loadDataForNigeriaFlood() {
        currentData = nigAlertDataSource
    }
    
}
