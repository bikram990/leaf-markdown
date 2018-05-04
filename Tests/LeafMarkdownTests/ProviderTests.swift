import XCTest
import Vapor
import Leaf

import LeafMarkdown

class ProviderTests: XCTestCase {
    static var allTests = [
        ("testProviderCreation", testProviderAddsTagToLeaf),
        ("testProviderGracefullyHandlesNonLeafRenderer", testProviderGracefullyHandlesNonLeafRenderer)
    ]

    func testProviderAddsTagToLeaf() throws {
        var services = Services.default()
        let leafProvider = LeafProvider()
        try services.register(leafProvider)
        try services.register(LeafMarkdown.Provider())
        let app = try Application(services: services)

        let renderer = try app.make(LeafRenderer.self)

        XCTAssertNotNil(renderer.tags[Markdown().name])
    }

    func testProviderGracefullyHandlesNonLeafRenderer() throws {
        var services = Services.default()
        try services.register(LeafMarkdown.Provider())
        _ = try Application(services: services)
        XCTAssert(true, "We should reach this point")
    }
}