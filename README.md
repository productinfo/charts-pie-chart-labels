ShinobiCharts Pie Chart Labels (Objective-C)
=====================

This app builds on the PieChart demo shipped with ShinobiCharts, to fully customize the pie and donut chart labels and even move them out of the slices! There is an accompanying blog post [here](http://www.shinobicontrols.com/blog/posts/2012/08/06/pie-chart-labels-that-are-out-of-this-slice/).

![Screenshot](screenshot.png?raw=true)

Building the project
------------------

In order to build this project you'll need a copy of ShinobiCharts. If you don't have it yet, you can download a free trial from the [ShinobiCharts website](http://www.shinobicontrols.com/shinobicharts/).

Once you've downloaded and unzipped ShinobiCharts/Grids/Essentials, open up the project in XCode, and drag ShinobiCharts/Grids/Essentials.embeddedframework from the finder into Xcode's 'frameworks' group, and XCode will sort out all the header and linker paths for you.

If you're using the trial version you'll need to add your license key. To do so, open up ViewController.m and edit the following line:

    //Enter your trial license key here
    NSString *licenseKey = @"";
    
Contributing
------------

We'd love to see your contributions to this project - please go ahead and fork it and send us a pull request when you're done! Or if you have a new project you think we should include here, email info@shinobicontrols.com to tell us about it.

License
-------

The [Apache License, Version 2.0](license.txt) applies to everything in this repository, and will apply to any user contributions.

