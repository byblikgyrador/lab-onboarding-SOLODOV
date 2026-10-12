a = int(input())
b = int(input())
c = int(input())

if a>b+c or b>a+c or c>a+b:
    print('Треугольник несуществует')
else:
    p = (a+b+c)/2
    import math
    s = math.sqrt(p*(p-a)*(p-b)*(p-c))
    print(round(p, 2), round(s, 2))