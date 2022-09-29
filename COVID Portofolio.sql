select * from PortofolioProject..CovidDeath
order by 3,4

select * from PortofolioProject..covidvaccinations
order by 3,4

select location,date, total_cases, new_cases, total_deaths, population 
from PortofolioProject..CovidDeath
order by 1,2

--Looking at Total Death vs Total Cases in Asia
select location, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortofolioProject..CovidDeath
where continent like 'asia'

--Looking at Total Case vs Population in Asia
select location,date, total_cases, population, (total_cases/population)*100 as TotalCasePercentage
from PortofolioProject..CovidDeath
where continent like 'asia'
order by 1,2

--Based on Highest Total Case Percentage in Asia
select location, population, max(total_cases) as HighestInfectionCount,  max(total_cases/population)*100 as HighestTotalCasePercentage
from PortofolioProject..CovidDeath
where continent like 'asia'
group by location, population
order by 4 desc

select location, population, date, max(total_cases) as HighestInfectionCount,  max(total_cases/population)*100 as PercentagePopulationInfected
from PortofolioProject..CovidDeath
where continent like 'asia'
group by location, population,date
order by 5 desc

--Showing Highest Deaths Count in Asia
select top 10 location, max(cast(total_deaths as int)) as HighestDeathCount
from PortofolioProject..CovidDeath
where continent like 'asia'
group by location
order by 2 desc

--Showing total death count in Asia
select continent, max(cast(total_deaths as int)) as TotalDeathCount
from PortofolioProject..CovidDeath
where continent like 'asia'
group by continent
order by 2 desc

--Deaths percentage by new deaths vs new cases in Asia
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, 
(sum(cast(new_deaths as int))/sum(total_cases))*100 as NewDeathPercentage
from PortofolioProject..CovidDeath
where continent like 'Asia'

--Looking at Total Population vs Vaccinations (Indonesia)
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated 
--(rollingpeoplevaccinated/population)*100
from PortofolioProject..CovidDeath dea
join PortofolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent like 'Indonesia'

--Use CTE
with PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinations) as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortofolioProject..CovidDeath dea
join PortofolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.location like 'Indonesia'
)
select *, (RollingPeopleVaccinations/Population)*100 as PercentagePeopleVaccinated
from popvsvac
