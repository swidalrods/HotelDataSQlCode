
--Combine all data sets
with CombineHotelData as (
select * from [PortfolioProject].[dbo].[Hotel2018Data]
union
select * from [PortfolioProject].[dbo].[Hotel2019Data]
union
select * from [PortfolioProject].[dbo].[Hotel2020Data])

select  * from CombineHotelData
left join [PortfolioProject].[dbo].[Market_Segment_Data]
on CombineHotelData.market_segment=Market_Segment_Data.market_segment
left join [PortfolioProject].[dbo].[Meal_Cost_Data]
on CombineHotelData.meal=Meal_Cost_Data.meal



-- Calculate Revenue
with CombineHotelData as (
select * from [PortfolioProject].[dbo].[Hotel2018Data]
union
select * from [PortfolioProject].[dbo].[Hotel2019Data]
union
select * from [PortfolioProject].[dbo].[Hotel2020Data])

select  arrival_date_year,hotel,round(sum((stays_in_weekend_nights+stays_in_week_nights)*adr*(1-Discount)),2)  as Revenue
from CombineHotelData
left join [PortfolioProject].[dbo].[Market_Segment_Data]
on CombineHotelData.market_segment=Market_Segment_Data.market_segment
left join [PortfolioProject].[dbo].[Meal_Cost_Data]
on CombineHotelData.meal=Meal_Cost_Data.meal
Group by arrival_date_year,hotel
order by  arrival_date_year,hotel


--calculate total nights
with CombineHotelData as (
select * from [PortfolioProject].[dbo].[Hotel2018Data]
union
select * from [PortfolioProject].[dbo].[Hotel2019Data]
union
select * from [PortfolioProject].[dbo].[Hotel2020Data])

select 
sum(stays_in_weekend_nights+stays_in_week_nights) as TotalNights  
from CombineHotelData


--calculate Average adr
with CombineHotelData as (
select * from [PortfolioProject].[dbo].[Hotel2018Data]
union
select * from [PortfolioProject].[dbo].[Hotel2019Data]
union
select * from [PortfolioProject].[dbo].[Hotel2020Data])

select 
round(AVG(adr),2) as Avgerageadr
from CombineHotelData


--Calculate Average Discount
with CombineHotelData as (
select * from [PortfolioProject].[dbo].[Hotel2018Data]
union
select * from [PortfolioProject].[dbo].[Hotel2019Data]
union
select * from [PortfolioProject].[dbo].[Hotel2020Data])

select 
AVG(Discount)*100 as AverageDiscount
from CombineHotelData
left join [PortfolioProject].[dbo].[Market_Segment_Data]
on CombineHotelData.market_segment=Market_Segment_Data.market_segment
left join [PortfolioProject].[dbo].[Meal_Cost_Data]
on CombineHotelData.meal=Meal_Cost_Data.meal


--Calculate TotalCarSpace and ParkingPercentage
with CombineHotelData as (
select * from [PortfolioProject].[dbo].[Hotel2018Data]
union
select * from [PortfolioProject].[dbo].[Hotel2019Data]
union
select * from [PortfolioProject].[dbo].[Hotel2020Data])

select  arrival_date_year,hotel,
sum(required_car_parking_spaces)as TotalCarSpaces,
sum(required_car_parking_spaces)/sum(stays_in_weekend_nights+stays_in_week_nights)*100 as ParkingPercentage
from CombineHotelData
left join [PortfolioProject].[dbo].[Market_Segment_Data]
on CombineHotelData.market_segment=Market_Segment_Data.market_segment
left join [PortfolioProject].[dbo].[Meal_Cost_Data]
on CombineHotelData.meal=Meal_Cost_Data.meal
group by  arrival_date_year,hotel
order by hotel