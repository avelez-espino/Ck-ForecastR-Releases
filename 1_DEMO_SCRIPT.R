# FORECASTR DEMO SCRIPT
# These are examples of how to install and use the 
# forecastR package inside R (i.e. at the comman line).
# Another option is to use the shiny app at 
# https://solv-code.shinyapps.io/forecastr/



# ----------------------------
# OPTION1: install and load the package 

install.packages("devtools") # Install the devtools package
library(devtools) # Load the devtools package.
install_github("MichaelFolkes/forecastR_package",force=TRUE)
library(forecastR)

# using force = TRUE, because wasn't picking up changes
# or need to "build() before push"?
# got these:
# "Skipping install of 'forecastR' from a github remote, the SHA1 (7c25fdb4) has not changed since last install.
#  Use `force = TRUE` to force installation"
# but even with force = TRUE, the loaded version of rankModels() still has "dat.df <- abs(dat.df)",
# while the version in the master file on MF's github has "dat.df <- abs(dat.df[,column.ind])"

# these should be handled as dependencies *thought they were before?
library(forecast)
library(meboot)
library(moments)


# check if the help pages work
?calcFC
?fitModel
?multiFC
?doBoot
?rankModels
?plotModelFits



# OPTION 2: LOAD FROM LOCAL FOLDER

# for local debugging, turn on this part and comment out the package install above
path.use <- "../../R/"  # this is the path to your local copy of the forecastR modules 
#(if you run this script inside the extracted zip folder, then use "App Files/R/"

source(paste0(path.use,"3c_HelperFunctions_ModelSetup.R"))
source.modules(path.use)




# --------------------------------
# read in a data file SUBSTITUTE YOUR FILE PATH!
# Uses: read.csv(), preData()

data.withage.raw <- read.csv("SampleData/SampleFile_WithAge_ExclTotal.csv")  
data.withoutage.raw <- read.csv("SampleData/SampleFile_WithoutAge.csv")  



data.withage <- prepData(data.withage.raw,out.labels="v2")
data.withoutage <- prepData(data.withoutage.raw,out.labels="v2")




# ------------------------------------------------
# fit a few different models and calculate forecasts
# Uses: filtModel(),calcFC(), plotModelFit()

# Fit ARIMA model to the data set with age classes (no BoxCox transformation)
arimafit.withage.nobc <- fitModel(model= "TimeSeriesArima", data = data.withage$data, settings = list(BoxCox=FALSE),tracing=FALSE)
arimafc.withage.nobc <- calcFC(fit.obj= arimafit.withage.nobc ,data =data.withage$data, fc.yr= data.withage$specs$forecastingyear,  settings = list(BoxCox=FALSE), tracing=TRUE)	
names(arimafc.withage.nobc)
arimafc.withage.nobc$pt.fc
plotModelFit(arimafit.withage.nobc, options= list(plot.which = "fitted_ts",age.which="all",plot.add=FALSE),fc.add = arimafc.withage.nobc)
title(sub="ARIMA - No Box Cox")


# Fit SIBREGSIMPLE model to the data set with age classes 
sibregfit.withage <- fitModel(model= "SibRegSimple", data = data.withage$data, settings = NULL ,tracing=FALSE)
sibregfc.withage <- calcFC(fit.obj= sibregfit.withage ,data =data.withage$data, fc.yr= data.withage$specs$forecastingyear,  settings = NULL, tracing=TRUE)	
plotModelFit(sibregfit.withage, options= list(plot.which = "fitted_ts",age.which="all",plot.add=FALSE),fc.add = sibregfc.withage)
title(sub="Simple Sib Reg")



# -----------------------------------
# do a retrospective test for a model


sibreg.retro <- doRetro(model= "SibRegSimple", data = data.withage$data, 
				retro.settings = list(min.yrs=15), 
				fit.settings = NULL, 
				fc.settings = list(boot=NULL),
				tracing=FALSE,out.type="short")

names(sibreg.retro)
sibreg.retro$retro.pm.bal
sibreg.retro$retro.resids



# --------------------------------------
# do a bootstrap test for a model


arima.boot <- doBoot(data= data.withage, args.fitmodel= list(model= "TimeSeriesArima", settings = list(BoxCox=FALSE)),
					args.calcfc = list(fc.yr= 2018,  settings = list(BoxCox=FALSE)),
					args.boot = list(boot.type="meboot", boot.n=100, plot.diagnostics=FALSE),
					full.out = TRUE, plot.out=TRUE)

head(arima.boot)



# ------------------------------------------
# calculate several forecasts and rank the models


settings.use <- list(Naive1 = list(model.type="Naive",settings=list(avg.yrs=1)),
				Naive3 = list(model.type="Naive",settings=list(avg.yrs=3)),
				Naive5 = list(model.type="Naive",settings=list(avg.yrs=5)),
				SibRegSimple = list(model.type="SibRegSimple",settings=NULL),
				SibRegLogPower =  list(model.type="SibRegLogPower",settings=NULL),
				SibRegKalman =  list(model.type="SibRegKalman",settings=NULL),
				#TimeSeriesArimaBC = list(model.type="TimeSeriesArima",settings=list(BoxCox=TRUE)),
				TimeSeriesArimaNoBC = list(model.type="TimeSeriesArima",settings=list(BoxCox=FALSE)),
				#TimeSeriesExpSmoothBC = list(model.type="TimeSeriesExpSmooth",settings=list(BoxCox=TRUE)),
				TimeSeriesExpSmoothNoBC = list(model.type="TimeSeriesExpSmooth",settings=list(BoxCox=FALSE))
				)



multiresults.ptfconly <- multiFC(data.file=data.withage.raw,settings.list=settings.use,
						do.retro=FALSE,do.boot=FALSE,out.type="short",
						retro.min.yrs=15,tracing=FALSE)
multiresults.ptfconly



multiresults.retro <- multiFC(data.file=data.withage.raw,settings.list=settings.use,
						do.retro=TRUE,do.boot=FALSE,out.type="short",
						retro.min.yrs=15,tracing=FALSE)

names(multiresults.retro$retro.pm)
multiresults.retro$table.ptfc
multiresults.retro[["retro.pm"]][["retro.pm.bal"]]



ranktest1 <- rankModels(multiresults.retro$retro.pm$retro.pm.bal)
ranktest2 <- rankModels(multiresults.retro$retro.pm$retro.pm.bal, columnToRank = c("MRE","MAE") )
ranktest3 <- rankModels(multiresults.retro$retro.pm$retro.pm.bal, relative.bol=TRUE )


ranktest1$Total
ranktest2$Total
ranktest3$Total


