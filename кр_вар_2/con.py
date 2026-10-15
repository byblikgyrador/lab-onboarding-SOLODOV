import math

def nomer_1():
    name = input('Введите ваше имя: ')
    ferst_name = input('Введите вашу фамиию: ')
    city = input('Введите ваш город')
    street = input('Введите вашу улицу: ')
    dom = int(input('Введите ваш дом: '))
    kvar = int(input('Введите вшу квартиру: '))
    text = f'Получатель: {ferst_name.strip()} {name[0].strip()}.\nГород: г. {city.strip()}\nАдрес: ул. {street.strip()}, д. {dom}, кв. {kvar}'
    print(f'{text}')
    
def nomer_2():
    r = float(input('Введите радиус: '))
    v = (4/3)*math.pi*r**3
    s = 4*math.pi*r**2
    print(f'{round(v, 2)}\n{round(s, 2)}')

def nomer_3():
    a = int(input('Введите число: '))

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

def nomer_4():
    email = input('Введите вш email: ')
    print(email.strip().lower())

def nomer_5():
    a = int(input('Введите сумму вклада: '))
    b = 0
    if a > 1000000:
        b = 0.20
    elif a >= 500000:
        b = 0.15
    else:
        b = 0.10
    print(f'{a}\n{a+a*b}')

def nomer_6():
    a = input('Введите слова: ')
    new_a = a.replace('а', '@')
    print(new_a)

def nomer_8():
    a = int(input('Введите 1 число: '))
    b = int(input('Введите 2 число: '))
    c = int(input('Введите 3 число: '))

    if a>b+c or b>a+c or c>a+b:
        print('Треугольник несуществует')
    else:
        p = (a+b+c)/2
        import math
        s = math.sqrt(p*(p-a)*(p-b)*(p-c))
        print(round(p, 2), round(s, 2))


while True:
    print(f'{'-'*170}\nВыполненные задания:\n')
    for i in range(1, 9):
        print(i)
    print('Введите 0 если хотите выйти')
    nomer = input('Введите номер задания: ')
    if nomer == '1':
        nomer_1()
    elif nomer == '2':
        nomer_2()
    elif nomer == '3':
        nomer_3()
    elif nomer == '4':
        nomer_4()
    elif nomer == '5':
        nomer_5()
    elif nomer == '6':
        nomer_6()
    elif nomer == '8':
        nomer_8()
    elif nomer == '0':
        print('Выпоняется выход')
        break
    else:
        if nomer.isalpha():
            print('Введенные вами символы не являются номером задания')
        else:
            print('Введенный вами номер не существует или не выполнен')