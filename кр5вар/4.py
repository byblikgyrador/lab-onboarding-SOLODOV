text = input()
pairs = text.split(';')
print('Данные:')
keys = []
numbers = []
for pair in pairs:
    parts = pair.split(':')
    if len(parts) == 2:
        key = parts[0].strip()
        value = parts[1].strip()
        keys.append(key.lower())
        print(f'{key}:{value}')
        if value.isdigit():
            numbers.append(value)
print(f'Количество пар: {len(pairs)}\nКлючи в нижнем регистре: {keys}\nЗначения только из цифр: {numbers}')