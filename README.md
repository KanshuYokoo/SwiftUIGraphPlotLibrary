# SwiftUIGraphPlotLibrary

Graph plot library with SwiftUI


## platform
It supports only on ios v13  


## useage

-- Bubble plot --
``` swift
let plotset:[PlotData] = [PlotData(x: 1.0,y: 2.0),PlotData(x: 2.0,y: 3.0),PlotData(x: 3.0,y: 2.0),PlotData(x: 4.0,y: 8.0),PlotData(x: 5.0,y: 30.0),PlotData(x: 6.0,y: 25.0),PlotData(x: 7.0,y: 24.0),PlotData(x: 8.0,y: 23.0),PlotData(x: 9.0,y: 22.0),PlotData(x: 9.6,y: 21.0)]

GeometryReader { proxy in
           ZStack {
               GraphFrameView(geometryProxy:proxy)
            GraphPlotView(type:.circlePlot, geometryProxy: proxy, dataSet: plotset2).setCircle(color:.blue){index in plotset2[index].getY) * 1.4}
                .setHueDegreeFunc{ index in
                    return Double(plotset2[index].getY() * 90 / 23)
            }
        }
}

```

![alt tag](https://github.com/KanshuYokoo/SwiftUIGraphPlotLibrary/blob/master/screenshots/bubbleChartPlot.png)

## Contribute
This program is still under development.
However If you have any query or need more information, please open an issue.

Your contribution is highly appliciated.
Please help me !!!

## Credits
This program is created by Kanshu Yokoo

## License

This program is available under the MIT license. See the LICENSE file for more info.
