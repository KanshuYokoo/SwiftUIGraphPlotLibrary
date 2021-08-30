//
//  File.swift
//  
//
//  Created by 観周 横尾 on 18/08/2021.
//

import Foundation
import CoreGraphics

public struct PlotData:Equatable {
    var x:CGFloat
    var y:CGFloat
    public init(x:CGFloat, y:CGFloat) {
        self.x = x
        self.y = y
    }
    
    public func getX() -> CGFloat {
        return self.x
    }
    public func getY() -> CGFloat {
        return self.y
    }
}

func convertArrayToPlotData<T1:Numeric,T2:Numeric>(xarray:[T1], yarray:[T2]) throws -> [PlotData] {
    var returnValue:[PlotData] = []
    if (xarray.count != yarray.count) {
        throw dataSetError.arraySize(x: xarray.count, y: yarray.count)
    }
    for (_, (x_value,y_value)) in zip(xarray, yarray).enumerated()
    {        
        returnValue.append(PlotData(x: CGFloat(fromNumeric: x_value), y: CGFloat(fromNumeric: y_value)))
    }
    return returnValue
}

enum dataSetError: Error {
    case arraySize(x: Int, y:Int)
    case castErrar(value:Any, index: Int, axis:String)
    case notNumber
}
