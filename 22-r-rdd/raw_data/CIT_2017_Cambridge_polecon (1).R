#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
# A Practical Introduction to Regression Discontinuity Designs
# Authors: Matias D. Cattaneo, Nicolas Idrobo and Rocio Titiunik
# Last update: 30-May-2017
#------------------------------------------------------------------------------#
# SOFTWARE WEBSITE: https://sites.google.com/site/rdpackages/
#------------------------------------------------------------------------------#
# TO INSTALL/DOWNLOAD R PACKAGES/FUNCTIONS:
# FOREIGN: install.packages('foreign')
# GGPLOT2: install.packages('ggplot2')
# GRID: install.packages('grid')
# LPDENSITY: install.packages('lpdensity')
# RDDENSITY: install.packages('rddensity')
# RDLOCRAND: install.packages('rdlocrand')
# RDROBUST: install.packages('rdrobust')
# TEACHINGDEMOS: install.packages('TeachingDemos')
#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
rm(list=ls())

library(foreign)
library(ggplot2)
library(lpdensity)
library(rddensity)
library(rdrobust)
library(rdlocrand)
library(TeachingDemos)

options(width=300)
par(mar = rep(2, 4))

# A folder called "outputs" needs to be created in order to store 
# all of the figures, logs and tables. If the folder already exists,
# the user will get an error message but the code will not stop.
tryCatch(dir.create("outputs"))

data = read.dta("polecon.dta")
Y = data$Y
X = data$X
Z = data$Z
Z_X = Z*X

#-------------------------#
# Section 1: Introduction #
#-------------------------#
pdf("./outputs/R_RDplot-Meyersson-naive-p0.pdf")
rdplot(Y, X, nbins=c(2500,500), p = 0, col.lines="red", col.dots="lightgray", title="", 
       x.label="Islamic Margin of Victory", y.label="Female High School Share")
dev.off()

pdf("./outputs/R_RDplot-Meyersson-naive-p4.pdf")
rdplot(Y[abs(X)<=50], X[abs(X) <= 50], nbins=c(2500,500), p = 4, col.lines="red", col.dots="lightgray", title="", 
       x.label="Islamic Margin of Victory", y.label="Female High School Share")
dev.off()

#---------------------#
# Section 3: RD Plots #
#---------------------#
# Figure 3.1, Scatter plot
txtStart("./outputs/R_meyersson_rdplot_raw.txt", commands=TRUE, results=FALSE, append=FALSE, visible.only=TRUE)
plot(X, Y, xlab = "Running Variable", ylab = "Outcome", col=1, pch=20)
abline(v=0)
txtStop()

pdf("./outputs/R_meyersson_rdplot_raw.pdf")
plot(X, Y, xlab = "Running Variable", ylab = "Outcome", col=1, pch=20)
abline(v=0)
dev.off()

# Figure 3.2, RD Plot Using 40 Bins of Equal Length
txtStart("./outputs/R_meyersson_rdplot_esmv_20bins-COMMAND-ONLY.txt",
         commands=TRUE, results=FALSE, append=FALSE, visible.only=TRUE)
out = rdplot(Y, X, nbins = c(20,20), binselect = 'esmv')
print(out)
txtStop()

pdf("./outputs/R_meyersson_rdplot_esmv_20bins.pdf")
rdplot(Y, X, nbins = c(20,20), binselect = 'esmv', x.label = 'Running Variable', y.label = 'Outcome', title = '')
dev.off()

# Figure 3.4, 40 Evenly-Spaced Bins
txtStart("./outputs/R_meyersson_rdplot_es_20bins.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = rdplot(Y, X, nbins = c(20,20), binselect = 'es')
print(out)
txtStop()

pdf("./outputs/R_meyersson_rdplot_es_20bins.pdf")
rdplot(Y, X, nbins = c(20,20), binselect = 'es', x.label = 'Running Variable', y.label = 'Outcome', title = '')
dev.off()

# Figure 3.5, 40 Quantile-Spaced Bins
txtStart("./outputs/R_meyersson_rdplot_qs_20bins.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = rdplot(Y, X, nbins = c(20,20), binselect = 'qs')
print(out)
txtStop()

pdf("./outputs/R_meyersson_rdplot_qs_20bins.pdf")
rdplot(Y, X, nbins = c(20,20), binselect = 'qs', x.label = 'Running Variable', y.label = 'Outcome', title = '')
dev.off()

# Figure 3.7, IMSE RD PLot with Evenly-Spaced Bins
txtStart("./outputs/R_meyersson_rdplot_es.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = rdplot(Y, X,  binselect = 'es')
print(out)
txtStop()

pdf("./outputs/R_meyersson_rdplot_es.pdf")
rdplot(Y, X,  binselect = 'es', x.label = 'Running Variable', y.label = 'Outcome', title = '')
dev.off()

# Figure 3.8, IMSE RD Plot with Quantile-Spaced Bins
txtStart("./outputs/R_meyersson_rdplot_qs.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = rdplot(Y, X,  binselect = 'qs')
print(out)
txtStop()

pdf("./outputs/R_meyersson_rdplot_qs.pdf")
rdplot(Y, X,  binselect = 'qs', x.label = 'Running Variable', y.label = 'Outcome', title = '')
dev.off()

# Figure 3.10, Mimicking Variance RD Plot with Evenly-Spaced Bins
txtStart("./outputs/R_meyersson_rdplot_esmv.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = rdplot(Y, X,  binselect = 'esmv')
print(out)
txtStop()

pdf("./outputs/R_meyersson_rdplot_esmv.pdf")
rdplot(Y, X,  binselect = 'esmv', x.label = 'Running Variable', y.label = 'Outcome', title = '')
dev.off()

# Figure 3.11, Mimicking Variance RD Plot with Quantile-Spaced Bins
txtStart("./outputs/R_meyersson_rdplot_qsmv.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = rdplot(Y, X,  binselect = 'qsmv')
print(out)
txtStop()

pdf("./outputs/R_meyersson_rdplot_qsmv.pdf")
rdplot(Y, X,  binselect = 'qsmv', x.label = 'Running Variable', y.label = 'Outcome', title = '')
dev.off()

#-----------------------------------------#
# Section 4: Continuity-Based RD Approach #
#-----------------------------------------#
# Code snippet 1, Using Two Regressions to Estimate
txtStart("./outputs/R_meyersson_manualreg_tworegs_uniform_adhoc_p1.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = lm(Y[X<0 & X>=-20]~X[X<0 & X>=-20])
left_intercept = out$coefficients[1]
print(left_intercept)
out = lm(Y[X>=0 & X<20]~X[X>=0 & X<20])
right_intercept = out$coefficients[1]
print(right_intercept)
difference = right_intercept - left_intercept
print(paste("The RD estimator is", difference, sep = " "))
txtStop()

# Code snippet 2, Using One Regression to Estimate
txtStart("./outputs/R_meyersson_manualreg_onereg_uniform_adhoc_p1.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
Z_X = X*Z
out = lm(Y[X>=-20 & X<=20]~X[X>=-20 & X<=20]+Z[X>=-20 & X<=20]+Z_X[X>=-20 & X<=20])
print(out)
txtStop()

# Code snippet 3, Generating Weights
txtStart("./outputs/R_meyersson_manualreg_weights_triangular_adhoc_p1.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
w = NA
w[X<0 & X>=-20] = 1-abs(X[X<0 & X>=-20]/20)
w[X>=0 & X<=20] = 1-abs(X[X>=0 & X<=20]/20)
txtStop()

# Code snippet 4, Using Two Regressions and Weights to Estimate
txtStart("./outputs/R_meyersson_manualreg_tworegs_triangular_adhoc_p1.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = lm(Y[X<0]~X[X<0], weights=w[X<0])
left_intercept = out$coefficients[1]
out = lm(Y[X>=0]~X[X>=0], weights=w[X>=0])
right_intercept = out$coefficients[1]
difference = right_intercept - left_intercept
print(difference)
txtStop()

# Code snippet 5, Using rdrobust with Uniform Weights
txtStart("./outputs/R_meyersson_rdrobust_uniform_adhoc_p1_rho1_regterm1.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdrobust(Y, X, kernel = 'uniform',  p = 1, h = 20)
txtStop()

# Code snippet 6, Using rdrobust with Triangular Weights
txtStart("./outputs/R_meyersson_rdrobust_triangular_adhoc_p1_rho1_regterm1.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdrobust(Y, X, kernel = 'triangular',  p = 1, h = 20)
txtStop()

# Code snippet 7, Using rdrobust with Triangular Weights and p=2
txtStart("./outputs/R_meyersson_rdrobust_triangular_adhoc_p2_rho1_regterm1.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdrobust(Y, X, kernel = 'triangular',  p = 2, h = 20)
txtStop()

# Code snippet 8, Using rdbwselect with mserd Bandwidth
txtStart("./outputs/R_meyersson_rdbwselect_triangular_mserd_p1_regterm1_all.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdbwselect(Y, X, kernel = 'triangular',  p = 1, bwselect = 'mserd')
txtStop()

# Code snippet 9, Uusing rdbwselect with msetwo Bandwidth
txtStart("./outputs/R_meyersson_rdbwselect_triangular_msetwo_p1_regterm1_all.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdbwselect(Y, X, kernel = 'triangular',  p = 1, bwselect = 'msetwo')
txtStop()

# Code snippet 10, Using rdrobust with mserd Bandwidth
txtStart("./outputs/R_meyersson_rdrobust_triangular_mserd_p1_rhofree_regterm1.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdrobust(Y, X, kernel = 'triangular',  p = 1, bwselect = 'mserd')
txtStop()

# Code snippet 11, Using rdrobust and Showing the Objects it Returns
txtStart("./outputs/R_meyersson_rdrobust_triangular_mserd_p1_rhofree_regterm1_namescoefsout_all.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdout = rdrobust(Y, X, kernel = 'triangular', p = 1, bwselect = 'mserd')
print(names(rdout))
print(rdout$beta_p_r)
print(rdout$beta_p_l)
txtStop()

# Code snippet 12, Using rdrobust and Showing the Associated rdplot
txtStart("./outputs/R_meyersson_rdplot_maineffect.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
bandwidth = rdrobust(Y, X, kernel = 'triangular', p = 1, bwselect = 'mserd')$h_l
out = rdplot(Y[abs(X)<=bandwidth], X[abs(X)<=bandwidth], p = 1, kernel = 'triangular')
print(out)
txtStop()

pdf("./outputs/R_meyersson_rdplot_maineffect.pdf")
rdplot(Y[abs(X)<=bandwidth], X[abs(X)<=bandwidth], p = 1, kernel = 'triangular',
       x.label = 'Running Variable', y.label = 'Outcome', title = '')
dev.off()

# Code snippet 13, Using rdrobust Without Regularization Term
txtStart("./outputs/R_meyersson_rdrobust_triangular_mserd_p1_rhofree_regterm0.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdrobust(Y, X, kernel = 'triangular', scaleregul = 0,  p = 1, bwselect = 'mserd')
txtStop()

# Code snippet 14, Using rdrobust with Default Options
txtStart("./outputs/R_meyersson_rdrobust_triangular_mserd_p1_rhofree_regterm1.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdrobust(Y, X, kernel = 'triangular',  p = 1, bwselect = 'mserd')
txtStop()

# Code snippet 15, Using rdrobust with Default Options and Showing All the Output
txtStart("./outputs/R_meyersson_rdrobust_triangular_mserd_p1_rhofree_regterm1_all.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdrobust(Y, X, kernel = 'triangular',  p = 1, bwselect = 'mserd', all = TRUE)
txtStop()

# Code snippet 16, Using rdrobust with cerrd bandwidth
txtStart("./outputs/R_meyersson_rdrobust_triangular_cerrd_p1_rhofree_regterm1.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdrobust(Y, X, kernel = 'triangular', p = 1, bwselect = 'cerrd')
txtStop()

# Code snippet 17, Using rdbwselect with All the Bandwidths
txtStart("./outputs/R_meyersson_rdbwselect_triangular_all_p1_regterm1.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdbwselect(Y, X, kernel = 'triangular', p = 1, all = TRUE)
txtStop()

# Code snippet 18, Using rdbwselect with Covariates
txtStart("./outputs/R_meyersson_rdbwselect_triangular_mserd_p1_regterm1_covariates_noi89.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
Z = cbind(data$vshr_islam1994, data$partycount, data$lpop1994,
          data$merkezi, data$merkezp, data$subbuyuk, data$buyuk)
colnames(Z) = c("vshr_islam1994", "partycount", "lpop1994",
                "merkezi", "merkezp", "subbuyuk", "buyuk")
rdbwselect(Y, X, covs = Z, kernel = 'triangular', scaleregul = 1, p = 1, bwselect = 'mserd')
txtStop()

# Code snippet 19, Using rdrobust with Covariates
txtStart("./outputs/R_meyersson_rdrobust_triangular_mserd_p1_regterm1_covariates_noi89.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
Z = cbind(data$vshr_islam1994, data$partycount, data$lpop1994,
          data$merkezi, data$merkezp, data$subbuyuk, data$buyuk)
colnames(Z) = c("vshr_islam1994", "partycount", "lpop1994",
                "merkezi", "merkezp", "subbuyuk", "buyuk")
rdrobust(Y, X, covs = Z, kernel = 'triangular', scaleregul = 1, p = 1, bwselect = 'mserd')
txtStop()

#--------------------------------------------#
# Section 5: Local Randomization RD Approach #
#--------------------------------------------#
# Code snippet 1, Using rdrandinf in the Ad-hoc Window
txtStart("./outputs/R_meyersson_rdrandinf_adhoc_p0.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = rdrandinf(Y, X, wl = -2.5, wr=2.5, seed = 50)
txtStop()

# Code snippet 2, Using rdrandinf in the Ad-hoc Window with the Bernoulli Option
txtStart("./outputs/R_meyersson_rdrandinf_adhoc_p0_bernoulli.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
bern_prob = numeric(length(X))
bern_prob[abs(X)>2.5] = NA
bern_prob[abs(X)<=2.5] = 1/2
out = rdrandinf(Y, X, wl = -2.5, wr=2.5, seed = 50, bernoulli = bern_prob)
txtStop()

# Code snippet 3, Using rdrandinf in the Ad-hoc Window with the Kolmogorov-Smirnov Statistic
txtStart("./outputs/R_meyersson_rdrandinf_adhoc_p0_ksmirnov.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = rdrandinf(Y, X, wl = -2.5, wr=2.5, seed = 50, statistic = 'ksmirnov')
txtStop()

# Code snippet 4, Using rdrandinf in the Ad-hoc Window with the Confidence Interval Option
txtStart("./outputs/R_meyersson_rdrandinf_adhoc_p0_ci.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
ci_vec = c(0.05, seq(from = -10, to = 10, by = 0.25))
out = rdrandinf(Y, X, wl = -2.5, wr=2.5, seed = 50, reps = 1000, ci = ci_vec)
txtStop()

# Code snippet 5, Using rdwinselect with the wobs Option
txtStart("./outputs/R_meyersson_rdwinselect_automatic_p0_wobs2_secondtry.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
Z = cbind(data$i89, data$vshr_islam1994, data$partycount, data$lpop1994,
          data$merkezi, data$merkezp, data$subbuyuk, data$buyuk)
colnames(Z) = c("i89","vshr_islam1994", "partycount", "lpop1994",
                "merkezi", "merkezp", "subbuyuk", "buyuk")
out = rdwinselect(X, Z, seed = 50, reps = 1000, wobs = 2)
txtStop()

# Code snippet 6, Using rdwinselect with the wobs, nwindows and plot Options
txtStart("./outputs/R_meyersson_rdwinselect_automatic_p0_wobs2_secondtry_manywindows.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
Z = cbind(data$i89, data$vshr_islam1994, data$partycount, data$lpop1994,
          data$merkezi, data$merkezp, data$subbuyuk, data$buyuk)
colnames(Z) = c("i89","vshr_islam1994", "partycount", "lpop1994",
                "merkezi", "merkezp", "subbuyuk", "buyuk")
out = rdwinselect(X, Z, seed = 50, reps = 1000, wobs = 2, nwindows = 50, plot = TRUE)
txtStop()

pdf("./outputs/R_meyersson_rdwinselect_automatic_p0_wobs2_secondtry_manywindows.pdf")
out = rdwinselect(X, Z, seed = 50, reps = 1000, wobs = 2, nwindows = 50, plot = TRUE)
dev.off()

# Code snippet 7, Using rdwinselect with the wstep and nwindows Options
txtStart("./outputs/R_meyersson_rdwinselect_automatic_p0_wstep_secondtry.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
Z = cbind(data$i89, data$vshr_islam1994, data$partycount, data$lpop1994,
          data$merkezi, data$merkezp, data$subbuyuk, data$buyuk)
colnames(Z) = c("i89","vshr_islam1994", "partycount", "lpop1994",
                "merkezi", "merkezp", "subbuyuk", "buyuk")
out = rdwinselect(X, Z, seed = 50, reps = 1000, wstep = 0.1, nwindows = 25)
txtStop()

# Code snippet 8, Using rdrandinf with the Confidence Interval Option
txtStart("./outputs/R_meyersson_rdrandinf_specific1.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
ci_vec = c(0.05, seq(from = -10, to = 10, by = 0.1))
out = rdrandinf(Y, X, wl = -0.944, wr=0.944, seed = 50, reps = 1000, ci = ci_vec)
txtStop()

# Code snippet 9, Using rdrandinf with the Alternative Power Option
txtStart("./outputs/R_meyersson_rdrandinf_automatic_p0_secondtry_altpower.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
Z = cbind(data$i89, data$vshr_islam1994, data$partycount, data$lpop1994,
          data$merkezi, data$merkezp, data$subbuyuk, data$buyuk)
colnames(Z) = c("i89", "vshr_islam1994", "partycount", "lpop1994", 
                "merkezi", "merkezp", "subbuyuk", "buyuk")
out = rdrandinf(Y, X, covariates = Z, seed = 50, d = 3.019522)
txtStop()

#-----------------------------------------#
# Section 6: Validation and Falsification #
#-----------------------------------------#
# Code snippet 1, Using rddensity
txtStart("./outputs/R_meyersson_falsification_rddensity.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = rddensity(X)
summary(out)
txtStop()

# Figure 6.2
bw_left = as.numeric(rddensity(X)$h[1]); bw_right = as.numeric(rddensity(X)$h[2]);
tempdata = as.data.frame(X); colnames(tempdata) = c("v1");
est1 = lpdensity(data = X[X<0 & X>=-bw_left], grid = seq(-bw_left, 0, 0.1), bwselect = "IMSE",
                 scale = sum(X<0 & X>=-bw_left)/length(X))
est2 = lpdensity(data = X[X>=0 & X<=bw_right], grid = seq(0, bw_right, 0.1), bwselect = "IMSE",
                 scale = sum(X>=0 & X<=bw_right)/length(X))
plot1 = lpdensity.plot(est1, est2, CIshade = 0.2, lcol=c(4,2), CIcol = c(4,2))+
        labs(x="Score", y="Density")+geom_vline(xintercept=0, color="black")+
        theme_bw()
ggsave("./outputs/R_meyersson_falsification_lpdensity1.pdf", plot = plot1, width = 6, height = 5, units = "in")

plot2 = ggplot(data=tempdata, aes(tempdata$v1))+
        geom_histogram(data=tempdata, aes(x=v1, y=..count..), breaks=seq(-bw_left, 0, 1), fill="blue", col="black", alpha=1)+
        geom_histogram(data=tempdata, aes(x=v1, y=..count..), breaks=seq(0, bw_right, 1), fill="red", col="black", alpha=1)+
        labs(x="Score", y="Number of Observations")+geom_vline(xintercept=0, color="black")+
        theme_bw()
ggsave("./outputs/R_meyersson_falsification_lpdensity2.pdf", plot = plot2, width = 6, height = 5, units = "in")

# Code snippet 2, Binomial Test with rdwinselect
txtStart("./outputs/R_meyersson_falsification_binomial.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = rdwinselect(X, wmin = 0.944, nwindows = 1)
txtStop()

# Code snippet 3, Binomial Test by Hand
txtStart("./outputs/R_meyersson_falsification_binomial_byhand.txt", commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
binom.test(27, 50, 1/2)
txtStop()

# Figure 6.3
pdf("./outputs/R_meyersson_falsification_rdplot_lpop1994.pdf")
rdplot(data$lpop1994, X,
       x.label = "Running Variable", y.label = "", title="")
dev.off()

pdf("./outputs/R_meyersson_falsification_rdplot_partycount.pdf")
rdplot(data$partycount, X,
       x.label = "Running Variable", y.label = "", title="")
dev.off()

pdf("./outputs/R_meyersson_falsification_rdplot_vshr_islam1994.pdf")
rdplot(data$vshr_islam1994, X,
       x.label = "Running Variable", y.label = "", title="")
dev.off()

pdf("./outputs/R_meyersson_falsification_rdplot_i89.pdf")
rdplot(data$i89, X,
       x.label = "Running Variable", y.label = "", title="")
dev.off()

pdf("./outputs/R_meyersson_falsification_rdplot_merkezp.pdf")
rdplot(data$merkezp, X,
       x.label = "Running Variable", y.label = "", title="")
dev.off()

pdf("./outputs/R_meyersson_falsification_rdplot_merkezi.pdf")
rdplot(data$merkezi, X,
       x.label = "Running Variable", y.label = "", title="")
dev.off()

# Code snippet 4, Using rdrobust on lpop1994
txtStart("./outputs/R_meyersson_falsification_rdrobust_lpop1994.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdrobust(data$lpop1994, X)
txtStop()

# Code snippet 5, Using rdplot to Show the rdrobust Effect for lpop1994
txtStart("./outputs/R_meyersson_falsification_rdplot_rdrobust_lpop1994.txt",
         commands=TRUE, results=FALSE, append=FALSE, visible.only=TRUE)
bandwidth = rdrobust(data$lpop1994, X)$h_l
xlim = ceiling(bandwidth)
rdplot(data$lpop1994[abs(X)<=bandwidth], X[abs(X)<=bandwidth],
       p=1, kernel='triangular', x.lim=c(-xlim,xlim), x.label = "Running Variable",
       y.label = "", title="")
txtStop()

# Figure 6.4
bandwidth = rdrobust(data$lpop1994, X)$h_l
xlim = ceiling(bandwidth)
pdf("./outputs/R_meyersson_falsification_rdplot_rdrobust_lpop1994.pdf")
rdplot(data$lpop1994[abs(X)<=bandwidth], X[abs(X)<=bandwidth],
       p=1, kernel='triangular', x.lim=c(-xlim,xlim), x.label = "Running Variable",
       y.label = "", title="")
dev.off()

bandwidth = rdrobust(data$partycount, X)$h_l
xlim = ceiling(bandwidth)
pdf("./outputs/R_meyersson_falsification_rdplot_rdrobust_partycount.pdf")
rdplot(data$partycount[abs(X)<=bandwidth], X[abs(X)<=bandwidth],
       p=1, kernel='triangular', x.lim=c(-xlim,xlim), x.label = "Running Variable",
       y.label = "", title="")
dev.off()

bandwidth = rdrobust(data$vshr_islam1994, X)$h_l
xlim = ceiling(bandwidth)
pdf("./outputs/R_meyersson_falsification_rdplot_rdrobust_vshr_islam1994.pdf")
rdplot(data$vshr_islam1994[abs(X)<=bandwidth], X[abs(X)<=bandwidth],
       p=1, kernel='triangular', x.lim=c(-xlim,xlim), x.label = "Running Variable",
       y.label = "", title="")
dev.off()

bandwidth = rdrobust(data$i89, X)$h_l
xlim = ceiling(bandwidth)
pdf("./outputs/R_meyersson_falsification_rdplot_rdrobust_i89.pdf")
rdplot(data$i89[abs(X)<=bandwidth], X[abs(X)<=bandwidth],
       p=1, kernel='triangular', x.lim=c(-xlim,xlim), x.label = "Running Variable",
       y.label = "", title="")
dev.off()

# Code snippet 6, Using rdrandinf on vshr_islam1994
txtStart("./outputs/R_meyersson_falsification_rdrandinf_vshr_islam1994.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
out = rdrandinf(data$vshr_islam1994, X, wl = -0.944, wr = 0.944)
txtStop()

# Code snippet 7, Using rdplot to Show the rdrandinf Effect for vshr_islam1994
txtStart("./outputs/R_meyersson_falsification_rdplot_rdrandinf_vshr_islam1994-COMMAND-ONLY.txt",
         commands=TRUE, results=FALSE, append=FALSE, visible.only=TRUE)
rdplot(data$vshr_islam1994[abs(X)<=0.944], X[abs(X)<=0.944],
       p=0, kernel='uniform', x.label="Running Variable",
       y.label="", title="")
txtStop()

pdf("./outputs/R_meyersson_falsification_rdplot_rdrandinf_vshr_islam1994.pdf")
rdplot(data$vshr_islam1994[abs(X)<=0.944], X[abs(X)<=0.944],
       p=0, kernel='uniform', x.lim=c(-2,2), x.label = "Running Variable",
       y.label = "", title="")
dev.off()

# Figure 6.5
pdf("./outputs/R_meyersson_falsification_rdplot_rdrandinf_lpop1994.pdf")
rdplot(data$lpop1994[abs(X)<=0.944], X[abs(X)<=0.944],
       p=0, kernel='uniform', x.lim=c(-2,2), x.label = "Running Variable",
       y.label = "", title="")
dev.off()

pdf("./outputs/R_meyersson_falsification_rdplot_rdrandinf_partycount.pdf")
rdplot(data$partycount[abs(X)<=0.944], X[abs(X)<=0.944],
       p=0, kernel='uniform', x.lim=c(-2,2), x.label = "Running Variable",
       y.label = "", title="")
dev.off()

pdf("./outputs/R_meyersson_falsification_rdplot_rdrandinf_vshr_islam1994.pdf")
rdplot(data$vshr_islam1994[abs(X)<=0.944], X[abs(X)<=0.944],
       p=0, kernel='uniform', x.lim=c(-2,2), x.label = "Running Variable",
       y.label = "", title="")
dev.off()

pdf("./outputs/R_meyersson_falsification_rdplot_rdrandinf_i89.pdf")
rdplot(data$i89[abs(X)<=0.944], X[abs(X)<=0.944],
       p=0, kernel='uniform', x.lim=c(-2,2), x.label = "Running Variable",
       y.label = "", title="")
dev.off()

pdf("./outputs/R_meyersson_falsification_rdplot_rdrandinf_merkezi.pdf")
rdplot(data$merkezi[abs(X)<=0.944], X[abs(X)<=0.944],
       p=0, kernel='uniform', x.lim=c(-2,2), x.label = "Running Variable",
       y.label = "", title="")
dev.off()

pdf("./outputs/R_meyersson_falsification_rdplot_rdrandinf_merkezp.pdf")
rdplot(data$merkezp[abs(X)<=0.944], X[abs(X)<=0.944],
       p=0, kernel='uniform', x.lim=c(-2,2), x.label = "Running Variable",
       y.label = "", title="")
dev.off()

# Code snippet 8, Using rdrobust with the Cutoff Equal to 1
txtStart("./outputs/R_meyersson_falsification_rdrobust_alternative-cutoff_c1.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdrobust(Y[X>=0], X[X>=0], c = 1)
txtStop()

# Code snippet 9, Using rdrobust for the Donut-Hole Approach
txtStart("./outputs/R_meyersson_falsification_rdrobust_donuthole.txt",
         commands=TRUE, results=TRUE, append=FALSE, visible.only=TRUE)
rdrobust(Y[abs(X)>=0.25], X[abs(X)>=0.25])
txtStop()
