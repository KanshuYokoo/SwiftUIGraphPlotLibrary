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
    
    public let frameView:FrameView
    public var plotView:PlotView
    
    public init(dataSet:[PlotData], plotTypes:[GraphPlot], frameSize:CGSize, frameView:FrameView? = nil) {
        self.dataSet = dataSet
        self.grapFrameSize = frameSize
        
        if let frameView = frameView {
            self.frameView = frameView
        } else {
            self.frameView = FrameView()
        }
        
        self.plotView = PlotView(dataSet: dataSet, plotTypes: plotTypes)
    }
    
    public init(dataSet:[PlotData], plotType:GraphPlot, frameSize:CGSize, frameView:FrameView? = nil) {
        self.dataSet = dataSet
        self.grapFrameSize = frameSize
        
        if let frameView = frameView {
            self.frameView = frameView
        } else {
            self.frameView = FrameView()
        }
        self.plotView = PlotView(dataSet: dataSet, plotTypes: [plotType])
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
    let xGridLine:Int
    let yGridLine:Int
    let color:Color
    let type:frameType
    let showGridX:Bool
    let showGridY:Bool
    
    init(showGridX:Bool = true, showGridY:Bool = true, howManyLinesX:Int = 10, howManyLinesY:Int = 10, color:Color = .gray, type:frameType = .normal) {
        self.xGridLine = howManyLinesX
        self.yGridLine = howManyLinesY
        self.color = color
        self.showGridX = showGridX
        self.showGridY = showGridY
        self.type = type
    }
    
    public var body:some View {
        GeometryReader {proxy in
            GraphFrameView(geometryProxy: proxy, x: self.xGridLine, y: self.yGridLine, color: self.color, type:self.type , gridX: self.showGridX, gridY: self.showGridY)
        }
    }
    
    
}

public struct PlotView: View {
    let dataSet:[PlotData]
    let plotSet:[GraphPlot]
    
    public init(dataSet:[PlotData], plotTypes:[GraphPlot]) {
        self.dataSet = dataSet
        self.plotSet = plotTypes
    }
    
    func getGraphPlotView(from plot:GraphPlot, geometryProxy:GeometryProxy) -> GraphPlotView {
        return GraphPlotView(geometryProxy: geometryProxy, type: plot.plotType, dataSet: plot.dataSet ?? self.dataSet, color: plot.color, opacity: plot.opacity, circleRadius: plot.circleRadius, hueDegree: plot.hueDegree, circleRadiusFunc: plot.circleRadiusFunc, colorFunc: plot.colorFunc, hueDegreeFunc: plot.hueDegreeFunc)
    }
    public var body:some View {
        
        GeometryReader {proxy in
            
        return ZStack{
            ForEach(0..<self.plotSet.count) { index in
                self.getGraphPlotView(from: self.plotSet[index], geometryProxy: proxy)
                }
            }
        }
    }
    
}

public struct GraphPlot {
    
    let plotType:PlotType
    var color:Color?
    var dataSet:[PlotData]?
    
    var opacity:Double?
    var circleRadius:CGFloat?
    var hueDegree:Double?
    
    var circleRadiusFunc: RadiusFunc?
    var colorFunc: ColorFunc?
    var hueDegreeFunc: HueDegreeFunc?
    
    public init(type:PlotType,  dataSet:[PlotData]? = nil, color:Color? = nil, opacity:Double? = nil, circleRadius:CGFloat? = nil,  hueDegree:Double? = nil) {
        
        self.plotType = type
        self.dataSet = dataSet
        self.color = color
        self.opacity = opacity
        self.circleRadius = circleRadius
        self.hueDegree = hueDegree
    }

    public func setHueDegreeFunc(function:@escaping HueDegreeFunc) ->  GraphPlot{
        var graphPlot = self
        graphPlot.hueDegreeFunc = function
        return graphPlot
    }
    
    public func setColorFunc(function:@escaping ColorFunc) ->  GraphPlot{
        var graphPlot = self
        graphPlot.colorFunc = function
        return graphPlot
    }
    
    public func setCircleRadiusFunc(function:@escaping RadiusFunc) ->  GraphPlot{
        var graphPlot = self
        graphPlot.circleRadiusFunc = function
        return graphPlot
    }
    
    public func setCircle(color:Color? = nil, radius:CGFloat? = nil, radiusFunc:RadiusFunc? = nil) -> GraphPlot {
        var graphPlot = self
        if let color = color {
            graphPlot.color = color
        }
        if let radius = radius {
            graphPlot.circleRadius = radius
        }
        graphPlot.circleRadiusFunc = radiusFunc
        return graphPlot
    }
    
}


struct GraphView_Previews: PreviewProvider {
    
    static var previews: some View {
        let plotset:[PlotData] = [PlotData(x: 0,y: 0),PlotData(x: 1.0,y: 2.0),PlotData(x: 2.0,y: 3.0),PlotData(x: 3.0,y: 2.0),PlotData(x: 4.0,y: 7.0),PlotData(x: 40.0,y: 20.0)]
        let plotType = GraphPlot(type: .linePlot)
        
        return GraphView(dataSet: plotset,plotType: plotType, frameSize: CGSize(width: 300, height: 200) ).frame(width: 350, height: 250, alignment: .center)
    }
}
