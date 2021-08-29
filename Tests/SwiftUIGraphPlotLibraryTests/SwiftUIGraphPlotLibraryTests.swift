import XCTest
@testable import SwiftUIGraphPlotLibrary

final class SwiftUIGraphPlotLibraryTests: XCTestCase {

    private var xarryInt5 :[Int]!
    private var yarryInt5 :[Int]!
    
    override func setUp() {
        super.setUp()
        xarryInt5 = [1,2,3,4,5]
        yarryInt5 = [1,4,9,16,25]
    }
    
    //MARK:PlotData
    func testConvertArrayToPlotData() {
        // convertArrayToPlotData
        let expect:[PlotData] = [PlotData(x: 1.0,y: 1.0), PlotData(x: 2.0,y: 4.0),PlotData(x: 3.0,y: 9.0),PlotData(x: 4.0,y: 16.0), PlotData(x: 5.0,y: 25.0)]

        do {
            let result = try convertArrayToPlotData(xarray: xarryInt5, yarray: yarryInt5)
            XCTAssertEqual(result, expect)
        } catch {
            XCTFail("Failed: \(error)")
        }
    }
    
    

    static var allTests = [
        ("testExample", testConvertArrayToPlotData),
    ]
}
