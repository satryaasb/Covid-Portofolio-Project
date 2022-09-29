select *
from PortofolioProject..GlobalSuperStoreOrders
order by 1

select [order id], count(*)
from PortofolioProject..GlobalSuperStoreOrders
group by [order id]
having count(*) >1

select *
from PortofolioProject..GlobalSuperStoreOrders
where [order id] = 'AE-2014-3830'

select *
from PortofolioProject..GlobalSuperStoreOrders
where [Ship Date] < [Order Date]

select distinct [ship mode] 
from PortofolioProject..GlobalSuperStoreOrders

select min(a.numofdays), max(a.numofdays)
from (select datediff (day, [order date], [ship date]) as NumOfDays, *
from PortofolioProject..GlobalSuperStoreOrders
where [Ship Mode]= 'Same Day') a

select min(a.numofdays), max(a.numofdays)
from (select datediff (day, [order date], [ship date]) as NumOfDays, *
from PortofolioProject..GlobalSuperStoreOrders
where [Ship Mode]= 'First Class') a

select min(a.numofdays), max(a.numofdays)
from (select datediff (day, [order date], [ship date]) as NumOfDays, *
from PortofolioProject..GlobalSuperStoreOrders
where [Ship Mode]= 'Second Class') a

select min(a.numofdays), max(a.numofdays)
from (select datediff (day, [order date], [ship date]) as NumOfDays, *
from PortofolioProject..GlobalSuperStoreOrders
where [Ship Mode]= 'Standard Class') a

