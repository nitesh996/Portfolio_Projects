SELECT * FROM project_covid.covid_death_information ;
SELECT * FROM project_covid.covid_vaccination_information order by date;
select * from covid_19_data order by date;  


------------------------------------------------------------------------------------------------------------------
# What are the total no. of confirmed cases in diff nations till date
select location, sum(total_cases) from project_covid.covid_death_information group by 1;

# What are the no. of recovered cases in diff nations
# What are the total no. of confirmed cases in india
# what are the total no. of confirmed cases in india
# can we forecast trend-line for  covid- 19
# can we group indian states and find covid 19 hits
# find highest death rates in international level
# find the least death rates
# can we find variations in covid-19 cases around globe
# can we predict future and reference
---------------------------------------

# find the daily no. of confirmed cases
#total no. of conformed cases on a country & province level
# creating a country -level summary of conformed cases with rollup()
# calculating a running total
# calculate the daily % change i confirmed cases
# highest no. of confirmed cases

----------------------------------------
#taken##### total cases vs total deaths globally
select sum(total_cases), sum(total_deaths), 100*sum(total_deaths)/sum(total_cases) as death_percencentage from project_covid.covid_death_information ;

#taken##### sum(new_deaths) continent wise
select continent, sum(new_deaths) from project_covid.covid_death_information where continent is not null group by 1 order by 2 limit 6;

#taken##### max_cases, location wise
select location, population, max(total_cases) as max_cases, 100*max(total_cases)/population as percentage_pop_infected
from  project_covid.covid_death_information
group by 1,2
order by 4 desc;
-------------------------------------------------------------
###### cases vs deaths, datewise
select location,str_to_date(date,'%d-%m-%y'), population, total_cases, total_deaths, 100*total_deaths/total_cases as percentage_deaths
from project_covid.covid_death_information
order by 2;

###### total cases vs population
select location, str_to_date(date,'%d-%m-%y') total_cases, population, 100*total_cases/population as infection_rate
from project_covid.covid_death_information
order by 2 desc; 

###### highest infection rate in which country
select location, max(total_cases), population, 100*max(total_cases)/population
from project_covid.covid_death_information
group by 1
order by 4 desc;

###### highest deat count 
select location, max(cast(total_deaths as unsigned)) 
from project_covid.covid_death_information
group by 1
order by 2 desc;

###### find percentage of deaths on total population till date
select  sum(new_cases), sum(new_deaths), 100*sum(new_deaths)/sum(new_cases), sum(total_cases), sum(total_deaths), 100*sum(total_deaths)/sum(total_cases)
from project_covid.covid_death_information;

###### find percentage_death over new total_cases and new cases being added each day globally 
select str_to_date(date, '%d-%m-%y') as date, sum(total_cases), sum(new_cases), sum(total_deaths), 100*sum(total_deaths)/sum(total_cases) as per_death_tot_cases, 100*sum(total_deaths)/sum(new_cases) as per_death_new_cases 
from project_covid.covid_death_information
group by 1
order by 1;

######## find date for each countries when the vaccination started first
select location, date, new_vaccination
from
(select *, row_number() over(partition by location order by rankk ) as roww
from (select location, str_to_date(date,'%d-%m-%y') as date, cast(new_vaccinations as unsigned) as new_vaccination, dense_rank() over(partition by location order by str_to_date(date,'%d-%m-%y') ) as rankk
from project_covid.covid_vaccination_information
where cast(new_vaccinations as unsigned)<>0) as aaa
where rankk=1) as bbb
where roww=1
order by 2;

######## Now add a col for cumulative addition of new_vaccinations for each day
select a.location, a.date, a.population, b.new_vaccinations, sum(cast(new_vaccinations as unsigned)) over(partition by location)
from project_covid.covid_death_information  as a join project_covid.covid_vaccination_information as b on a.location=b.location and a.date=b.date
where a. continent is not null and a.location='albania'
order by 1;

----------------------------------------------------------------------------------------------
select location, date, total_cases from project_covid.covid_death_information order by 2; 
SELECT CONVERT(date, date) from  project_covid.covid_death_information;
select str_to_date(date,'%mm-%dd-%yyyy') from project_covid.covid_death_information;
select cast(date as date) from project_covid.covid_death_information;
select TO_DATE(date,'DD-MM-YYYY') from project_covid.covid_death_information;
select str_to_date(date,'%d-%m-%y') from project_covid.covid_death_information;
-------------------------------------------------------------------




