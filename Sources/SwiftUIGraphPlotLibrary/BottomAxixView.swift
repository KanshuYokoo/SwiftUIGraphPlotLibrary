//
//  BottomAxisView.swift
//  cool1
//
//  Created by 観周 横尾 on 15/04/2020.
//  Copyright © 2020 midleemaster. All rights reserved.
//

import SwiftUI

public struct BottomAxisView: View {
    let dataSet:[PlotData]
    let length:CGFloat
    var counter:Int = 5
    var format:String = "%.1f"
    var xAxsisScaleParameter : CGFloat = 1.0
        
    var max:CGFloat {
        dataSet.max(\.x) ?? length
    }
    var min:CGFloat {
        dataSet.min(\.x) ?? 0.0
    }
      
    var dx :CGFloat {
        return (max - min) / CGFloat(counter)
    }

    var offSetDx:CGFloat {
        return length / CGFloat(counter) * xAxsisScaleParameter
    }
      
    func culcOffsetX(_ index: Int) -> CGFloat {
        return  offSetDx * CGFloat(index) - length * 0.5
    }
      
    func label(at index:Int) -> String {
        let num = min + dx *  CGFloat(index)
        return String(format:self.format, num)
    }
    
    public var body: some View{
        ZStack(alignment: .top){
            ForEach(Array(0...counter ), id: \.self) { index in
                XAxixNumbers(text:label(at: index), offsetX: culcOffsetX(index))
            }
        }.frame(width : length)
    }
}

struct XAxixNumbers:View {
    let text:String
    let offsetX:CGFloat
    
    var body: some View{
        Text(self.text)
            .font(.footnote)
            .fontWeight(.thin)
            .frame(alignment: .leading)
            .offset( x: offsetX)
    }
}

struct BottomAxisView_Previews: PreviewProvider {
     
    static var previews: some View {
        let plotset:[PlotData] = [PlotData(x: 0,y: 0),PlotData(x: 1.0,y: 2.0),PlotData(x: 2.0,y: 3.0),PlotData(x: 3.0,y: 2.0),PlotData(x: 4.0,y: 7.0),PlotData(x: 40.0,y: 20.0)]
        return BottomAxisView(dataSet: plotset, length: 300, xAxsisScaleParameter: 0.9)
    }
}

