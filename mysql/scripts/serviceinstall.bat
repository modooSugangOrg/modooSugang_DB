@echo off
rem -- Check if argument is INSTALL or REMOVE

if not ""%1"" == ""INSTALL"" goto remove

"C:\Bitnami\wampstack-7.4.20-0/mysql\bin\mysqld.exe" --install "wampstackMySQL" --defaults-file="C:\Bitnami\wampstack-7.4.20-0/mysql\my.ini"

net start "wampstackMySQL" >NUL
goto end

:remove
rem -- STOP SERVICES BEFORE REMOVING

net stop "wampstackMySQL" >NUL
"C:\Bitnami\wampstack-7.4.20-0/mysql\bin\mysqld.exe" --remove "wampstackMySQL"

:end
exit
