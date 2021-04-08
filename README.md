## Ck-ForecastR-Releases
Repository for major releases, feedback, and bug reports.

For details, check out the latest **[ForecastR Report](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwiMi47T1rrvAhVVJjQIHQ-nCNYQFjAGegQIChAD&url=https%3A%2F%2Fwww.psc.org%2Fdownload%2F585%2Fvery-high-priority-chinook%2F11704%2Fs18-vhp15a-forecastr-tools-to-automate-forecasting-procedures-for-salmonid-terminal-run-and-escapement.pdf&usg=AOvVaw2ZHMiJb0dBhjytGgM8lgvZ)**


**What's New?**

Since the last major release in the spring of 2020,
the following major updates have been implemented:

* Return Rate (Mechanistic) Model added to the package code
and to the app interface.
* Explore tab options dynamically respond to data set and model selection (e.g. only show sibling regression model options
if data has age classes, menu options for model settings adapt to model selection)
*  Compare tab model selection re-design: have tabs for each model type now, with model-specific options.



*Note*: The code for the *ForecastR* package is continuously evolving. Whenever we get to a major release milestone, we make the code available here.  This repository is where the development team interacts with the End User Community.

*ForecastR* is available in 2 configurations:

* Shiny App: Interactive interface for exploring and ranking alternative forecast models.
* R Package: Command line access to the computational engine.


### What would you like to do?

Note: The links below will take you away from this page, unless you open them with "Right Click -> Open in New Tab".

#### I would like to play with the latest prototype


* Run the app on the server: Go to March 2021 version of the *ForecastR* App([SOLV server ](https://solv-code.shinyapps.io/forecastr/),[PSC server ](https://psc1.shinyapps.io/ForecastR/)), load in a data file, and explore the alternative forecast models.
* Install the package: Go to the [*ForecastR* Package](https://github.com/MichaelFolkes/forecastR_package), then build a custom script to automate your analyses (like this [demo script](https://github.com/avelez-espino/Ck-ForecastR-Releases/blob/master/1_DEMO_SCRIPT.R))
* Run the app locally: Download a [zip folder](https://github.com/avelez-espino/Ck-ForecastR-Releases/blob/master/Zipped_Releases/CK_ForecastR_prototype2021_03_08.zip) (Open this link in a new tab, then click the *Download* button),
	then run the *LaunchGUI.R* script.
* Examples of data input files can be found [here](https://github.com/avelez-espino/Ck-ForecastR-Releases/blob/master/SampleData)

#### I would like to find out more about *ForecastR*

The [Wiki](https://github.com/avelez-espino/Ck-ForecastR-Releases/wiki) describes the evolution of *ForecastR*, current developments,and planned features.

Notable pages are:

* [About](https://github.com/avelez-espino/Ck-ForecastR-Releases/wiki/1---About)
* [Structure](https://github.com/avelez-espino/Ck-ForecastR-Releases/wiki/2---Structure)



#### I would like to provide feedback

* To report a bug or request a feature, start a new issue [here](https://github.com/avelez-espino/Ck-ForecastR-Releases/issues) using either the *Bug* label or
the *Feature Request* label. To select a label, choose from the drop-menu on the right of the screen after you start a new issue.
* To provide feedback on the current prototype, leave a comment at [this thread](https://github.com/avelez-espino/Ck-ForecastR-Releases/issues/4)
* To add your system information to the "Verified Version Tracker", edit the first entry at [this thread](https://github.com/avelez-espino/Ck-ForecastR-Releases/issues/2)


