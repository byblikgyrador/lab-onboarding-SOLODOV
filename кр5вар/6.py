obsh_distance = 0
obsh_time = 0
min_speed = 100000
slow = 0
for i in range(1, 4):
    distance = float(input())
    speed = float(input())
    time = distance / speed
    hours = time
    minutes = (time - hours) * 60
    print(f'Участок {i}: {hours} ч {minutes} мин')
    obsh_distance += distance
    obsh_time += time
    if speed < min_speed:
        min_speed = speed
        slow = i
average_speed = obsh_distance / obsh_time
print(f'Общее расстояние: {obsh_distance:.2f} км\nОбщее время: {obsh_time:.2f} ч\nСредняя скорость: {average_speed:.2f} км/ч')