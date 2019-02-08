@set hh=%TIME:~0,2%

@if %hh%==0 set hh=00
@if %hh%==1 set hh=01
@if %hh%==2 set hh=02
@if %hh%==3 set hh=03
@if %hh%==4 set hh=04
@if %hh%==5 set hh=05
@if %hh%==6 set hh=06
@if %hh%==7 set hh=07
@if %hh%==8 set hh=08
@if %hh%==9 set hh=09

@echo Hello World from Windows Batch ! Today is %DATE% and it's %hh%:%TIME:~3,2%:%TIME:~6,2%.