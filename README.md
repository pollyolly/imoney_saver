# imoney_saver

A new Flutter project.

## Getting Started

Below are the resources used to create this project.

- [Provider](https://github.com/pollyolly/flutter_sqflite_example/blob/master/lib/provider/product.dart)
- [Notification](https://www.youtube.com/watch?v=bRy5dmts3X8)
- [Routing](https://www.youtube.com/watch?v=nyvwx7o277U)
- [sqflite](https://www.youtube.com/watch?v=n5tiox4kSWw)
- [fl_chart](https://github.com/imaNNeoFighT/fl_chart/blob/master/example/lib/pie_chart/samples/pie_chart_sample2.dart)

## Notification Configuration
AppDelegate.swift
<pre>
GeneratedPluginRegistrant.register(with: self)

if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}

return super.application(application, didFinishLaunchingWithOptions: launchOptions)
</pre>