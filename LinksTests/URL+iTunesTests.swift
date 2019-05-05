//
//  URL+iTunesTests.swift
//  LinksTests
//
//  Created by John Brayton on 5/5/19.
//  Copyright © 2019 John Brayton. All rights reserved.
//

import XCTest
import StoreKit
@testable import Links

class UrlItunesTests: XCTestCase {

    func testProductParameters() {
        var url = URL(string: "https://itunes.apple.com/us/app/unread-rss-reader/id1252376153?ls=1&mt=8&at=11l4K5")!
        guard var params1 = url.GHS_itunesProductParameters() else {
            XCTFail()
            return
        }
        XCTAssertEqual(params1[SKStoreProductParameterITunesItemIdentifier], "1252376153")
        XCTAssertEqual(params1[SKStoreProductParameterAffiliateToken], "11l4K5")
        XCTAssertTrue(params1[SKStoreProductParameterCampaignToken] == nil)
        
        // Store Product View Controller can't handle action=write-review, so if that is the URL then bump it to openURL
        url = URL(string: "https://itunes.apple.com/us/app/unread-rss-reader/id1252376153?ls=1&mt=8&at=11l4K5&action=write-review")!
        XCTAssert(url.GHS_itunesProductParameters() == nil)
        
        url = URL(string: "https://itunes.apple.com/us/app/lumafusion/id1062022008?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline")!
        guard let params2 = url.GHS_itunesProductParameters() else {
            XCTFail()
            return
        }
        XCTAssertEqual(params2[SKStoreProductParameterITunesItemIdentifier], "1062022008")
        XCTAssertEqual(params2[SKStoreProductParameterAffiliateToken], "10l6nh")
        XCTAssertEqual(params2[SKStoreProductParameterCampaignToken], "holiday2017_inline")
        
        url = URL(string: "https://itunes.apple.com/us/app/unread-rss-reader/id1252376153")!
        guard var params3 = url.GHS_itunesProductParameters() else {
            XCTFail()
            return
        }
        XCTAssertEqual(params3[SKStoreProductParameterITunesItemIdentifier], "1252376153")
        XCTAssertTrue(params3[SKStoreProductParameterAffiliateToken] == nil)
        XCTAssertTrue(params3[SKStoreProductParameterCampaignToken] == nil)
        
        url = URL(string: "https://itunes.apple.com/us/app/unread-rss-reader/id1252376153?ls=1&mt=8")!
        guard var params4 = url.GHS_itunesProductParameters() else {
            XCTFail()
            return
        }
        XCTAssertEqual(params4[SKStoreProductParameterITunesItemIdentifier], "1252376153")
        XCTAssertTrue(params4[SKStoreProductParameterAffiliateToken] == nil)
        XCTAssertTrue(params4[SKStoreProductParameterCampaignToken] == nil)
        
        url = URL(string: "https://itunes.apple.com/us/app/lumafusion/id?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline")!
        XCTAssertTrue(url.GHS_itunesProductParameters() == nil)
        
        url = URL(string: "https://itunes.apple.com/us/app/lumafusion/idsaf?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline")!
        XCTAssertTrue(url.GHS_itunesProductParameters() == nil)
    }
    
    func testIsAnITunesOrAppStoreLink() {
        
        self.assert(urlString: "https://itunes.com/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: true, file: #file, line: #line)
        self.assert(urlString: "https://itunes.apple.com/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: true, file: #file, line: #line)
        self.assert(urlString: "https://itun.es/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: true, file: #file, line: #line)
        self.assert(urlString: "https://AppStore.com/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: true, file: #file, line: #line)
        self.assert(urlString: "https://foo.AppStore.com/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: true, file: #file, line: #line)
        
        // similar to above, but with capitalized hosts
        self.assert(urlString: "https://ITUNES.COM/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: true, file: #file, line: #line)
        self.assert(urlString: "https://ITUNES.APPLE.COM/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: true, file: #file, line: #line)
        self.assert(urlString: "https://ITUN.ES/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: true, file: #file, line: #line)
        self.assert(urlString: "https://APPSTORE.COM/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: true, file: #file, line: #line)
        
        // false if host contains widgets, or if just not an itunes URL.
        self.assert(urlString: "https://widgets.AppStore.com/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: false, file: #file, line: #line)
        self.assert(urlString: "https://foo.widgets.AppStore.com/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: false, file: #file, line: #line)
        self.assert(urlString: "https://www.goldenhillsoftware.com/", shouldOpenStoreViewController: false, file: #file, line: #line)
        
        // similar to above, but with capitalized hosts
        self.assert(urlString: "https://WIDGETS.AppStore.com/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: false, file: #file, line: #line)
        self.assert(urlString: "https://foo.WIDGETS.AppStore.com/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&ct=holiday2017_inline", shouldOpenStoreViewController: false, file: #file, line: #line)
        self.assert(urlString: "https://www.goldenhillsoftware.com/", shouldOpenStoreViewController: false, file: #file, line: #line)
        
        self.assert(urlString: "https://podcasts.apple.com/us/podcast/episode-371-times-gonna-fly/id281777685?i=1000437184897", hasITunesId: "1000437184897", file: #file, line: #line)
        
        // write-review actions should return false
        self.assert(urlString: "https://AppStore.com/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&action=write-review", shouldOpenStoreViewController: false, file: #file, line: #line)
        self.assert(urlString: "https://AppStore.com/us/app/lumafusion/id123?mt=8&uo=4&at=10l6nh&action=WRITE-REVIEW", shouldOpenStoreViewController: false, file: #file, line: #line)
        
        // music videos don't seem to work
        self.assert(urlString: "https://itunes.apple.com/us/music-video/new-york-state-of-mind-from-tonight-connecticut-1976/1454308532", shouldOpenStoreViewController: false, file: #file, line: #line)
        
        
        self.assert(urlString: "https://itunes.apple.com/us/app/unread-rss-reader/id", shouldOpenStoreViewController: false, file: #file, line: #line)
        self.assert(urlString: "https://itunes.apple.com/us/app/unread-rss-reader/idx", shouldOpenStoreViewController: false, file: #file, line: #line)
        self.assert(urlString: "https://itunes.apple.com/us/app/unread-rss-reader/foo", shouldOpenStoreViewController: false, file: #file, line: #line)
    }
    
    func testIdParsing() {
        self.assert(urlString: "https://itunes.apple.com/us/app/unread-rss-reader/id1252376153?ls=1&mt=8&at=11l4K5", hasITunesId: "1252376153", file: #file, line: #line)
        self.assert(urlString: "https://itunes.apple.com/us/album/piano-man/158815463?i=158815547", hasITunesId: "158815547", file: #file, line: #line)
        self.assert(urlString: "https://itunes.apple.com/us/album/piano-man/158815463?i=158815696", hasITunesId: "158815696", file: #file, line: #line)
        self.assert(urlString: "https://itunes.apple.com/us/artist/billy-joel/485953", hasITunesId: "485953", file: #file, line: #line)
        self.assert(urlString: "https://itunes.apple.com/us/podcast/supertop-podcast/id1143273587?mt=2", hasITunesId: "1143273587", file: #file, line: #line)
        self.assert(urlString: "https://itunes.apple.com/us/podcast/35-castro-updates-china-and-anchor/id1143273587?i=1000416745311&mt=2", hasITunesId: "1000416745311", file: #file, line: #line)
        
        self.assert(urlString: "https://itunes.apple.com/us/tv-season/the-west-wing-the-complete-series/id570201009", hasITunesId: "570201009", file: #file, line: #line)
        self.assert(urlString: "https://itunes.apple.com/us/tv-season/the-west-wing-season-3/id274565227", hasITunesId: "274565227", file: #file, line: #line)
        self.assert(urlString: "https://itunes.apple.com/us/tv-season/post-hoc-ergo-propter-hoc/id203756105?i=205129588", hasITunesId: "205129588", file: #file, line: #line)
        self.assert(urlString: "https://itunes.apple.com/us/movie/gone-baby-gone/id432503519", hasITunesId: "432503519", file: #file, line: #line)
    }
    
    
    func assert(urlString: String, shouldOpenStoreViewController expectedOpensStoreViewController: Bool, file: StaticString, line: UInt ) {
        guard let url = URL(string: urlString) else {
            XCTFail("not a url", file: file, line: line)
            return
        }
        let params = url.GHS_itunesProductParameters()
        if expectedOpensStoreViewController {
            XCTAssert(params != nil, file: file, line: line)
        } else {
            XCTAssert(params == nil, file: file, line: line)
        }
    }
    
    func assert( urlString: String, hasITunesId expectedITunesId: String, file: StaticString, line: UInt ) {
        guard let url = URL(string: urlString) else {
            XCTFail("not a url", file: file, line: line)
            return
        }
        guard let params = url.GHS_itunesProductParameters() else {
            XCTFail("not an iTunes URL", file: file, line: line)
            return
        }
        guard let iTunesId = params[SKStoreProductParameterITunesItemIdentifier] else {
            XCTFail("did not find an iTunes ID", file: file, line: line)
            return
        }
        XCTAssertEqual(iTunesId, expectedITunesId, file: file, line: line)
    }

}
