#import "./bonch.typ": conf

#show: conf.with(
    title: [
        Циклические вычислительные процессы. Вычисления по \
        рекуррентным формулам.
    ],
    type: "Лабораторная работа №1",
    faculty: "Кибербезопасности",
    department: "Программной инженерии и вычислительной техники",
    subject: "Технологии и методы программирования",
    specialty: "10.03.01 - Информационная безопасность",
    students: (
        "Резниченко И., ИКБ-41",
        "Джинчарадзе Л., ИКБ-41",
    ),
    teachers: (
        "ст. преп. Шуппе А.",
    ),
)


= Введение
#lorem(50)
#let ipa = [taɪpst]

The canonical way to pronounce Typst is #ipa.

#figure(
    table(
        columns: (1fr, 1fr),
        [Name], [Typst],
        [Pronunciation], ipa,
    ),
    caption: [
        _Glaciers_ form an important part of the earth's climate system.
    ],
) <typstpronunciationtable>



== Название подраздела
@galaxy - это круто
#lorem(30)

#figure(
    image("assets/galaxy.jpg", width: 70%),
    caption: [
        _Glaciers_ form an important part of the earth's climate system.
    ],
) <galaxy>

#lorem(50)

=== Название подпункта
#lorem(30)

#lorem(50)
=== Название подпункта
+ Шрифт - Time New Roman (14), Для листинга - Любой другой ( Можно ещё наклонный
    сделать и тд);

+ Отступы абзацев (Красная строка), делается 1,25 см ( В разделе "Абзац");

+ Всё выравнивается по ширине (Кроме Листинга (Он по левому краю), и подписей к
    рисункам);

+ Задач в работе должно быть МИНИМУМ 3 и перед ними должна быть фраза ("В ходе
    прак. работы были поставлены следующие задачи" (ну или что-то в таком духе);

+ Цель начинается всегда "Написать программу", "Реализовать программу" и тп;

+ В ходе действий описываете свой код словами с добавлением команд
    использованных в коде (Все что используется в листинге, должно быть таким же
    везде, те форматирование в листинге и в тексте должны совпадать);

+ Перед рисунком всегда должно быть обращение к нему, а также каждый рисунок
    должен быть подписан (Обычно подписываем, что на нём изображено "Исходный
    Список", "Результат работы программы" и тп);

+ В выводе всегда должна отражаться цель (Если цель НАПИСАТЬ ПРОГРАММУ, то в
    выводе пишется "В ходе практической работы была написана программа, которая
    то-то-то-то". В выводе ещё желательно писать, где эта прога может быть
    актуально (Если нигде, то придумать свою актуальность) и как эта прога может
    быть полезной;

+ Оглавление тоже Time New Roman ("Автособираемое оглавление 1");

+ В задачах каждый пункт заканчивается ; и только в последнем ставим точку.
    Шаблон хорошего оформления будет ниже;

+ Для добавления подписи к картинкам используем такой путь (ПКМ по изображению
    -> Вставить название -> Пишите название рисунка С ТОЧКОЙ -> жмёте Ок - >
    Форматируете под стандарты шрифта и размера).




= Отрывок из K&R
== Basics of Functions
To begin, let us design and write a program to print each line of its input that
contains a particular pattern" or string of characters. (This is a special case
of the UNIX program `grep`.) For example, searching for the pattern of letters
"ould" in the set of lines \
#box[
    ```
    Ah Love! could you and I with Fate conspire
    To grasp this sorry Scheme of Things entire,
    Would not we shatter it to bits -- and then
    Re-mould it nearer to the Heart's Desire!
    ```
]
will produce the output \
#box[
    ```
    Ah Love! could you and I with Fate conspire
    Would not we shatter it to bits -- and then
    Re-mould it nearer to the Heart's Desire!
    ```
]
The job falls neatly into three pieces:\
#box[
    ```
    while (there's another line)
        if (the line contains the pattern)
            print it
    ```
]

Although it's certainly possible to put the code for all of this in main, a
better way is to use the structure to advantage by making each part a separate
function. Three small pieces are better to deal with than one big one, because
irrelevant details can be buried in the functions, and the chance of unwanted
interactions is minimized. And the pieces may even be useful in other programs.


== Functions Returning Non-integers
So far our examples of functions have returned either no value (`void`) or an
`int`. What if a function must return some other type? many numerical functions
like `sqrt`, `sin`, and `cos` return `double`; other specialized functions
return other types. To illustrate how to deal with this, let us write and use
the function `atof(s)`, which converts the string `s` to its double-precision
floating-point equivalent. `atof` if an extension of `atoi`, which we showed
versions of in Chapters 2 and 3. It handles an optional sign and decimal point,
and the presence or absence of either part or fractional part. Our version is
_not_ a high-quality input conversion routine; that would take more space than
we care to use. The standard library includes an `atof`; the header `<stdlib.h>`
declares it.

First, `atof` itself must declare the type of value it returns, since it is not
int. The type name precedes the function name:

```
#include <ctype.h>

/* atof: convert string s to double */
double atof(char s[]) {
    double val, power;
    int i, sign;

    for (i = 0; isspace(s[i]); i++) /* skip white space */
        ;
    sign = (s[i] == '-') ? -1 : 1;
    if (s[i] == '+' || s[i] == '-')
        i++;
    for (val = 0.0; isdigit(s[i]); i++)
        val = 10.0 * val + (s[i] - '0');
    if (s[i] == '.')
        i++;
    for (power = 1.0; isdigit(s[i]); i++) {
        val = 10.0 * val + (s[i] - '0');
        power *= 10;
    }
    return sign * val / power;
}
```
Second, and just as important, the calling routine must know that `atof` returns
a non-int value. One way to ensure this is to declare `atof` explicitly in the
calling routine. The declaration is shown in this primitive calculator (barely
adequate for check-book balancing), which reads 66 one number per line,
optionally preceded with a sign, and adds them up, printing the running sum
after each input:





= ПРИМЕРЫ ОФОРМЛЕНИЯ ЭЛЕМЕНТОВ ВКР
== Пример оформления иллюстраций
На @exampleimage1[рисунке] проиллюстрирован конкретный пример.

#figure(
    image("assets/image1.png", width: 30%),
    caption: [Наименование],
) <exampleimage1>

Важно правильно оформлять документы (@exampleimage2).

#figure(
    image("assets/image2.png", width: 30%),
    caption: [Наименование],
) <exampleimage2>

== Пример оформления таблиц
В @exampletable1[таблице] показан пример построения таблицы.

#figure(
    table(
        columns: (1fr, 1fr, 1fr, 1fr),
        rows: (auto, auto, 1.2em, 1.2em),
        table.cell(rowspan: 2)[*Заголовок*],
        table.cell(colspan: 2)[*Заголовок колонки*],
        table.cell(rowspan: 2)[*Заголовок \ колонки*],
        [Подзаголовок], [Подзаголовок],
    ),
    caption: [Пример построения таблицы],
) <exampletable1>

В @exampletable2[таблице] показан пример построения таблицы, имеющий
продолжение.

#figure(
    table(
        columns: (1fr, 1fr, 1fr, 1fr),
        rows: (auto, auto, 1.2em, 1.2em, 1.2em, 1.2em, 1.2em, 1.2em),
        table.cell(rowspan: 2)[*Заголовок*],
        table.cell(colspan: 2)[*Заголовок колонки*],
        table.cell(rowspan: 2)[*Заголовок \ колонки*],
        [Подзаголовок], [Подзаголовок],
    ),
    caption: [Пример построения таблицы],
) <exampletable2>


== Пример оформления формул и уравнений
В качестве примера оформления рассмотрим формулу Теоремы Пифагора, которая
выглядит так:
#set math.equation(numbering: "(1)")


$ a^2 + b^2 = c^2 $ <pifagor>

где $a, b$ - катеты, $с$ - гипотенуза. Из @pifagor[формулы] можно вывести, что
формулу расчета гипотенузы в квадрате:

$ c^2 = a^2 + b^2 $

Формула плотности вещества:

$ р = m \/ V $

где $р$ - плотность вещества, $"кг"\/м^3$; $m$ - масса вещества, кг; $V$ - объем
вещества, $м^3$.

Плотность зависит от температуры, агрегатного состояния вещества и внешнего
давления.

== Пример оформления перечислений
Пример 1

Рекомендуемый объём машинописного текста ВКР без приложений:

- бакалавра -- 50-60 страниц машинописного текста,
- специалиста -- 70-90 страниц машинописного текста,
- магистра -- 80-100 страниц машинописного текста.

Пример 2

Требования государственных стандартов применительно к ВКР могут учитывать:

#import "./bonch.typ": cyrillic-numbering
#[
    #set enum(numbering: cyrillic-numbering())
    + формат бумаги,
    + оформление титульного листа,
    + кегль шрифта, интервал между строками, размеры полей,
    + общую структуру работы,
    + особенности написания заголовков.
]

Пример 3

Оценка качества защиты ВКР

1. Качество доклада,
2. Содержание доклада,
3. Качество ответов на вопросы,
4. Поведение на защите ВКР.

Пример 4

Оценка ВКР складывается из двух оценок:
+ оценки качества выполненной работы;
+ оценки качества защиты работы:
- Качество доклада,
- Содержание доклада,
- Качество ответов на вопросы,
- Поведение на защите ВКР.

== Пример оформления списка сокращений
ВКР -- выпускная квалификационная работа

ГИА -- государственная итоговая аттестация

ГЭК -- государственная экзаменационная комиссия

ПЗС -- прибор с зарядовой связью

== Пример оформления списка терминов и определений
Пример 1

Балет -- искусство сценического танца

Сталь -- твердый серебристый металл, сплав железа с углеродом и другими
упрочняющими элементами


