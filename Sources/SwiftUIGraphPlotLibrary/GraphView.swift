//
//  GraphView.swift
//  cool1
//
//  Created by 観周 横尾 on 11/04/2020.
//  Copyright © 2020 midleemaster. All rights reserved.
//

import SwiftUI

public struct GraphView: View {
    let dataSet:[PlotData]
    let plotTypes:[GraphPlot]
    let frameSize:CGSize
    
    let xTicks:Bool
    let yTicks:Bool
    
    public var frameView:FrameView

    var xPlotAreaFactor:CGFloat = 1.0
    
    var graphWidth:CGFloat {
        return frameSize.width
    }
    var graphHeight:CGFloat {
        return  frameSize.height
    }
    
    public var xTicksView:BottomAxisView {
        return BottomAxisView(dataSet: dataSet, length: frameSize.width, xAxsisScaleParameter: min(self.xPlotAreaFactor,1.0))
    }
    
    public var yTicksView:LeadingAxisView {
        return LeadingAxisView(dataSet: dataSet, height: frameSize.height)
    }
    
    public var body: some View {
        VStack(alignment: .trailing, spacing: 5.0) {
            HStack {
                //asix label
                self.yTicks ? self.yTicksView:nil
                GeometryReader {proxy in
                //graph
                    ZStack{
                        self.frameView
                        PlotView(dataSet: self.dataSet, plotTypes: self.plotTypes, geometryproxy: proxy, xPlotAreaFactor: min(self.xPlotAreaFactor,1.0))
                        }
                }.frame(width: self.graphWidth, height: self.graphHeight, alignment: .center)
                
            }
            //bottom
            self.xTicks ? xTicksView.frame(width: self.graphWidth):nil
            
        }
    }
}

//MARK: Init
extension GraphView {
    public init(dataSet:[PlotData], plotTypes:[GraphPlot], frameSize:CGSize, frameView:FrameView? = nil, xTicks:Bool = false, yTicks:Bool = false, xPlotAreaFactor:CGFloat = 1.0) {
        
        self.frameSize = frameSize
        
        if let frameView = frameView {
            self.frameView = frameView
        } else {
            self.frameView = FrameView()
        }
                        
        self.dataSet = dataSet
        self.plotTypes = plotTypes
        
        self.xTicks = xTicks
        self.yTicks = yTicks
        
        self.xPlotAreaFactor = xPlotAreaFactor
    }
    
    public init(dataSet:[PlotData], plotType:GraphPlot, frameSize:CGSize, frameView:FrameView? = nil, xTicks:Bool = false, yTicks:Bool = false, xPlotAreaFactor:CGFloat = 1.0) {
        
        self.init(dataSet: dataSet, plotTypes: [plotType], frameSize: frameSize, frameView: frameView, xTicks:xTicks, yTicks:yTicks, xPlotAreaFactor:xPlotAreaFactor)
    }
    
    public init<T1:Numeric,T2:Numeric>(xArray:[T1],yArray:[T2], plotType:GraphPlot, frameSize:CGSize, frameView:FrameView? = nil, xTicks:Bool = false, yTicks:Bool = false, xPlotAreaFactor:CGFloat = 1.0) {
        
        var dataSet:[PlotData]
        do {
            dataSet = try convertArrayToPlotData(xarray: xArray, yarray: yArray)
        } catch {
            dataSet = []
            //todo
            //show better error message
            print("Error : \(error)")
        }
        self.init(dataSet: dataSet, plotTypes: [plotType], frameSize: frameSize, frameView: frameView, xTicks:xTicks, yTicks:yTicks, xPlotAreaFactor:xPlotAreaFactor)
    }

}

public struct FrameView:View {
    
    let showGridX:Bool = true
    let showGridY:Bool = true
    let howManyLinesX:Int = 10
    let howManyLinesY:Int = 10
    let color:Color = .gray
    let type:frameType = .normal
    
    public var body:some View {
        GeometryReader {proxy in
            GraphFrameView(geometryProxy: proxy, x: self.howManyLinesX, y: self.howManyLinesY, color: self.color, type:self.type , gridX: self.showGridX, gridY: self.showGridY)
        }
    }
    
}

public struct PlotView: View {
    let dataSet:[PlotData]
    let plotTypes:[GraphPlot]
    let geometryproxy: GeometryProxy
    let xPlotAreaFactor:CGFloat
        
    public var body:some View {
        return
            ZStack {
                    ForEach(0..<self.plotTypes.count) { index in
                        let plot = self.plotTypes[index]
                        GraphPlotView(geometryProxy: geometryproxy, type: plot.plotType, dataSet: plot.dataSet ?? self.dataSet, color: plot.color, opacity: plot.opacity, circleRadius: plot.circleRadius, hueDegree: plot.hueDegree, circleRadiusFunc: plot.circleRadiusFunc, colorFunc: plot.colorFunc, hueDegreeFunc: plot.hueDegreeFunc, xPlotAreaFactor: self.xPlotAreaFactor )
                        
                        }
                }
        
    }
}

public struct GraphPlot {
    
    var type:PlotType
    var dataSet:[PlotData]?
    var color:Color

    var opacity:Double
    var circleRadius:CGFloat
    var hueDegree:Double
    
    var circleRadiusFunc: RadiusFunc?
    var colorFunc: ColorFunc?
    var hueDegreeFunc: HueDegreeFunc?
        
    var plotType:PlotType {
        return type
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

extension GraphPlot {
    public init(type:PlotType,  dataSet:[PlotData]? = nil, color:Color = Color.defaultColor, opacity:Double = 1.0, circleRadius:CGFloat = 10,  hueDegree:Double = 0) {
        
        self.type = type
        self.dataSet = dataSet
        self.color = color
        self.opacity = opacity
        self.circleRadius = circleRadius
        self.hueDegree = hueDegree
    }
}


struct GraphView_Previews: PreviewProvider {
    
    static var previews: some View {
        let plotset:[PlotData] = [PlotData(x: 0,y: 0),PlotData(x: 1.0,y: 2.0),PlotData(x: 2.0,y: 3.0),PlotData(x: 3.0,y: 2.0),PlotData(x: 4.0,y: 7.0),PlotData(x: 40.0,y: 20.0)]
        let plotType = GraphPlot(type: .linePlot)
        
        return GraphView(dataSet: plotset,plotType: plotType, frameSize: CGSize(width: 300, height: 200), xTicks: true, yTicks: true).padding()
    }
}

