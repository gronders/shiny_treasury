library(shinyjs)
library(shroomDK)
library(data.table)
library(plotly)
library(dplyr)
library(reactable)
library(shinyWidgets)

example_data <- data.frame(
  x = 1:100, 
  y = abs(rnorm(100)),
  z = abs(ceiling(rnorm(100))),
  a = as.factor(sample(LETTERS[1:5], 100, replace = TRUE))
)

csvDownloadButton <- function(id, filename = "data.csv", label = "Download as CSV") {
  tags$button(
    tagList(icon("download"), label),
    onclick = sprintf("Reactable.downloadDataCSV('%s', '%s')", id, filename)
  )
}

# Save an object to a file
# saveRDS(test, file = "my_data.rds")
# Restore the object
test = readRDS(file = "my_data.rds")
test$ADDRESS_FIX =paste0(substring(test$ADDRESS,0,10),'...')

# 
# 
# test = auto_paginate_query(query = "
# with 
# shit_coin_excluder as (
#   select
#   contract_address as good_token,
#   count(*)
#   from ethereum.core.fact_event_logs
#   group by 1 
#   having count(*) > 20000    
# ),
# addresses as (
# select distinct address, project_name, address_name, label_subtype
#   from crosschain.core.address_labels
#   where label_subtype in ('treasury', 'hot_wallet', 'pool')
#   and blockchain = 'ethereum'
# ),
# base_table as (
# select 
# a.address,
# a.project_name, 
# a.address_name,
# case when a.label_subtype = 'treasury' then 'Treasury'
# when a.label_subtype = 'hot_wallet' then 'Central Exchange'
# when a.label_subtype = 'pool' then 'Pool'
# else NULL
# end as wallet_type,
# sum(coalesce(b.usd_value_now,0)) as usd_value
# from ETHEREUM.CORE.EZ_CURRENT_BALANCES b
# inner join addresses a
# on a.address = b.user_address
#   where decimals != 0 
#   and has_price = 'TRUE' 
#   and (contract_address in (select good_token from shit_coin_excluder) or contract_address is null)
#   and last_recorded_price > current_date() - 5
# group by 1,2,3,4
# ),
# base_addresses as (
# select 
# distinct
# address,
# project_name,
# address_name,
# wallet_type
# from base_table 
# qualify(ROW_NUMBER() over(PARTITION BY wallet_type
# ORDER BY
#     usd_value DESC)) < 101
# )
# select 
# a.wallet_type,
# a.address,
# a.project_name,
# a.address_name, 
# b.SYMBOL,
# b.TOKEN_NAME,
# sum(coalesce(b.CURRENT_BAL,0)) as token_balance,
# sum(coalesce(b.usd_value_now,0)) as usd_value
# from ETHEREUM.CORE.EZ_CURRENT_BALANCES b
# inner join base_addresses a
# on a.address = b.user_address
# where decimals != 0 
# and has_price = 'TRUE' 
# and (contract_address in (select good_token from shit_coin_excluder) or contract_address is null)
# and last_recorded_price > current_date() - 5
# group by 1,2,3,4,5,6
# having token_balance > 0
# order by 8 desc", 
#                     api_key = '5a0702fb-f3fb-4241-8221-ba8207203f3a')
#                     