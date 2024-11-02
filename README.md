## HW 2

### 1. What issues prevent us from using storyboards in real projects?

Использование сторибордов может привести к конфиликтам при слиянии кода, что затрудняет командную работу. Также использование сторибордов приводит к множеству багов во время разработки.

### 2. : What does the code on lines 25 and 29 do?

```swift
23. private func configureTitle() {
24.     let title = UILabel() 
25.     title.translatesAutoresizingMaskIntoConstraints = false
26.     title.text = "WishMaker"
27.     title.font = UIFont.systemFont(ofSize: 32)
28.
29.     view.addSubview(title)
30.     NSLayoutConstraint.activate([
31.     title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
32.     title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
33.     title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
34.     ])
35. }
```

**25** : Отключаем автоматическое создание констрейнтов, чтобы в дальнейшем задать их самим.

**29** : Добавляем элемент title в качестве дочернего вида к view (делая его видимым на экране).


### 3. What is a safe area layout guide

Часть экрана, в котором содержимое не будет обрезано закругленными углама, челкой и тп.

### 4. What is [weak self] on line 23 and why it is important?

```swift
23. sliderRed.valueChanged = { [weak self] value in
24.     self?.view.backgroundColor = ...
25. }
```

Захват **self** в замыкании с использованием слабой ссылки, чтобы избежать циклических ссылок и утечек памяти.

### 5. What does clipsToBounds mean?

Содержимое слоя будет обрезано по границам его фрейма(то есть все, что выходит за пределы не будет видно).

### 6. What is the valueChanged type? What is Void and what is Double?

Это замыкание, которое принимает параметр типа Double и возвращает Void.

