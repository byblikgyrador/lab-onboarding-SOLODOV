n = int(input())
for i in range(n):
    a = [].append(int(input()))

b = a.copy()
print(a)
b[0], b[-1] = a[-1], a[0]
print(b)
b.append(a[0]).remove(0)
print(b)
