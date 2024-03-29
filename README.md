# SwiftUIGraphPlotLibrary

Graph plot library with SwiftUI


## platform
It supports only on ios v13  


## useage

### Add Package repository 
To add a package dependency to your Xcode project, select File > Swift Packages > Add Package Dependency

### import the package
``` swift
import SwiftUIGraphPlotLibrary
```

##### -- Lineplot --
```swift
struct LinePlot: View {
var body: some View {
    let plotset:[PlotData] = [PlotData(x: 0.0,y: 0.0),PlotData(x: 1.0,y: 2.0),PlotData(x: 2.0,y: 5.0),
                              PlotData(x: 3.0,y: 3.0),PlotData(x: 4.0,y: 8.0),PlotData(x: 5.0,y: 10.0),
                              PlotData(x: 6.0,y: 25.0),PlotData(x: 7.0,y: 21.0),PlotData(x: 8.0,y: 23.0),
                              PlotData(x: 9.0,y: 22.0),PlotData(x: 9.6,y: 21.0),PlotData(x: 10,y: 30.0)]

    let plotView = GraphPlot(type: .linePlot, color: .orange)
    let frameSize = CGSize(width: 300, height: 200)
        
    return GraphView(dataSet: plotset, plotType: plotView, frameSize: frameSize, xTicks: true, yTicks: true)
             .frame(width: 350, height: 250, alignment: .center)
    }
}
```
![alt tag](https://github.com/KanshuYokoo/SwiftUIGraphPlotLibrary/blob/master/screenshots/LinePlot.png)

#### -- Vertical Bar plot --
```swift
struct BarPlot:View {
    var body:some View{
        let plotset:[PlotData] = [PlotData(x: 0.0,y: 0.0),PlotData(x: 1.0,y: 2.0),PlotData(x: 2.0,y: 5.0),
                                  PlotData(x: 3.0,y: 3.0),PlotData(x: 4.0,y: 8.0),PlotData(x: 5.0,y: 10.0),
                                  PlotData(x: 6.0,y: 25.0),PlotData(x: 7.0,y: 21.0),PlotData(x: 8.0,y: 23.0),
                                  PlotData(x: 9.0,y: 22.0),PlotData(x: 9.6,y: 21.0),PlotData(x: 10,y: 30.0)]
            
        let plotView = GraphPlot(type: .verticalBar, color: .blue)
            let frameSize = CGSize(width: 300, height: 200)
            
        return GraphView(dataSet: plotset, plotType: plotView, frameSize: frameSize, xTicks: true, yTicks: true)
               .frame(width: 350, height: 250, alignment: .center)
        }
}
```
![alt tag](https://github.com/KanshuYokoo/SwiftUIGraphPlotLibrary/blob/master/screenshots/BarPlot.png)

#### -- Bubble plot --
``` swift
import SwiftUI
import SwiftUIGraphPlotLibrary

struct exampleBuble: View {
var body: some View {

  let plotset:[PlotData] = [PlotData(x: 1.0,y: 2.0),PlotData(x: 2.0,y: 3.0),PlotData(x: 3.0,y: 2.0),
                            PlotData(x: 4.0,y: 8.0),PlotData(x: 5.0,y: 30.0),PlotData(x: 6.0,y: 25.0),
                            PlotData(x: 7.0,y: 24.0),PlotData(x: 8.0,y: 23.0),PlotData(x: 9.0,y: 22.0),
                            PlotData(x: 9.6,y: 21.0)]

  let bublePlot = GraphPlot(type: .circlePlot, color: .blue)
      .setCircleRadiusFunc{ index in 
                            plotset[index].getY() * 1.4}
      .setHueDegreeFunc{ index in
                            return Double(plotset[index].getY() * 90 / 23)}
  let frameSize = CGSize(width: 300, height: 200)

  return GraphView(dataSet: plotset, plotType: bublePlot, frameSize: frameSize, xTicks: true, yTicks: true)
        .frame(width: 350, height: 250, alignment: .center)
  
 }
}
```
![alt tag](https://github.com/KanshuYokoo/SwiftUIGraphPlotLibrary/blob/master/screenshots/BubblePlot.png)

#### -- Multipul plot -- 
```swift
struct MultiPlot:View {
    var body:some View {
        let plotset:[PlotData] = [PlotData(x: 0.0,y: 0.0),PlotData(x: 1.0,y: 2.0),PlotData(x: 2.0,y: 5.0),
                                  PlotData(x: 3.0,y: 3.0),PlotData(x: 4.0,y: 8.0),PlotData(x: 5.0,y: 10.0),
                                  PlotData(x: 6.0,y: 25.0),PlotData(x: 7.0,y: 21.0),PlotData(x: 8.0,y: 23.0),
                                  PlotData(x: 9.0,y: 22.0),PlotData(x: 9.6,y: 21.0),PlotData(x: 10,y: 30.0)]
        
        let frameSize = CGSize(width: 300, height: 200)
        let linePLot = GraphPlot(type: .linePlot, color: .orange)
        let barPlot = GraphPlot(type: .verticalBar, color: .blue)
        let bubblePlot = GraphPlot(type: .circlePlot, color: .blue)
            .setCircleRadiusFunc{ index in plotset[index].getY() * 1.4}
            .setHueDegreeFunc{ index in
                                return Double(plotset[index].getY() * 90 / 23)
                              }
        
        let plotsSet = [linePLot, barPlot,bubblePlot]
        
        return GraphView(dataSet: plotset, plotTypes: plotsSet, frameSize: frameSize, xTicks: true, yTicks: true)
               .frame(width: 350, height: 250, alignment: .center)
    }
}
```
![alt tag](https://github.com/KanshuYokoo/SwiftUIGraphPlotLibrary/blob/master/screenshots/MultiPlot.png)

#### -- Plotting using two x,y data arrays --
It is possible to plot using two separated arrays of x, y data from ver1.0.4 and later.
Int, Double, Float, and CGFloat are supported type of elements of arrays 

```swift
struct arrayPlotInt: View {
    var body: some View {
        
        let xarryInt5:[Int] = [1,2,3,4,5]
        let yarryInt5:[Int] = [1,4,9,16,25]
                
        let bublePlot = GraphPlot(type: .circlePlot, color: .blue)
        
        let frameSize = CGSize(width: 300, height: 200)
        return GraphView(xArray:xarryInt5,yArray:yarryInt5, plotType: bublePlot, frameSize: frameSize, xTicks: true, yTicks: true, xPlotAreaFactor: 0.9)
            .frame(width: 350, height: 250, alignment: .center)
    }
}
```
![alt tag](https://github.com/KanshuYokoo/SwiftUIGraphPlotLibrary/blob/master/screenshots/twoArraysData.png)

#### --Scatter plot --

```swift
struct scatterPlot: View {
    var body: some View {
        
        var xarry:[Double] = []
        var yarry:[Double] = []
                
        for _ in 1...100 {
            let x = Double.random(in: 0.0...10)
            let y = x * (1 + Double.random(in: 0.0...0.4))
            xarry.append(x)
            yarry.append(y)
        }
        
        let bublePlot = GraphPlot(type: .circlePlot, color: .blue, circleRadius:4)
        
        let frameSize = CGSize(width: 300, height: 200)
        return GraphView(xArray:xarry,yArray:yarry, plotType: bublePlot, frameSize: frameSize, xTicks: true, yTicks: true, xPlotAreaFactor: 0.9)
            .frame(width: 350, height: 250, alignment: .center)
    }
}
```
![alt tag](https://github.com/KanshuYokoo/SwiftUIGraphPlotLibrary/blob/master/screenshots/scatterPlot.png)

## Contribute
This program is still under development.
However If you have any query or need more information, please open an issue.

Your contribution is highly appliciated.
Please help me !!!

## Credits
This program is created by Kanshu Yokoo

## License

This program is available under the MIT license. See the LICENSE file for more info.
