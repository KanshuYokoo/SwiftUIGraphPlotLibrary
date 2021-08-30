import XCTest
@testable import SwiftUIGraphPlotLibrary

final class SwiftUIGraphPlotLibraryTests: XCTestCase {

    private var expect5:[PlotData]!
    private var xarryInt5 :[Int]!
    private var yarryInt5 :[Int]!
    
    private var xarryDouble5 :[Double]!
    private var yarryDouble5 :[Double]!
    
    private var xarryFloat5 :[Float]!
    private var yarryFloat5 :[Float]!
    
    private var xarryCGFloat5 :[CGFloat]!
    private var yarryCGFloat5 :[CGFloat]!
    
    override func setUp() {
        super.setUp()
        
        expect5 = [PlotData(x: 1.0,y: 1.0), PlotData(x: 2.0,y: 4.0),PlotData(x: 3.0,y: 9.0),PlotData(x: 4.0,y: 16.0), PlotData(x: 5.0,y: 25.0)]
        
        xarryInt5 = [1,2,3,4,5]
        yarryInt5 = [1,4,9,16,25]
        
        xarryDouble5 = [1,2,3,4,5]
        yarryDouble5 = [1,4,9,16,25]
        
        xarryFloat5 = [1,2,3,4,5]
        yarryFloat5 = [1,4,9,16,25]
        
        xarryCGFloat5 = [1,2,3,4,5]
        yarryCGFloat5 = [1,4,9,16,25]
        
    }
    
    //MARK:PlotData
    func testConvertArrayToPlotData() {
        // convert Int arrays to the PlotData array
        do {
            let result = try convertArrayToPlotData(xarray: xarryInt5, yarray: yarryInt5)
            XCTAssertEqual(result, expect5)
        } catch {
            XCTFail("Failed: \(error)")
        }
    }
    
    func testConvertArrayToPlotData_Double() {
        // convert Float arrays to the PlotData array
        do {
            let result = try convertArrayToPlotData(xarray: xarryDouble5, yarray: yarryDouble5)
            XCTAssertEqual(result, expect5)
        } catch {
            XCTFail("Failed: \(error)")
        }
    }
    
    func testConvertArrayToPlotData_Float() {
        // convert Float arrays to the PlotData array
        do {
            let result = try convertArrayToPlotData(xarray: xarryFloat5, yarray: yarryFloat5)
            XCTAssertEqual(result, expect5)
        } catch {
            XCTFail("Failed: \(error)")
        }
    }
    
    func testConvertArrayToPlotData_CGFloat() {
        // convert CGFloat arrays to the PlotData array
        do {
            let result = try convertArrayToPlotData(xarray: xarryCGFloat5, yarray: yarryCGFloat5)
            XCTAssertEqual(result, expect5)
        } catch {
            XCTFail("Failed: \(error)")
        }
    }
    
    func testConvertArrayToPlotData_IntFloat() {
        // convert Int arrays to the PlotData array
        do {
            let result = try convertArrayToPlotData(xarray: xarryInt5, yarray: yarryFloat5)
            XCTAssertEqual(result, expect5)
        } catch {
            XCTFail("Failed: \(error)")
        }
    }
    
    func testConvertLargeArrayToPlotData() {
        var xarrayDouble:[Double] = []
        var yarrayDouble:[Double] = []
        var expect:[PlotData] = []
        for i in 1...10000 {
            xarrayDouble.append(Double(i))
            yarrayDouble.append(Double(i * i))
            expect.append(PlotData(x: CGFloat(i), y: CGFloat(i * i)))
        }
        do {
            let result = try convertArrayToPlotData(xarray: xarrayDouble, yarray: yarrayDouble)
            XCTAssertEqual(result, expect)
        } catch {
            XCTFail("Failed: \(error)")
        }
    }
    
    static var allTests = [
        ("testConvertArrayToPlotData", testConvertArrayToPlotData),
        ("testConvertArrayToPlotData_Float", testConvertArrayToPlotData_Float),
        ("testConvertArrayToPlotData_CGFloat", testConvertArrayToPlotData_CGFloat),
        ("testConvertArrayToPlotData_IntFloat", testConvertArrayToPlotData_IntFloat),
        ("testConvertLargeArrayToPlotData", testConvertLargeArrayToPlotData),
    ]
}
