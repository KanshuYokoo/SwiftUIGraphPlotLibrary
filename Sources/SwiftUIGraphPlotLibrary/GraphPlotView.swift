//
//  GraphPlotView.swift
//  cool1
//
//  Created by 観周 横尾 on 01/04/2020.
//  Copyright © 2020 midleemaster. All rights reserved.
//

import SwiftUI

public enum PlotType {
    case linePlot
    case circlePlot
    case verticalBar
}

public typealias RadiusFunc = (Int) -> CGFloat
public typealias ColorFunc = (Int) -> Color
public typealias HueDegreeFunc = (Int) -> Double

public struct GraphPlotView:View {
        
    var geometryProxy:GeometryProxy
    var type:PlotType
    let dataSet:[PlotData]
    var color:Color = Color.defaultColor
    var opacity:Double = 1.0
    var circleRadius:CGFloat = 10
    var hueDegree:Double = 0.0
    
    var circleRadiusFunc: RadiusFunc?
    var colorFunc: ColorFunc?
    var hueDegreeFunc: HueDegreeFunc?
    
    var xPlotAreaFactor: CGFloat = 1.0
    
    let minX:CGFloat,maxX:CGFloat,minY:CGFloat,maxY:CGFloat
   
    var xAxisL:CGFloat {
        return maxX - minX > 0 ? maxX - minX :1
    }
    var yAxisL:CGFloat {
        return maxY - minY > 0 ?  maxY - minY : 1
    }
    var totalPlot:Int {
        return dataSet.count
    }
    ///
    // The edge of x-axis on geometry reader frame
    var xAxisRangeOnGeometry:CGFloat {
        return geometryProxy.size.width * xPlotAreaFactor
    }
    
    var xratio:CGFloat {
        return  xAxisRangeOnGeometry / xAxisL
    }
    
    var yratio:CGFloat {
        return geometryProxy.size.height / yAxisL
    }
    
    func transfarCorodinate(point:PlotData) -> PlotData {
        let ytransformed = geometryProxy.size.height - point.y * yratio + minY * yratio
        let xtrasformed = point.x * xratio
        return PlotData(x: xtrasformed, y: ytransformed )
    }
    
    var plotDataSet:[PlotData] {
        return dataSet.map {
            transfarCorodinate(point: $0)
        }
    }
    
    func getHueDegree(_ index: Int) -> Double {
           if let hueDegreeFunc = hueDegreeFunc {
               return hueDegreeFunc(index)
           } else {
               return hueDegree
           }
       }
    
    //todo decommission
    public func setHueDegreeFunc(function:HueDegreeFunc?) ->  GraphPlotView{
        var graphPlotView = self
        graphPlotView.hueDegreeFunc = function
        return graphPlotView
    }
        
    func getColor(_ index: Int) -> Color {
        if let colorFunc = colorFunc {
            return colorFunc(index)
        } else {
            return color
        }
    }
    
    public var body: some View {
        
        ZStack {
            if (type == .linePlot) {
                linePlot()
            }
            if (type == .circlePlot) {
                circlePlot()
            }
            if type == .verticalBar {
                verticalBar()
            }
        }
       
    }
}

//MARK: Init
extension GraphPlotView {
    public init(geometryProxy: GeometryProxy, type: PlotType, dataSet: [PlotData], color: Color = Color.defaultColor, opacity: Double = 1.0, circleRadius: CGFloat = 10, hueDegree: Double = 0.0, circleRadiusFunc: RadiusFunc? = nil, colorFunc: ColorFunc? = nil, hueDegreeFunc: HueDegreeFunc? = nil, xPlotAreaFactor: CGFloat = 1.0) {
        self.geometryProxy = geometryProxy
        self.type = type
        self.dataSet = dataSet
        self.color = color
        self.opacity = opacity
        self.circleRadius = circleRadius
        self.hueDegree = hueDegree
        self.circleRadiusFunc = circleRadiusFunc
        self.colorFunc = colorFunc
        self.hueDegreeFunc = hueDegreeFunc
        self.xPlotAreaFactor = xPlotAreaFactor
        
        self.minX = dataSet.map {$0.x}.min() ?? 0.0
        self.maxX = dataSet.map {$0.x}.max() ?? 1.0
        self.minY = dataSet.map {$0.y}.min() ?? 0.0
        self.maxY = dataSet.map {$0.y}.max() ?? 1.0
    }
}

//MARK: linePlot
extension GraphPlotView {
    func linePlot() -> some View {
        Path{ path in
            for (index,point) in plotDataSet.enumerated() {
                if index == 0 {
                    path.move(to: CGPoint(x: point.x, y: point.y))
                } else {
                    path.addLine(to: CGPoint(x: point.x, y: point.y))
                }
            }
            
        }.stroke(self.color)
    }
}

//MARK: circlePlot
extension GraphPlotView {
    func transfarCircleOffset(point:PlotData) -> PlotData {
        let yOffset = geometryProxy.size.height * 0.5 - point.y * yratio + minY * yratio
        let xOffset = point.x * xratio - geometryProxy.size.width * 0.5
        - minX * xratio
        return PlotData(x: xOffset, y: yOffset)
    }
    
    var circlePlotDataSet:[PlotData] {
        return dataSet.map {
            transfarCircleOffset(point: $0)
        }
    }
    
    func getCirclePlotRadius(_ index: Int) -> CGFloat {
        if let funcRadius = circleRadiusFunc {
            return funcRadius(index)
        } else {
            return circleRadius
        }
    }
    
    func circlePlot() ->  some View {
        let transferedData = circlePlotDataSet
        return ZStack() {
        ForEach(0..<totalPlot) { index in
            Circle()
            .fill(getColor(index))
            .hueRotation(Angle(degrees: getHueDegree(index)))
               .blendMode(BlendMode.multiply)
               .frame(width: getCirclePlotRadius(index), height: getCirclePlotRadius(index))
               .offset(x: transferedData[index].x , y: transferedData[index].y)
              }
          }
    }
    
    //decommssion
   public func setCircle(color:Color? = nil, radius:CGFloat? = nil, radiusFunc:RadiusFunc? = nil) -> GraphPlotView {
        var graphView = self
        if let color = color {
            graphView.color = color
        }
        if let radius = radius {
            graphView.circleRadius = radius
        }
        graphView.circleRadiusFunc = radiusFunc
        return graphView
    }
}

//MARK: barChart
extension GraphPlotView {
    
    func transfarVerticalBarOffset(point:PlotData) -> PlotData {
        let yOffset = self.geometryProxy.size.height * 0.5 - point.y * yratio * 0.5 + minY * yratio * 0.5
        let xOffset = point.x * xratio
            - minX * xratio
            - self.geometryProxy.size.width * 0.5 + barWidthX * 0.5
        return PlotData(x: xOffset, y: yOffset)
    }
    
    var verticalBarDataOffSet:[PlotData] {
        return dataSet.map {
            transfarVerticalBarOffset(point: $0)
        }
    }
    
    func transfarVerticalBarHeight(point:PlotData) -> CGFloat {
        return point.y * yratio - minY * yratio
    }
    
    var verticalBarDataPLot:[CGFloat] {
        return dataSet.map {
            transfarVerticalBarHeight(point: $0)
        }
    }
    
    func verticalBar() ->  some View {
        ZStack() {
            let verticalBarData = verticalBarDataOffSet
            let BarHeightData = verticalBarDataPLot
            let width = barWidthX
            
            ForEach(0..<totalPlot) {
                index in
                ProgressBar(height: BarHeightData[index], width: width, hueDegree: getHueDegree(index), opacity: opacity, color: getColor(index))
                    .offset(x:verticalBarData[index].x , y: verticalBarData[index].y)
            }
            
        }
    }

    var barWidthX:CGFloat {
        return culcBarWidth()*0.8
    }
    
    func culcBarWidth() -> CGFloat {
        let defaultMinWidth:CGFloat = 1.5
        let sortedPoints = plotDataSet.sorted(by: \.x).map(\.x)
        
        var minWidth:CGFloat = 0
        for index in 1..<totalPlot {
            let dx = sortedPoints[index] - sortedPoints[index - 1]
            if index == 1 { minWidth = dx }
            if minWidth > dx {
                minWidth = dx
            }
        }
        return max(minWidth, defaultMinWidth)
    }
    
    public func setBarPlot(opacity:Double? = nil, hueDegree:Double? = 0.0) -> GraphPlotView {
        var graphView = self
        if let opacity = opacity {
            graphView.opacity = opacity
        }
        if let hueDegree = hueDegree {
            graphView.hueDegree = hueDegree
        }
        return graphView
    }
}

//MARK:preview
struct GraphPlotView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let plotset:[PlotData] = [PlotData(x: 0,y: 0),PlotData(x: 1.0,y: 2.0),PlotData(x: 2.0,y: 3.0),PlotData(x: 3.0,y: 2.0),PlotData(x: 4.0,y: 7.0),PlotData(x: 40.0,y: 20.0)]
        
        let plotset2:[PlotData] = [PlotData(x: 1.0,y: 2.0),PlotData(x: 2.0,y: 3.0),PlotData(x: 3.0,y: 2.0),PlotData(x: 4.0,y: 8.0),PlotData(x: 5.0,y: 30.0),PlotData(x: 6.0,y: 25.0),PlotData(x: 7.0,y: 24.0),PlotData(x: 8.0,y: 23.0),PlotData(x: 9.0,y: 22.0),PlotData(x: 9.6,y: 21.0)]
        
        return Group {
            GeometryReader {proxy in
            ZStack{
                GraphFrameView(geometryProxy:proxy)
                GraphPlotView(geometryProxy: proxy, type:.linePlot, dataSet: plotset)
                
                GraphPlotView(geometryProxy: proxy, type:.circlePlot, dataSet: plotset)
                
                GraphPlotView(geometryProxy: proxy, type:.verticalBar, dataSet: plotset)
                }
            }
            .frame(width: 300, height: 200, alignment: .center)
            
            GeometryReader { proxy in
                ZStack {
                    GraphFrameView(geometryProxy:proxy)
                    GraphPlotView(geometryProxy: proxy, type:.verticalBar, dataSet: plotset2, xPlotAreaFactor: 0.9 ).setHueDegreeFunc(function: {index in
                        return Double(plotset2[index].y * 90 / 23)})
                }
            }.frame(width: 300, height: 200, alignment: .center)
            
            GeometryReader { proxy in
                           ZStack {
                               GraphFrameView(geometryProxy:proxy)
                            GraphPlotView(geometryProxy: proxy, type:.circlePlot, dataSet: plotset2, xPlotAreaFactor: 0.9).setCircle(color:.blue){index in plotset2[index].y * 1.4}
                                .setHueDegreeFunc{ index in
                                    return Double(plotset2[index].y * 90 / 23)
                            }
                }
                       }.frame(width: 300, height: 200, alignment: .center)
            
        }.previewLayout(PreviewLayout.fixed(width: 350, height: 250))
    }
}
