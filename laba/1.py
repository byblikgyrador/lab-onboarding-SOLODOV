def nomer_1():
    for i in range(1, 21):
        print(i, end=' ') 

def nomer_2():
    a=int(input())
    for i in range(1, 11):
        print(f'{a} * {i} = {a*i}')

def nomer_3():
    n=int(input())
    total=0
    for i in range(1,n+1):
        total+=i
    print(total)

def nomer_4():
    srtik = input()
    b=0
    for i in srtik:
        if i == 'а' or i == 'А':
            b += 1
    print(b)

def nomer_5():
    it=int(input())
    zv='*'
    for i in range(1, it+1):
        print(f'{zv*i}')

def nomer_6():
    n=int(input())
    b=1
    for i in range(2, n+1):
        b*=i
    print('n', '! = ', b)

def nomer_7():
    a = input()
    for i in range(len(a) - 1, -1, -1):
        print(a[i], end='')

def nomer_8():
    n=int(input())
    if n >= 2:
        for i in range(2, n+1, 2):
            if n%2==0:
                print(i, end=' ')

def nomer_9():
    count = int(input())
    i = 0
    total = 0
    while i < count:
        n = int(input())
        total += n
        i += 1
    print("Количество оценок:", count)
    print("Среднее значение:", total / count)




nomer_9()