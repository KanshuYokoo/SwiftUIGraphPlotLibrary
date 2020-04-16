//
//  GraphView.swift
//  cool1
//
//  Created by 観周 横尾 on 11/04/2020.
//  Copyright © 2020 midleemaster. All rights reserved.
//

import SwiftUI

public struct GraphView: View {
    let grapFrameSize:CGSize
    let dataSet:[PlotData]
    let viewSet:[GraphPlotView]?
    public let frameView:FrameView
    public let plotView:PlotView
    
    public init(dataSet:[PlotData], plotViews:[GraphPlotView]? = nil, frameSize:CGSize) {
        self.dataSet = dataSet
        self.grapFrameSize = frameSize
        self.viewSet = plotViews
        
        self.plotView = PlotView(dataSet: dataSet)
        self.frameView = FrameView()
        
    }

    var graphWidth:CGFloat {
        self.grapFrameSize.width
    }
    var graphHeight:CGFloat {
        self.grapFrameSize.height
    }
    public var body: some View {
        VStack(alignment: .trailing, spacing: 5.0) {
            HStack {
                //asix label
                LeadingAxisView(dataSet: self.dataSet, height: self.graphHeight)
                //graph
                ZStack{
                    self.frameView
                    self.plotView
                }.frame(width: self.graphWidth, height: self.graphHeight, alignment: .center)
                
            }
            
            //bottom
            HStack {
                Spacer()
                BottomAxisView(dataSet: self.dataSet, lendth: self.graphWidth).frame(width: self.graphWidth)
            }
        }
        
        
    }
}

public struct FrameView:View {
    
    init(x:Int = 10, y:Int = 10, color:Color = .gray, type:frameType = .normal,gridX:Bool = true, gridY:Bool = true) {
        //todo
    }
    
    public var body:some View {
        GeometryReader {proxy in
            GraphFrameView(geometryProxy:proxy)
        }
    }
    
    
}

public struct PlotView: View {
    let dataSet:[PlotData]
    let viewSet:[GraphPlotView]?
    
    init(dataSet:[PlotData], plotViews:[GraphPlotView]? = nil) {
        self.dataSet = dataSet
        self.viewSet = plotViews
    }
    public var body:some View {
        GeometryReader {proxy in
            
        return ZStack{
            //GraphFrameView(geometryProxy:proxy)
            
            GraphPlotView(type:.linePlot, geometryProxy: proxy, dataSet: self.dataSet)
            
            GraphPlotView(type:.circlePlot, geometryProxy: proxy, dataSet: self.dataSet)
            
            GraphPlotView(type:.verticalBar, geometryProxy: proxy, dataSet: self.dataSet)
            }
        }
    }
    

}

struct GraphView_Previews: PreviewProvider {
    
    static var previews: some View {
        let plotset:[PlotData] = [PlotData(x: 0,y: 0),PlotData(x: 1.0,y: 2.0),PlotData(x: 2.0,y: 3.0),PlotData(x: 3.0,y: 2.0),PlotData(x: 4.0,y: 7.0),PlotData(x: 40.0,y: 20.0)]
        
        
        return GraphView(dataSet: plotset, frameSize: CGSize(width: 300, height: 200) ).frame(width: 350, height: 250, alignment: .center)
    }
}

