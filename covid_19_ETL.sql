use project_covid;
SELECT * FROM project_covid.covid_death_information ;
SELECT * FROM project_covid.covid_vaccination_information order by date;
select * from covid_19_data order by date;  


------------------------------------------------------------------------------------------------------------------
# What are the total no. of confirmed cases in diff nations till date
select location as countries, date, total_live_cases
from 
(
select *, dense_rank() over(partition by aaa.location order by str_to_date(aaa.date, '%d-%m-%Y') desc) as rankk
from
(
 select location, date, population, total_cases, 
 lag(total_cases,1) over()+new_cases-new_deaths as total_live_cases
 from project_covid.covid_death_information
)aaa
)bbb
where rankk=1;

# What are the total no. of confirmed cases in india till date
# What are total no. of confirmed cases in india state wise
# What are the no. of recovered cases in diff nations till date
# can we forecast trend-line for  covid- 19
# can we group indian states and find covid 19 hits till date
# find highest death rates in international level till date
# find the least death rates in international level till date
# can we find variations in covid-19 cases around globe
# can we predict future and reference
---------------------------------------
# find the daily no. of confirmed cases 
select location, str_to_date(date, '%d-%m-%y') as date, new_cases from project_covid.covid_death_information;

# find pattern of new_deaths on daily basis
# increase/decrease in total no. of confirmed cases on monthly basis for each country
# calculating a running total of covid cases in india on monthly basis
# calculate the daily % change in confirmed cases as compared to previous day/week
----------------------------------------
##### total cases vs total deaths globally
select sum(total_cases), sum(total_deaths), 100*sum(total_deaths)/sum(total_cases) as percentage_deaths from project_covid.covid_death_information;

##### sum(new_deaths) continent wise
select continent, sum(new_deaths) from project_covid.covid_death_information group by 1 order by 2 limit 6;

##### highest infection rate country wise
select location, population,  max(total_cases) as highest_infection_count, 100*max(total_cases)/population as percent_pop_affected 
from project_covid.covid_death_information 
group by 1
order by 1;  

##### percentage of population infected daywise/monthwise
select location, str_to_date(ccc.date,'%d-%m-%Y') as date, population, total_cases as total_registered_cases, lag(bbb,1) over() as total_live_cases,100*lag(bbb,1) over()/population as per_pop_infected
from (
	  select location,date,population, total_cases, new_cases-new_deaths as aaa, lead(new_cases-new_deaths,1) over() + total_cases as bbb 
	  from  project_covid.covid_death_information
	  ) as ccc
where population <> 0;
----------------------------------------------------------------------------------------------------------------------------------------------------------

##### cases vs deaths, datewise
##### total cases vs population
##### highest infection rate in which country
##### highest deat count
##### find percentage of deaths on total population till date
##### find percentage_death over new total_cases and new cases being added each day globally 
##### find date for each countries when the vaccination started first
##### Now add a col for cumulative addition of new_vaccinations for each day
