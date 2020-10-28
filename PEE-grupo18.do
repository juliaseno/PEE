* --------------- PEE - Grupo 18 - Julia Seno de Assis ---------------  
* Criando log file
* IMPORTANTE: mudar o diretorio de acordo com o seu computador *
log using "\\Mac\Home\Desktop\PEE\STATA\Grupo_18_logfile.log", replace
* ou se voce nao tem o arquivo", text"//", replace" se tem

* Definindo working Directory

cd "\\Mac\Home\Desktop\PEE\STATA" 

* -- base de dados -- *

* a base de dados foi montada com base em dados do Banco Mundial e da OMS


// append using "\\Mac\Home\Desktop\PEE\STATA\14demaio.dta"



* -- baixando comandos de interesse -- *
* so rodar uma vez

*ssc install outreg2

*ssc install xtivreg2

*ssc install dmexogxt

* * * --------------- DESCREVENDO AMOSTRA --------------- * * *

* 10 anos e 46 paises = 460 observacoes

sum Year 


* * * --------------- RENOMEANDO VARIAVEIS --------------- * * * 

// rodei da primeira vez e salvei a base com os novos nomes, por isso estao como comentarios
// deixei no codigo porque tem a explicacao de todas as variaveis usadas

// rename old_varname new_varname


*rename PopulationtotalSPPOPTOTL popt // renomeando var pop total

*rename PopulationmaleSPPOPTOTLMA popm // renomeando var pop masc

*rename PopulationfemaleSPPOPTOTLF popf // renomeando var pop fem

*rename Soma somafem // renomeando var somo de feminicidios por ano em cada pais

*rename Unemploymentfemaleoffemale desmpfem // desemprego mulheres

*rename Unemploymentmaleofmalelab desmpmas // desemprego homens

*rename Unemploymenttotaloftotall desmptot // desemprego total

*rename Ruralpopulation rural //% pop area rural

*rename Literacyrateadultmale alfmas // homens alfabetizados

*rename Literacyrateadultfemale alffem // mulheres alfabetizados

*rename Literacyrateadulttotal alftot // total alfabetizados

*rename Literacyrateadulttotal alftot // total alfabetizados

*rename Educationalattainmentatleast lsfem // Educational attainment, at least completed lower secondary, population 25+, female (%) (cumulative)

*rename AG lsmas // Educational attainment, at least completed lower secondary, population 25+, male (%) (cumulative)

*rename AF lstot // Educational attainment, at least completed lower secondary, population 25+, total (%) (cumulative)

*rename GINIindexWorldBankestimate gini // GINI index (World Bank estimate) 

*rename CPIAgenderequalityrating1lo CPIA // CPIA gender equality rating (1=low to 6=high) 

*rename Lawmandatesnondiscriminationba lei // Law mandates nondiscrimination based on gender in hiring (1=yes; 0=no) 

*rename Agedependencyratioofworkin agedep // Age dependency ratio (% of working-age population)
// Age dependency ratio is the ratio of dependents--people younger than 15 or older than 64--to the working-age population--those ages 15-64. 
// Data are shown as the proportion of dependents per 100 working-age population.


*rename Proportionofseatsheldbywomen seats // Proportion of seats held by women in national parliaments (%)

*rename GDPpercapitaPPPcurrentinte ppp // GDP per capita, PPP (current international $) 

*rename IndividualsusingtheInternet internet // Individuals using the Internet (% of population)

*rename Informalemploymentmaleoft infmas // Informal employment, male (% of total non-agricultural employment) 

*rename Informalemploymentfemaleof inffem // Informal employment, female (% of total non-agricultural employment)

*rename Informalemploymentoftotaln inftot // Informal employment (% of total non-agricultural employment) 

*rename Lifeexpectancyatbirthfemale expfem // Life expectancy at birth, female (years)

*rename Lifeexpectancyatbirthmaley expmas // Life expectancy at birth, male (years)

*rename Lifeexpectancyatbirthtotal exptot // Life expectancy at birth, total (years)

*rename Lifetimeriskofmaternaldeath deathm // Lifetime risk of maternal death (%)

*rename Adjustednetenrollmentratepri prim // Adjusted net enrollment rate, primary (% of primary school age children)

*rename Populationages1564 PEA // pop entre 15-64 anos

* * * --------------- VARIAVEIS --------------- * * * 

* --------------- Criando feminicidio a cada 100mil mulheres

gen fem1 = somafem/popf // feminicidio por mulher

gen fem = fem1*100000 // feminicidio por 100.000 mulheres

* variavel para o pais Cyprus foi incompleta = tirar Cypros da amostra
drop if Country=="Cyprus"
* variavel para o pais Dominica foi incompleta = tirar Dominica da amostra
drop if Country=="Dominica"
* problema com egito... dados muito subestimados 
drop if Country=="Egypt" 

* --------------- Criando dummies 

* ------- ANOS
* OBS - foi necessario gerar as dummies de tempo porque alguns comandos utilizados
* nao aceitam o uso de i.year, como o comando "dmexogxt"
gen a06=0
replace a06=1 if Year==2006

gen a07=0
replace a07=1 if Year==2007

gen a08=0
replace a08=1 if Year==2008

gen a09=0
replace a09=1 if Year==2009

gen a10=0
replace a10=1 if Year==2010

gen a11=0
replace a11=1 if Year==2011

gen a12=0
replace a12=1 if Year==2012

gen a13=0
replace a13=1 if Year==2013

gen a14=0
replace a14=1 if Year==2014

gen a15=0
replace a15=1 if Year==2015

* REDUNDANTE DE PROPOSITO - 10 DUMMIES EM VEZ DE 9...

* ------- Grupos de paises
tab Country

gen europa=0
replace europa=1 if Country=="Austria" | Country=="Belgium" | Country=="Croatia"
replace europa=1 if Country=="Czech Republic" | Country=="Denmark" | Country=="Estonia"
replace europa=1 if Country=="Finland" | Country=="Germany" | Country=="Hungary"
replace europa=1 if Country=="Italy" | Country=="Latvia" | Country=="Lithuania"
replace europa=1 if Country=="Luxemburg" | Country=="Moldova" | Country=="Netherlands"
replace europa=1 if Country=="Norway" | Country=="Romania" | Country=="Serbia"
replace europa=1 if Country=="Slovenia" | Country=="Spain" | Country=="Sweden"
replace europa=1 if Country=="Switzerland" | Country=="United Kingdom"

gen oceania=0
replace oceania=1 if Country=="Australia"

gen america=0
replace america=1 if Country=="Argentina" | Country=="Colombia" | Country=="Chile" 
replace america=1 if Country=="Belize" | Country=="Cuba" | Country=="Ecuador" 
replace america=1 if Country=="Guatemala" | Country=="Mexico" | Country=="Nicaragua" 
replace america=1 if Country=="Panama" | Country=="Peru" | Country=="Puerto Rico" 
replace america=1 if Country=="United States"

gen asia=0
replace asia=1 if Country=="Armenia" | Country=="Hong Kong" | Country=="Israel" 
replace asia=1 if Country=="Japan" | Country=="Kazakhstan" | Country=="Korea" 
replace asia=1 if Country=="Qatar" | Country=="Thailand"

gen africa=0
replace africa=1 if Country=="Mauritius" | Country=="South Africa"


* -- tabelas resumo por continente -- *
sum fem $desemp popt if asia==1
logout, save(1) excel text: sum fem $desemp popt if asia==1

sum fem $desemp popt if africa==1
logout, save(2) excel text: sum fem $desemp popt if africa==1

sum fem $desemp popt if america==1
logout, save(3) excel text: sum fem $desemp popt if america==1

sum fem $desemp popt if oceania==1
logout, save(4) excel text: sum fem $desemp popt if oceania==1

sum fem $desemp popt if europa==1
logout, save(5) excel text: sum fem $desemp popt if europa==1


* --------------- Global --------------- *
* criando global para agrupar variaveis e simplificar escrita das regressoes
global id Num // individuos - nesse caso 46 paises
global t Year // tempo avaliado - nesse caso 10 anos
global Dt a06 a07 a08 a09 a10 a11 a12 a13 a14 // a15 - dummies de tempo
global y fem // variavel resposta feminicidio por pais e por ano
global desemp desmpfem desmpmas // variaveis para desemprego (tbm tem desmptot)
global x rural expfem expmas // caracteristicas populacao (rural, idade, ...) - exptot
global controles gini ppp // controles - renda, desigualdade
// global educ lsfem lsmas prim // TOTAL: lstot - Educational attainment, at least completed lower secondary, population 25+

// global inf infmas inffem // inftot - informalidade - tem dados de poucos paises

// global alfab alfmas alffem  // alfabetizacao - nem todos os paises tem esse dado - alftot para total

// sum $alfab

// global etario agedep // caracteristicas etarias

// global info internet // pessoas usando internet (%)

// global gender CPIA seats deathm // gender

* global cteT  // variaveis constantes ao longo do tempo


* --------------- ANALISE DESCRITIVA E DA AMOSTRA --------------- *

* --------------- Tabelas e sumarios

//describe 
//summarize


sum somafem

replace fem=. if fem==0
sum fem

sum Year // 10 anos


tab Country // 48 paises

tabstat fem, by(Country) stats(mean) columns(statistics) // medias de feminicidio por pais
*logout, save(TA2) excel text: tabstat fem, by(Country) stats(mean) columns(statistics) // medias de feminicidio por pais

tabstat fem $desemp, by(Year) stats(mean) columns(statistics) // medias de feminicidio e desemprego por ano
*logout, save(TA1) excel text: tabstat fem $desemp, by(Year) stats(mean) columns(statistics) // medias de feminicidio e desemprego por ano

tabstat $y $desemp, stats(mean, sd, count, min, max, q) columns(statistics)
*logout, save(TABELAA1) excel text: tabstat $y $desemp, stats(mean, sd, count, min, max, q) columns(statistics)

correlate $y $desemp
*logout, save(TABELAG24) excel text: correlate $y $desemp

* --------------- Graficos e sumarios

graph matrix $y $desemp, half

gen ldfem = log(desmpfem)
gen ldmas = log(desmpmas)

* -- graficos de distribuicao

graph matrix $y ldfem ldmas, half

graph matrix fem ppp, half

gen lppp = log(ppp)

graph matrix fem ppp lppp, half

graph box desmpfem desmpmas

graph box desmpfem desmpmas, over(Year)

* -- histogramas

histogram fem 

histogram desmpmas

histogram fem, by(Year)


sum desmpfem
histogram desmpfem // no hist observacoes > 30 - outlier? 

gen out=0 // gerando outlier 
replace out=1 if desmpfem>=30
sum out

* -- grafico de linha

tsset Year // This tells Stata that this variable is the time variable
tsline fem desmpfem desmpmas if Country=="United States" // This will graph the three variables over time:

twoway (scatter fem Year, c(l) yaxis(1)) (scatter desmpfem Year, c(l) yaxis(2)) (scatter desmpmas Year, c(l) yaxis(2)) if Country=="United Kingdom"

twoway (scatter fem Year, c(l) yaxis(1)) (scatter desmpfem Year, c(l) yaxis(2)) (scatter desmpmas Year, c(l) yaxis(2)) if Country=="Guatemala"

egen mfem = mean(fem), by(Year)
egen mdesmpfem = mean(desmpfem), by(Year)
egen mdesmpmas = mean(desmpmas), by(Year)

twoway (scatter mfem Year, c(l) yaxis(1)) (scatter mdesmpfem Year, c(l) yaxis(2)) (scatter mdesmpmas Year, c(l) yaxis(2))


* * * --------------- REGRESSAO --------------- * * *

// referencia para alguns comandos e interpretacao de testes:
// Panel Data Analysis Fixed and Random Effects using Stata (v. 4.2), Oscar Torres-Reyna (2017)
// https://www.princeton.edu/~otorres/Panel101.pdf


global ylist fem
global xlist desmpfem desmpmas rural ppp Lsfem1 Lsmale1 agedep seats AlcoolConsPC
global id Num // individuos - nesse caso 46 paises
global t Year // tempo avaliado - nesse caso 10 anos
global Dt a06 a07 a08 a09 a10 a11 a12 a13 a14 // a15 - dummies de tempo


* --------------- individuos e tempo
sort $id $t 
xtset $id $t // definindo individuos e tempo avaliado
tsset $id $t
xtdescribe // descrevendo individuos e tempo avaliado

// Referencia de alguns comandos
// https://www.youtube.com/watch?v=TBV9QFMJqoE&list=PLRW9kMvtNZOitgAuLxznpJVWw981hglR8&index=3
// Ani Katchova (2013)


xtsum $id $t $ylist $xlist $Dt

* --------------- Pooled OLS
reg $ylist $xlist


* --------------- Between
* sem dummies de tempo com variaveis constantes ao longo do tempo

xtreg $ylist $xlist, be


* --------------- Within
* -- REG 1
* acrescimo de dummies de tempo - nao colocar variaveis constantes ao longo do tempo
* para garantir que nao haja multicolinearidade perfeita

xtreg $ylist $xlist $Dt, fe
estimates store fixed // salvando resultado para teste hausman
outreg2 using Reg3, append // exportando resultados da regressao
xttest3 // under the null hypothesis of homoskedasticity (se p-valor baixo rej Ho) <- TESTE DE HOMOCEDASTICIDADE: ha heterocedasticidade = usar robusto!
testparm $Dt // To see if time fixed effects are needed when running a FE model - joint test to see if the dummies for all years are equal to 0
* se Prob > F > 0.05 -> rej Ho, nesse caso isso ocorre, assim FE deve ser usado


// se indica heterocedasticidade = usar opcao de robusto
xtreg $ylist $xlist $Dt, fe cluster ($id)
outreg2 using Reg3, append // exportando resultados da regressao


* recuperando os efeitos especificos a cada individuo
quietly $ylist $xlist $Dt, fe
predict alphafehat, u
sum alphafehat


* -- correlacao serial -- *
xtserial $ylist $xlist

//  Under the null of no serial the residuals from the regression


* --------------- Primeira diferenca
reg D.($ylist $xlist), noconstant

* -- com correlacao serial
xtregar $ylist $xlist $Dt, fe
outreg2 using Reg3, append // exportando resultados da regressao


* -- painel dinamico
xtabond $ylist $xlist $Dt


* -- com instrumento
xtivreg fem $Dt desmpfem rural ppp Lsfem1 agedep seats (desmpmas Lsmale1 = desmpmas Lsmale1), fe 


* --------------- Random
* com dummies de tempo e com variaveis constantes ao longo do tempo
xtreg $ylist $xlist $Dt, re theta
estimates store random // salvando resultado para teste hausman
outreg2 using Reg3, append // exportando resultados da regressao
xttest0 // The LM test helps you decide between a random effects regression and a simple OLS regression
* se prob pequena = rej Ho - conclusao: RE melhor que Pooled OL
* nesse caso,  Prob > chibar2 =   0.0000 assim melhor opcao RE


* * * --------------- TESTES --------------- * * *

* --------------- Hausman
// null hypothesis is that the preferred model is random effects vs. the alternative the fixed effects 

hausman fixed random // se prob>chi2 pequena rej Ho
* sendo Ho que o modelo preferivel e RE, o modelo mais adequado e FE!
* se Prob>chi2 = 0 preferivel FE

* * * --------------- INTERPRETANDO RESULTADOS --------------- * * *

 sum popt if Country=="United States" & Year==2015

 sum popM if Country=="United States" & Year==2015

* ---------- SALVAR TUDO --------------- *

log close 
