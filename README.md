# Handling iTunes Links

In February 2019 Robin Kunde [wrote a blog post](https://recoursive.com/2019/02/22/preflight_universal_links/) describing how to try opening a URL as a universal link before opening it in a Safari View controller.  This is fantastic advice, and something I did not know was possible.

One issue this does not resolve is handling URLs to iTunes content: music, videos, podcasts, and apps. Opening URLs to iTunes content with [universalLinksOnly: true] does nothing and passes false to the completion handler regardless of whether the relevant Apple app is on the device. If the relevant apple app has been deleted from the device, neither presenting a Safari View Controller nor calling UIApplication.shared.open(...) will provide a good user experience. iOS prompts you to reinstall the relevant Apple app. If you choose not to reinstall the relevant Apple app, you do not see the content. Please file a duplicate of [Radar 50480706](https://openradar.appspot.com/radar?id=5000482837757952) if you agree that Apple should address this.

This project is a sample app with code to detect links to iTunes content and to handle them by presenting a Store Product View Controller. To open a URL with the most appropriate mechanism, incorporate UIViewController+LinkHandler.swift and URL+iTunes.swift into your app and call this method from your view controller:

```swift
self.GHS_open(url: link.url)
```

## Credits

Jared Sinclair built this functionality into Unread. This is based on code he wrote and that Oisín Prendiville and Pádraig Ó Cinnéide later maintained.
