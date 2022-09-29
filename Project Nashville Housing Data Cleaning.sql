select *
from PortofolioProject.dbo.NashvilleHousingg

--Standarize Data Format

select SaleDate, saledateconverted
from PortofolioProject.dbo.NashvilleHousingg

alter table nashvillehousingg
add SaleDateConverted date;

update NashvilleHousingg
set saledateconverted = convert(date,saledate)

--Populate Address data

select *
from PortofolioProject.dbo.NashvilleHousingg
where PropertyAddress is null
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortofolioProject.dbo.NashvilleHousingg a
join PortofolioProject.dbo.NashvilleHousingg b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set propertyaddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortofolioProject.dbo.NashvilleHousingg a
join PortofolioProject.dbo.NashvilleHousingg b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

--Breaking out Address into individual Columns (Address, City, State)

select PropertyAddress
from PortofolioProject.dbo.NashvilleHousingg
--where PropertyAddress is null
--order by ParcelID

select
substring(propertyaddress, 1,CHARINDEX(',', propertyaddress)-1) as adress,
substring(propertyaddress, CHARINDEX(',', propertyaddress)+1, len(propertyaddress)) as City
from PortofolioProject.dbo.NashvilleHousingg

alter table nashvillehousingg
add PropertySplitAddress nvarchar(255);

update NashvilleHousingg
set PropertySplitAddress = substring(propertyaddress, 1,CHARINDEX(',', propertyaddress)-1)

alter table nashvillehousingg
add PropertySplitCity nvarchar(255);

update NashvilleHousingg
set PropertySplitCity = substring(propertyaddress, CHARINDEX(',', propertyaddress)+1, len(propertyaddress))

select owneraddress
from PortofolioProject.dbo.NashvilleHousingg

select
PARSENAME(replace(owneraddress,',','.'),3),
PARSENAME(replace(owneraddress,',','.'),2),
PARSENAME(replace(owneraddress,',','.'),1)
from PortofolioProject.dbo.NashvilleHousingg

alter table nashvillehousingg
add OwnerSplitAddress nvarchar(255);

update NashvilleHousingg
set OwnerSplitAddress = PARSENAME(replace(owneraddress,',','.'),3)

alter table nashvillehousingg
add OwnerSplitCity nvarchar(255);

update NashvilleHousingg
set OwnerSplitCity = PARSENAME(replace(owneraddress,',','.'),2)

alter table nashvillehousingg
add OwnerSplitState nvarchar(255);

update NashvilleHousingg
set OwnerSplitState = PARSENAME(replace(owneraddress,',','.'),1)

select distinct(soldasvacant)
from PortofolioProject.dbo.NashvilleHousingg

--Change N and Y to No and Yes in "SoldAs Vacant" field

select distinct(soldasvacant), count(soldasvacant)
from PortofolioProject.dbo.NashvilleHousingg
group by SoldAsVacant
order by 2

select soldasvacant,
case when soldasvacant = 'Y' then 'Yes'
	when soldasvacant = 'N' then 'No'
	else soldasvacant
	end
from PortofolioProject.dbo.NashvilleHousingg

update NashvilleHousingg 
set soldasvacant = case when soldasvacant = 'Y' then 'Yes'
	when soldasvacant = 'N' then 'No'
	else soldasvacant
	end

--Remove Unused Columns

select *
from PortofolioProject.dbo.NashvilleHousingg

alter table PortofolioProject.dbo.NashvilleHousingg
drop column Saledate, owneraddress, propertyaddress