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

struct ContentView : View{
    var body: some View {
        VStack(alignment: .leading){
            GeometryReader { geometry in
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
            }
            Spacer()
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
