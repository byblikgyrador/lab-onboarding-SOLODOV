import math
m = float(input())
h = float(input())
g = 9.81
t = round(math.sqrt(2*h*g), 3)
v = round(g*t, 3)
Ek = round((m*(v**2))/2, 3)
Ep = round(m*g*h, 3)
print(f'--Время падения: {t}\n--Скорось в момент удара {v}\n--Кинетическая энергия при ударе: {Ek}\n--Потенциаьная энергия на высоте {Ep}')