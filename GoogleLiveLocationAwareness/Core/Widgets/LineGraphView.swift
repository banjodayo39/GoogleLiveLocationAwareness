//
//  LineGraphView.swift
//  GoogleLiveLocationAwareness
//
//  Created by Dayo Banjo on 11/8/22.
//


import SwiftUI

import UIKit

struct ProgressItemModel {
    
    var name : String = ""
    var progressValue : Double = 0
}

class GraphDelegate : ObservableObject{
    
    @Published var chartData = [ProgressItemModel]()
    
}

struct LineGraphView : View{
    @State var period =  [Double]()
    @State var months = [String]()
    @State var periods : [Double] = [10, 20, 30, 40, 50]
    var delegate = GraphDelegate()
    
    var body: some View{
        VStack{
            HStack{
                VStack{
                    
                    Text(" LAST 28 DAYS")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                }
                
                
                Spacer()
            }.padding(.leading, 16)
                .padding(.top, 16)
            
            HStack{
                VStack{
                    ForEach(periods, id: \.self) { num in
                        Text("\(Int(num))")
                            .font(.title)
                            .foregroundColor(Color.gray.opacity(0.4))
                            .padding(.top, 14)
                    }
                }
                VStack{
                    GeometryReader{ geometry in
                        ZStack{
                            GeometryReader{ geometry in
                                Line(data: ChartData(points: period), frame: .constant(geometry.frame(in: .local)), touchLocation: .constant(CGPoint(x: 100, y: 12)), showIndicator: .constant(true), minDataValue: .constant(nil), maxDataValue: .constant(nil), lineColor: .constant(GradientColor(start: .pink, end: .purple)), bodyColor: .constant([Color.blue.opacity(0.28), Color.white.opacity(0.01)]))
                            }.frame(width: 300, height: 160)
                            
                        }
                    }.frame(width: 300, height: 160)
                    
                    HStack(spacing: 10){
                        ForEach(months, id: \.self) { num in
                            Text("\(num)")
                                .fontWeight(.medium)
                                .foregroundColor(Color.gray.opacity(0.4))
                                .padding(.leading, 10)
                            
                        }
                    }.frame(width: 300, height: 30)
                }
                
            }
            .onReceive(delegate.$chartData, perform: { value in
                months = value.count > 4 ? value[0...3].map{
                    Date().getMonth(date: $0.name)
                } : value.map{
                    Date().getMonth(date: $0.name)
                }
                
                
                period = value.count > 4 ?  value[0...3].map{
                    $0.progressValue
                }: value.map{
                    $0.progressValue
                }
            })
            
            Spacer(minLength: 95)
        }.background(Color.black)
    }
}


struct LineGraph_Previews: PreviewProvider {
    static var previews: some View {
        LineGraphView()
    }
}
 
