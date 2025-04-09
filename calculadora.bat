@echo off
setlocal enabledelayedexpansion

:menu
echo Selecione a operacao:
echo 1. Adicao
echo 2. Subtracao
echo 3. Multiplicacao
echo 4. Divisao
echo 5. Potencia
echo 6. Raiz Quadrada
echo 7. Porcentagem
echo 8. Simplificacao de Expressoes
echo 9. Resolucao de Equacoes Lineares
echo 10. Conhecer Conjuntos Numericos
echo 11. Fatorial
echo 12. Logaritmo
set /p op=Escolha (1/2/3/4/5/6/7/8/9/10/11/12): 

if "%op%"=="1" goto add
if "%op%"=="2" goto subtract
if "%op%"=="3" goto multiply
if "%op%"=="4" goto divide
if "%op%"=="5" goto power
if "%op%"=="6" goto sqrt
if "%op%"=="7" goto percentage
if "%op%"=="8" goto simplify
if "%op%"=="9" goto solve
if "%op%"=="10" goto sets
if "%op%"=="11" goto factorial
if "%op%"=="12" goto logarithm
echo Opcao invalida
goto menu

:add
set /p num1=Digite o primeiro numero (ou fracao, ex: 1/2): 
set /p num2=Digite o segundo numero (ou fracao, ex: 1/3): 
call :fraction_add %num1% %num2%
goto end

:subtract
set /p num1=Digite o primeiro numero (ou fracao, ex: 1/2): 
set /p num2=Digite o segundo numero (ou fracao, ex: 1/3): 
call :fraction_subtract %num1% %num2%
goto end

:multiply
set /p num1=Digite o primeiro numero (ou fracao, ex: 1/2): 
set /p num2=Digite o segundo numero (ou fracao, ex: 1/3): 
call :fraction_multiply %num1% %num2%
goto end

:divide
set /p num1=Digite o primeiro numero (ou fracao, ex: 1/2): 
set /p num2=Digite o segundo numero (ou fracao, ex: 1/3): 
call :fraction_divide %num1% %num2%
goto end

:power
set /p num1=Digite a base: 
set /p num2=Digite o expoente: 
set result=1
call :power_calc %num1% %num2% result
echo Resultado: !result!
goto end

:sqrt
set /p num1=Digite o numero: 
set /a result=0
for /L %%i in (1,1,%num1%) do (
    set /a square=%%i*%%i
    if !square! gtr %num1% goto show
    set /a result=%%i
)
:show
echo Resultado: %result%
goto end

:percentage
set /p num1=Digite o numero: 
set /p num2=Digite a porcentagem: 
set /a result=(%num1% * %num2%) / 100
echo Resultado: %result%
goto end

:simplify
echo Simplificacao de expressoes ainda nao implementada.
goto end

:solve
set /p equation=Digite a equacao (ex: 2x+3=7): 
set "lhs=%equation: =%"
set "rhs="
for /f "tokens=1,2 delims==" %%a in ("%lhs%") do (
    set "lhs=%%a"
    set "rhs=%%b"
)
if not defined rhs (
    echo Equacao invalida.
    goto end
)
set "result=equacao ainda nao resolvida"
echo Resultado: %result%
goto end

:sets
echo Os principais conjuntos numericos sao:
echo 1. Naturais (N): 0, 1, 2, 3...
echo 2. Inteiros (Z): ...-3, -2, -1, 0, 1, 2, 3...
echo 3. Racionais (Q): 1/2, 2/3, 4, -5...
echo 4. Irracionais (I): pi, sqrt(2)...
echo 5. Reais (R): Toda a linha numerica continua...
goto end

:factorial
set /p num=Digite o numero: 
set result=1
call :factorial_calc %num% result
echo Resultado: !result!
goto end

:logarithm
set /p base=Digite a base: 
set /p num=Digite o numero: 
call :logarithm_calc %base% %num% result
echo Resultado: !result!
goto end

:fraction_add
set "num1=%1"
set "num2=%2"
call :parse_fraction %num1% a1 b1
call :parse_fraction %num2% a2 b2
set /a result_num = a1*b2 + a2*b1
set /a result_den = b1*b2
echo Resultado: %result_num%/%result_den%
goto end

:fraction_subtract
set "num1=%1"
set "num2=%2"
call :parse_fraction %num1% a1 b1
call :parse_fraction %num2% a2 b2
set /a result_num = a1*b2 - a2*b1
set /a result_den = b1*b2
echo Resultado: %result_num%/%result_den%
goto end

:fraction_multiply
set "num1=%1"
set "num2=%2"
call :parse_fraction %num1% a1 b1
call :parse_fraction %num2% a2 b2
set /a result_num = a1*a2
set /a result_den = b1*b2
echo Resultado: %result_num%/%result_den%
goto end

:fraction_divide
set "num1=%1"
set "num2=%2"
call :parse_fraction %num1% a1 b1
call :parse_fraction %num2% a2 b2
set /a result_num = a1*b2
set /a result_den = a2*b1
echo Resultado: %result_num%/%result_den%
goto end

:parse_fraction
set "frac=%1"
for /f "tokens=1,2 delims=/" %%a in ("%frac%") do (
    set "%2=%%a"
    set "%3=%%b"
)
exit /b

:power_calc
set "base=%1"
set "exp=%2"
set "res=1"
for /L %%i in (1,1,%exp%) do (
    set /a res*=base
)
set "%3=!res!"
exit /b

:factorial_calc
set "num=%1"
set "res=1"
for /L %%i in (1,1,%num%) do (
    set /a res*=%%i
)
set "%2=!res!"
exit /b

:logarithm_calc
set "base=%1"
set "num=%2"
set "count=0"
set "temp=%num%"
:log_loop
if %temp% LSS %base% goto log_done
set /a temp/=base
set /a count+=1
goto log_loop
:log_done
set "%3=%count%"
exit /b

:end
set /p choice=Quer fazer outro calculo? (s/n): 
if /i "%choice%"=="s" goto menu
echo Ate mais!
pause
