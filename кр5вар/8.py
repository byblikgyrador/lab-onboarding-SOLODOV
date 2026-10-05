import math
x = float(input())
y = float(input())
vx = float(input())
vy = float(input())
t = float(input())
g = 9.81
x_new = x + vx * t
y_new = y + vy * t - g * t ** 2 / 2
print(f'x через {t} секунд: {x_new:.2f}\ny через {t} секунд: {y_new:.2f}')
if y >= 0 and vy < 0:
    fall_time = (vy + math.sqrt(vy ** 2 + 2 * g * y)) / g
    print(f'Время падения: {fall_time:.2f} с')