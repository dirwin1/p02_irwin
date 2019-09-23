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
var pointsCopy : [Point] = []

struct ContentView : View{
    @State private var points = [Point(id: 0, position: CGPoint(x:0, y: 1)), Point(id: 1, position: CGPoint(x:1, y: 1)), Point(id: 2, position: CGPoint(x:2, y: 2)), Point(id: 3, position: CGPoint(x:3, y: 2)), Point(id: 4, position: CGPoint(x:4, y: 3)), Point(id: 5, position: CGPoint(x:5, y: 1.5))]

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
                    if(self.points.count > 0){
                        //Calculate the scale
                        var xScale : CGFloat = 0
                        var yScale : CGFloat = 0
                        for point in self.points{
                            if(point.position.x > xScale){
                                xScale = point.position.x
                            }
                            if(point.position.y > yScale){
                                yScale = point.position.y
                            }
                        }
                        xScale *= 1.2
                        yScale *= 1.2
                        
                        pointsCopy = self.points
                        
                        for i in pointsCopy.indices {
                            pointsCopy[i].position.x = (pointsCopy[i].position.x / xScale) * geometry.size.width
                            pointsCopy[i].position.y = (1 - (pointsCopy[i].position.y / yScale)) * geometry.size.height
                        }
                        
                        var lastPoint : Point = pointsCopy[0]
                        for point in pointsCopy {
                            //draw point
                            path.move(to: lastPoint.position)
                            path.addLine(to: point.position)

                            lastPoint = point
                        }
                    }
                }
                .stroke(Color.red, style: StrokeStyle(lineWidth: 4, lineCap: .round))

                
                Path { path in
                    var lastPoint : Point = pointsCopy[0]
                    for point in pointsCopy {
                        path.move(to: lastPoint.position)
                        path.addArc(center: lastPoint.position, radius: 5, startAngle: .degrees(0), endAngle: .degrees(361), clockwise: true)
                        lastPoint = point
                        path.closeSubpath()
                    }
                    path.move(to: lastPoint.position)
                    path.addArc(center: lastPoint.position, radius: 5, startAngle: .degrees(0), endAngle: .degrees(361), clockwise: true)
                    path.closeSubpath()
                    
                }
                .fill(Color.red)
            }
            
            

            List {
                ForEach(points){ point in
                    HStack{
                        Text("X: " + point.position.x.description + "    Y: " + point.position.y.description)
                    }
                }.onDelete(perform: delete)
            }
            .navigationBarTitle(Text("Points"))
        }
        .padding()
    }
    
    func delete(at offsets: IndexSet) {
        points.remove(atOffsets: offsets)
    }
}


struct Point: Identifiable {
    let id: Int
    var position: CGPoint
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
