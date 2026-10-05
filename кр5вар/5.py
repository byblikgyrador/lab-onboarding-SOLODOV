name = input()
status = input().lower()
summa = float(input())
if status == 'обычный': 
    if summa >= 5000:
        skidka = 5
    else:
        skidka = 0
elif status == 'серебряный':
    if summa >= 5000:
        skidka = 15
    else:
        skidka = 10
elif status == 'золотой':
    if summa >= 5000:
        skidka = 25
    else:
        skidka = 20
else:
    print('Неверный статус')
    skidka = 0
if summa >= 10000:
    skidka += 5
itog = summa - summa * skidka / 100
print(f'Имя: {name.title()}\nСтатус: {status.title()}\nСумма: {summa:.2f}\nСкидка: {skidka}%\nИтого: {itog:.2f}')