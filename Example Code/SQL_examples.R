library(sqldf)

order_details <- read.csv("orders/order_details.csv")
orders <- read.csv("orders/orders.csv")
territories <- read.csv("orders/territories.csv")
regions <- read.csv("orders/regions.csv")
employee_territories <- read.csv("orders/employee_territories.csv")
employees <- read.csv("orders/employees.csv")
customers <- read.csv("orders/customers.csv")
shippers <- read.csv("orders/shippers.csv")
suppliers <- read.csv("orders/suppliers.csv")
products <- read.csv("orders/products.csv")
categories <- read.csv("orders/categories.csv")


# Simplest example: make a copy of a dataset
order2 <- sqldf("SELECT * FROM orders")

# Next, select columns
order_some <- sqldf("SELECT orderID, customerID 
                    FROM orders1")

# sort
order_sort <- sqldf("SELECT * 
                    FROM orders 
                    ORDER BY orderDate")

# filtering
low_ship <- sqldf("SELECT * from orders 
                  WHERE freight < 10")

# calculated fields
order_revenue <- sqldf("SELECT *, 
                       unitPrice*quantity*(1-discount) 
                       AS revenue 
                       FROM order_details ")

# summaries
order_summary <- sqldf("SELECT count(orderID), customerID 
                       FROM orders 
                       GROUP BY customerID")

#join example
full_orders <- sqldf("SELECT * 
                     FROM orders 
                     INNER JOIN order_details 
                     WHERE orders.orderID = order_details.orderID")

