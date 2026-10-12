a = int(input())

if a > 0:
    print('Число положительно')
elif a < 0:
    print('Число отрицательно')
else:
    print('Число равно 0 ')

if a//5:
    print('Число кратно 5')
else:
    print('Число не кратно 5')

if 10 <= a <= 99 or  -10 <= a <= -99:
    print('Число двузначное')
else: 
    print('Число не двузначное')