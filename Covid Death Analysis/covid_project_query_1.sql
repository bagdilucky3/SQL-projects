--SELECT *
--FROM covid_project..CovidDeaths$
--order by 3,4

--SELECT *
--FROM covid_project..CovidVaccinations$
--order by 3,4

-- Here we are combining data 

--comparing total number of deaths to the total number of cases

--SELECT location,date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--From covid_project..CovidDeaths$
--Where location='India'
--order by 1,2



-- comparing total number of cases to the total population

--SELECT location,date, total_cases, population, (total_cases/population)*100 as DeathPercentage
--From covid_project..CovidDeaths$
--Where location='India'
--order by 1,2



--finding which country has highest infection rate

--SELECT location,max(total_cases)as MaxInfectionCount,population, MAX(total_cases/population)*100 as InfectedPopulationPercentage
--From covid_project..CovidDeaths$
--where continent is not null
--Group by location, population
--order by 4 desc



--Country with highest death rate

--Select location, max(cast(total_deaths AS INT)) as MaxDeathsCount,population, max(total_cases) as MaxTotalCases, (max(total_deaths)/max(total_cases))*100 as MaxDeathPercentage
--From covid_project..CovidDeaths$
--where continent is not null
--Group by location, population
--order by 5 desc



--Situation of different continents

--Select location, max(cast(total_deaths AS INT)) as MaxDeathsCount, max(total_cases) as MaxTotalCases, (max(total_deaths)/max(total_cases))*100 as MaxDeathPercentage
--From covid_project..CovidDeaths$
--where continent is null and location != 'world'
--Group by location
--order by 4 desc


--Using Covid_vaccinations table

--Select death.location, death.date, death.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int)) over (partition by death.location order by death.location, death.date ) as total_vaccinations
--from covid_project..CovidDeaths$ as death
--join covid_project..CovidVaccinations$ as vac
-- on death.location = vac.location 
-- and death.date = vac.date
 --where death.continent is not null
 --order by 1, 2, 4


 --Using CTE to find percentage of people vaccinated

 --With percentage_popVaccinated (location, date, population, new_vaccinations, total_vaccinations)
 --as
 --(
 --Select death.location, death.date, death.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int)) over (partition by death.location order by death.location, death.date ) as total_vaccinations
--from covid_project..CovidDeaths$ as death
--join covid_project..CovidVaccinations$ as vac
 --on death.location = vac.location 
 --and death.date = vac.date
 --where death.continent is not null
 --)

 --Select location , (total_vaccinations/population) *100
 --from percentage_popVaccinated
 --order by 1


 --Using TEMP Table 

 --Drop table if exists #vaccination_population_percentage
 --Create table #vaccination_population_percentage
-- ( Location nvarchar(255),
  -- Date datetime,
  -- Population numeric, 
  -- New_Vaccinations numeric,
  -- Total_Vaccinations numeric
   --)

 --Insert into #vaccination_population_percentage
 --Select death.location, death.date, death.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int)) over (partition by death.location order by death.location, death.date ) as total_vaccinations
--from covid_project..CovidDeaths$ as death
--join covid_project..CovidVaccinations$ as vac
--on death.location = vac.location 
-- and death.date = vac.date
--where death.continent is not null
--select *, (total_vaccinations/ Population) * 100
--from #vaccination_population_percentage
--order by Location

