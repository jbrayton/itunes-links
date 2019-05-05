//
//  Link.swift
//  itunes-links
//
//  Created by John Brayton on 5/5/19.
//  Copyright © 2019 John Brayton. All rights reserved.
//

import Foundation

class Link {
    
    static let list = [
        Link(url: URL(string: "https://www.apple.com/")!, title: "Apple web site"),
        Link(url: URL(string: "https://www.youtube.com/watch?v=TZmBoMZFC8g")!, title: "Apple Event 2019 video on YouTube"),
        Link(url: URL(string: "https://itunes.apple.com/us/app/unread-rss-reader/id1252376153?ls=1&mt=8&at=11l4K5")!, title: "Unread in the App Store"),
        Link(url: URL(string: "https://itunes.apple.com/us/album/piano-man/158815463?i=158815547")!, title: "Piano Man on iTunes"),
        Link(url: URL(string: "https://itunes.apple.com/us/artist/billy-joel/485953")!, title: "Billy Joel on iTunes"),
        Link(url: URL(string: "https://itunes.apple.com/us/podcast/core-intuition/id281777685?mt=2")!, title: "Core Intuition in Apple Podcasts"),
        Link(url: URL(string: "https://podcasts.apple.com/us/podcast/episode-371-times-gonna-fly/id281777685?i=1000437184897")!, title: "Episode of Core Intuition in Apple Podcasts"),
        Link(url: URL(string: "https://itunes.apple.com/us/tv-season/the-west-wing-the-complete-series/id570201009")!, title: "The West Wing on iTunes"),
        Link(url: URL(string: "https://itunes.apple.com/us/tv-season/the-west-wing-season-3/id274565227")!, title: "Season of The West Wing on iTunes"),
        Link(url: URL(string: "https://itunes.apple.com/us/movie/gone-baby-gone/id432503519")!, title: "Gone Baby Gone on iTunes")
    ]
    
    let url: URL
    let title: String
    
    init( url: URL, title: String ) {
        self.url = url
        self.title = title
    }
    
}
