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

## Contribute
This program is still under development.
However If you have any query or need more information, please open an issue.

Your contribution is highly appliciated.
Please help me !!!

## Credits
This program is created by Kanshu Yokoo

## License

This program is available under the MIT license. See the LICENSE file for more info.
