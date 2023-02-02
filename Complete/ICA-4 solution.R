# A solution to ICA 4 
library(sqldf)
complaint <- read.csv("complaints.csv")

# (a) and (b)
year <- data.frame("year" = min(complaint_sum$ComplaintYear):max(complaint_sum$ComplaintYear))

cust_list <- data.frame("customer" = 1:432)

year_cust <- sqldf("SELECT *
                   FROM year
                   INNER JOIN cust_list")

complaint_sum <- sqldf("SELECT CustomerID, ComplaintYear, Count(1) AS count, ComplaintYear+1 AS PredictiveYear
                       FROM complaint
                       GROUP BY CustomerID, ComplaintYear")

complaint_total <- sqldf("SELECT year_cust.customer, year_cust.year,
                        CASE WHEN complaint_sum.count IS NULL THEN 0
                        ELSE complaint_sum.count END AS count
                         FROM year_cust
                         LEFT JOIN complaint_sum
                         ON year_cust.customer = complaint_sum.CustomerID
                         AND year_cust.year = complaint_sum.ComplaintYear
                         ORDER BY year_cust.customer, year_cust.year")
c_o2 <- complaint_total

complaint_final <- sqldf("SELECT complaint_total.year, complaint_total.customer, complaint_total.count, SUM(c_o2.count) AS cumul_total
                         FROM complaint_total
                         INNER JOIN c_o2
                         ON complaint_total.customer = c_o2.customer
                         WHERE complaint_total.year >= c_o2.year
                         GROUP BY complaint_total.customer, complaint_total.year")

