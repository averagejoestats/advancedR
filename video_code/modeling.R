
# Modeling
# - multiple linear regression (Ames Housing Data)
# - logistic regression (Titanic Data)

library(dplyr)

# Ames Housing Data
ames <- read.csv("../datasets/ames_housing.csv")
head(ames, n = 5)
hist(ames$Sale_Price)

# plot price against size of house
plot( ames$Gr_Liv_Area, ames$Sale_Price )

# investigate the outliers
ames |> filter( Gr_Liv_Area > 4000 ) |> arrange( Sale_Price )

ames |> group_by( Neighborhood ) |> 
    summarize( price = mean( Sale_Price ) ) |>
    print( n = Inf )

ii <- ames$Neighborhood == "Edwards"
plot( ames$Gr_Liv_Area[ii], ames$Sale_Price[ii] )


# find the outlier indices
ss <- ames$Gr_Liv_Area > 4000 & ames$Sale_Price < 300000
ames[ss,]

# fit some multiple linear regression models
m1a <- lm( Sale_Price ~ Gr_Liv_Area, data = ames )
m1b <- lm( Sale_Price ~ Gr_Liv_Area, data = ames, subset = !ss )
summary(m1a)
summary(m1b)

plot( ames$Gr_Liv_Area, ames$Sale_Price )
abline(m1a, col = "blue")
abline(m1b, col = "magenta")

# see other variables
head(ames, n = 5)

# investigate bathrooms and garage area
table( ames$Overall_Cond )
table( ames$Full_Bath )
table( ames$Half_Bath )
hist( ames$Total_Bsmt_SF, breaks = 100 )
hist( ames$Garage_Area, breaks = 100 )
hist( ames$Pool_Area )
table( ames$Pool_Area > 0 )

ames$Year_Sold_fac <- as.factor( ames$Year_Sold )

m2 <- lm( 
    Sale_Price ~ 
        Gr_Liv_Area + Total_Bsmt_SF + Full_Bath + Half_Bath + 
        Garage_Area + Bedroom_AbvGr + Year_Sold_fac + Overall_Cond,
    data = ames,
    subset = !ss 
)
summary(m2)

levels( as.factor( ames$Overall_Cond ) )

# look at residuals
length( m2$residuals )
nrow(ames)
head( m2$residuals )          
rownames(ames)
ames[ names(m2$residuals), "resids_m2" ] <- m2$residuals

par(mfrow=c(2,3))
plot( ames$Gr_Liv_Area, ames$resids_m2 )
plot( ames$Total_Bsmt_SF, ames$resids_m2 )
plot( ames$Full_Bath, ames$resids_m2 )
plot( ames$Half_Bath, ames$resids_m2 )
plot( ames$Garage_Area, ames$resids_m2 )
plot( ames$Bedroom_AbvGr, ames$resids_m2 )

# Neighborhood Analysis
m3 <- lm( 
    Sale_Price ~ 
        Gr_Liv_Area + Total_Bsmt_SF + Full_Bath + Half_Bath + 
        Garage_Area + Bedroom_AbvGr + Year_Sold_fac + Overall_Cond + 
        Neighborhood,
    data = ames,
    subset = !ss 
)
summary(m3)

# anova
anova(m3)
anova(m2,m3)

head( as.factor(ames$Neighborhood) )

# compare the coefficients
cbind( m2$coefficients[1:7], m3$coefficients[1:7] )

# random effect for neighborhood?
m4 <- lme4::lmer( 
    Sale_Price ~ 
        Gr_Liv_Area + Total_Bsmt_SF + Full_Bath + Half_Bath + 
        Garage_Area + Bedroom_AbvGr + Overall_Cond + 
        (1|Neighborhood),
        data = ames, subset = !ss
)
summary(m4)

# compare coefficients
cbind( m2$coefficients[1:7], m3$coefficients[1:7], m4@beta[1:7] )











# Titanic Data
titanic <- read.csv("../datasets/titanic5.csv")

# Take a look and compute some summary stats
head(titanic)
table( titanic$Survived )
table( titanic$Sex, titanic$Survived )
table( titanic$Class, titanic$Survived )
hist( titanic$Age )
table( titanic$Age, titanic$Survived )

# calculate proportion survived
sv <- table( titanic$Age, titanic$Survived )
#sv$prop <- sv[,2]/(sv[,1] + sv[,2])
sv <- cbind(sv, sv[,2]/(sv[,1] + sv[,2]) )

#sv <- table( titanic$Age, titanic$Survived )
#sv <- as.data.frame(sv)
#head(sv)

# let's use dplyr
sv <- titanic |> 
    group_by(Age) |> 
    summarize( 
        died = sum(Survived==0),
        lived = sum(Survived==1),
        prop = lived/(died+lived)
    )
sv
plot( sv$Age, sv$prop )


# modeling
head(titanic)

m1 <- glm(Survived ~ Sex+Class+Age, data=titanic, family="binomial")
summary(m1)

m2 <- glm( Survived ~ Sex+as.factor(Class)+Age, data=titanic, family="binomial")
summary(m2)
# or
titanic$Class <- as.factor( titanic$Class )
m2 <- glm( Survived ~ Sex+Class+Age, data=titanic, family="binomial")
summary(m2)

# predict function
titanic$preds_m2 <- predict( m2, titanic )
head( titanic )

logit <- function(p) log( p/(1-p) )
expit <- function(x) exp(x)/(1+exp(x))

titanic$probs_m2 <- expit( titanic$preds_m2 )
head(titanic[,c("Sex","Class","Age","preds_m2","probs_m2","Survived")], 
     n = 20)
tail(titanic[,c("Sex","Class","Age","preds_m2","probs_m2","Survived")], 
     n = 20)

# these assignments work even though there are some NAs in Age
dim(titanic)
length(m2$residuals )
sum( is.na( titanic$Age ) )
length( predict(m2,titanic) )

# should check that the missing ages don't skew the data too much
table( titanic$Survived, is.na(titanic$Age) )

# let's try a model with interactions
m3 <- glm( Survived ~ Sex*Class+Age, data=titanic, family="binomial")
summary(m3)

pred_df <- expand.grid( 
    Sex = c("female","male"),
    Class = as.factor(c(1,2,3)),
    Age = 30
)
pred_df

pred_df$probs_m3 <- expit( predict(m3, pred_df) )
pred_df

# compare this to the sample proportions
titanic |> group_by( Class, Sex ) |>
    summarize( 
        died = sum(Survived==0),
        lived = sum(Survived==1),
        prop = lived/(died+lived),
        avg_age = mean( Age, na.rm = TRUE )
    )



