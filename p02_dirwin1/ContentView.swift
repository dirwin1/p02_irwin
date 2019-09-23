//
//  ContentView.swift
//  p02_dirwin1
//
//  Created by Dylan Irwin on 9/11/19.
//  Copyright © 2019 Dylan Irwin. All rights reserved.
//

import SwiftUI

var numVerticalLines: Int = 25
var numHorizontalLines: Int = 25
var points : [CGPoint] = [CGPoint(x:0, y:1), CGPoint(x:1, y:1), CGPoint(x:2, y:2), CGPoint(x:3, y:2), CGPoint(x:4, y:3), CGPoint(x:5, y:1.5)]
var pointsCopy : [CGPoint] = []
var points2 : [Point] = [Point(id: 0, position: CGPoint(x:0, y: 1))]

struct ContentView : View{
    var body: some View {
        VStack(alignment: .leading){
            GeometryReader { geometry in
                //grid
                Path { path in
                    let horizontalSpacing = geometry.size.width / CGFloat(numHorizontalLines)
                    let verticalSpacing = geometry.size.height / CGFloat(numVerticalLines)
                    for index in 0...numVerticalLines {
                        let vOffset: CGFloat = CGFloat(index) * horizontalSpacing
                        path.move(to: CGPoint(x: vOffset, y: 0))
                        path.addLine(to: CGPoint(x: vOffset, y: geometry.size.height))
                    }
                    for index in 0...numHorizontalLines {
                        let hOffset: CGFloat = CGFloat(index) * verticalSpacing
                        path.move(to: CGPoint(x: 0, y: hOffset))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: hOffset))
                    }
                }
                .stroke(Color.gray, lineWidth: 0.5)
                //Axis
                Path{ path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x:0, y:geometry.size.height))
                    path.move(to: CGPoint(x: 0, y:geometry.size.height))
                    path.addLine(to: CGPoint(x:geometry.size.width, y: geometry.size.height))
                }
                .stroke(Color.black, lineWidth: 1)
                
                //Add points
                Path{ path in
                    //Calculate the scale
                    var xScale : CGFloat = 0
                    var yScale : CGFloat = 0
                    for point in points{
                        if(point.x > xScale){
                            xScale = point.x
                        }
                        if(point.y > yScale){
                            yScale = point.y
                        }
                    }
                    xScale *= 1.2
                    yScale *= 1.2
                    
                    pointsCopy = points
                    
                    for i in pointsCopy.indices {
                        pointsCopy[i].x = (pointsCopy[i].x / xScale) * geometry.size.width
                        pointsCopy[i].y = (1 - (pointsCopy[i].y / yScale)) * geometry.size.height
                    }
                    
                    var lastPoint : CGPoint = pointsCopy[0]
                    for point in pointsCopy {
                        //draw point
                        //draw point
                        path.move(to: lastPoint)
                        path.addLine(to: point)

                        lastPoint = point
                    }
                }
                .stroke(Color.red, style: StrokeStyle(lineWidth: 4, lineCap: .round))

                
                Path { path in
                    var lastPoint : CGPoint = pointsCopy[0]
                    for point in pointsCopy {
                        path.move(to: lastPoint)
                        path.addArc(center: lastPoint, radius: 5, startAngle: .degrees(0), endAngle: .degrees(361), clockwise: true)
                        lastPoint = point
                        path.closeSubpath()
                    }
                    path.move(to: lastPoint)
                    path.addArc(center: lastPoint, radius: 5, startAngle: .degrees(0), endAngle: .degrees(361), clockwise: true)
                    path.closeSubpath()
                    
                }
                //.stroke(Color.blue, lineWidth: 2)
                .fill(Color.red)
                
                
                //var counter : Int = 0
                //ForEach((1...10), id: \.self) {
                    //Path{ path in
                    //    path.addArc(center: points[0], radius: 10, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
                    //}
                    //.stroke(Color.blue, linewidth: 2)
                    //counter++
                //}
            }
            
            

            List(points2) { point in
                Text("hallo")
            }
        }
        .padding()
    }
}

struct Point: Identifiable {
    let id: Int
    let position: CGPoint
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
