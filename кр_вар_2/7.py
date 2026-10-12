password = input()

if len(password) < 8:
    print('Пароль должен содержать более 8 символов')
elif any(char.isdigit() for char in password):
    print('Пароль не должен содержать цифр')
elif not any(char.islower() for char in password):
    print('Пароль должен содержать хотя бы одну строчную букву')
elif not any(char.isupper() for char in password):
    print('Пароль должен содержать хотя бы одну заглавную букву')
elif ' ' in password:
    print('Пароль не должен содержать пробелов')
elif password.lower() == 'password':
    print('Пароль не может быть словом "password"')
else:
    print('Пароль надёжный')
