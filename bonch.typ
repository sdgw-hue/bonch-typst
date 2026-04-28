#import "@preview/itemize:0.2.0" as el

#let stringify-by-func(it) = {
    let func = it.func()
    return if func in (parbreak, pagebreak, linebreak) {
        "\n"
    } else if func == smartquote {
        if it.double { "\"" } else { "'" } // "
    } else if it.fields() == (:) {
        // a fieldless element is either specially represented (and caught earlier) or doesn't have text
        ""
    } else {
        panic("Not sure how to handle type `" + repr(func) + "`")
    }
}

#let plain-text(it) = {
    return if type(it) == str {
        it
    } else if it == [ ] {
        " "
    } else if it.has("children") {
        it.children.map(plain-text).join()
    } else if it.has("body") {
        plain-text(it.body)
    } else if it.has("text") {
        if type(it.text) == str {
            it.text
        } else {
            plain-text(it.text)
        }
    } else {
        // remove this to ignore all other non-text elements
        stringify-by-func(it)
    }
}

#let cyrillic-numbering(pattern: "а)") = {
    let alphabet = "абвгдежзиклмнопрстуфхцчшщэюя".split("")
    let f(i) = {
        let letter = alphabet.at(i)
        let str = ""
        for char in pattern {
            if char == "а" {
                str += letter
            } else if char == "А" {
                str += upper(letter)
            } else {
                str += char
            }
        }
        str
    }
    f
}

#let conf(
    title: [],
    faculty: "",
    department: "",
    subject: "",
    speciality: "",
    type: "",
    students: (),
    teachers: (),
    doc,
) = {
    set document(title: title)
    set page(
        paper: "a4",
        margin: (top: 2cm, right: 1.5cm, bottom: 2cm, left: 3cm),
        numbering: none,
    )

    set text(
        lang: "ru",
        font: (
            "FreeSerif",
            "Times New Roman",
        ),
        size: 14pt,
    )

    let LEADING = 0.75em

    show raw: set text(font: (
        "FreeMono",
        "Courier New",
    ))
    show raw.where(block: false): set text(size: 12pt)
    show raw.where(block: true): set text(size: 12pt)
    show raw: set block(
        width: 100%,
        inset: (y: LEADING),
    )

    set par(
        leading: LEADING,
        spacing: LEADING,
        justify: true,
        first-line-indent: (amount: 1.25cm, all: true),
    )

    set underline(
        stroke: 0.5pt,
        evade: false,
    )

    set line(
        stroke: 0.5pt,
    )

    show heading: set text(size: 14pt)
    set heading(numbering: "1.1")
    show heading.where(level: 3): set text(weight: "regular")
    show heading.where(level: 1): set align(center)
    show heading.where(level: 1): it => [#pagebreak()#it]
    show heading.where(level: 1): it => upper(it)
    show outline.entry.where(level: 1): it => upper(it)
    set outline(title: "СОДЕРЖАНИЕ", target: heading)

    set figure.caption(separator: [ -- ])
    show figure.where(kind: image): set figure(supplement: "Рисунок")
    show figure.where(kind: table): set figure.caption(position: top)
    show figure.caption.where(kind: table): set align(start)

    show figure: set block(breakable: true)

    show math.equation: set block(inset: LEADING)

    show: el.paragraph-enum-list.with(label-indent: 1.25cm, label-align: left)
    set list(marker: [--])

    set bibliography(
        title: "СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ",
        style: "gost-r-705-2008-numeric",
        full: true,
    )


    align(center, text(size: 12pt)[
        *МИНИСТЕРСТВО ЦИФРОВОГО РАЗВИТИЯ, \
        СВЯЗИ И МАССОВЫХ КОММУНИКАЦИЙ РОССИЙСКОЙ ФЕДЕРАЦИИ*

        *ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ БЮДЖЕТНОЕ ОБРАЗОВАТЕЛЬНОЕ \
        УЧРЕЖДЕНИЕ ВЫСШЕГО ОБРАЗОВАНИЯ \
        «САНКТ-ПЕТЕРБУРГСКИЙ ГОСУДАРСТВЕННЫЙ УНИВЕРСИТЕТ \
        ТЕЛЕКОММУНИКАЦИЙ ИМ. ПРОФ. М.А. БОНЧ-БРУЕВИЧА» \
        (СПбГУТ)*
    ])

    line(length: 100%)

    align(center)[
        Факультет: #faculty \
        Кафедра: #department \
        Дисциплина: #subject
    ]

    v(2em)

    align(center, text(size: 16pt, weight: "bold")[#upper(type)])

    v(3em)

    align(center)[
        #set par(spacing: 0.11em)
        #let lines = plain-text(title).split("\n")
        #for (i, l) in lines.enumerate(start: 1) {
            text(l)
            line(length: 100%)
            if i < lines.len() { v(0.3em) }
        }
        #v(0.1em)
        #text(size: 11pt)[_(тема отчета)_]
    ]

    v(1em)

    block[Направление/специальность подготовки]
    align(center)[
        #set par(spacing: 0.11em)
        #speciality \
        #line(length: 100%)
        #v(0.1em)
        #text(size: 11pt)[_(код и наименование направления/специальности)_]
    ]

    v(2em)

    let student(name) = {
        grid(
            columns: (1fr, 0.3fr),
            column-gutter: 1em,
            row-gutter: 0.11em,
            block(name), block[\ ],
            line(length: 100%), line(length: 100%),
            align(center, text(size: 11pt)[#v(0.1em)_(Ф.И.О., № группы)_]),
            align(center, text(size: 11pt)[#v(0.1em)_(подпись)_]),
        )
    }

    let teacher(name) = {
        grid(
            columns: (1fr, 0.3fr),
            column-gutter: 1em,
            row-gutter: 0.11em,
            block(name), block(),
            line(length: 100%), line(length: 100%),
            align(center, text(size: 11pt)[#v(0.1em)_(Должность, Ф.И.О.
                преподавателя)_]),
            align(center, text(size: 11pt)[#v(0.1em)_(подпись)_]),
        )
    }

    grid(
        columns: (1fr, 1.1fr),
        [],
        [
            #set par(spacing: 0.8em, first-line-indent: (
                amount: 0pt,
                all: false,
            ))
            Студент:

            #for s in students {
                student(s)
            }

            #v(1.2em)

            Преподаватель:
            #for t in teachers {
                teacher(t)
            }
        ],
    )

    place(center + bottom)[
        Санкт-Петербург\
        #datetime.today().display("[year]")
    ]

    set page(numbering: "1")

    doc
}

