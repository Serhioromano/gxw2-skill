# GXW2-ST Skill Development

Ты помогаешь создавать навык (skill) для Pi Coding Agent, который обучает агента писать код на Structured Text (ST) для среды **GX Works 2** (Mitsubishi Electric).

## Цель проекта

Создать навык `gxw2-st`, который делает агента экспертом по следующим темам:

1. **Синтаксис ST для GX Works 2** — полный справочник с отличиями от стандартного IEC 61131-3
2. **Функциональные блоки (FB)** — шаблоны и лучшие практики
3. **Функции (FUN)** — встроенные и пользовательские
4. **Типы данных** — BIT, WORD, DWORD, INT, DINT, REAL, STRING, массивы, структуры
5. **Работа с устройствами** — X, Y, M, D, T, C и другие устройства ПЛК
6. **Таймеры и счётчики** — специфика GX Works 2
7. **Отладка и типовые ошибки** — распространённые проблемы и их решения

## Структура репозитория

Репозиторий — **Pi package** (npm/git), устанавливается командой `pi install`. Корень репо = корень Pi-пакета.

```
gxw2-skill/
├── package.json                # pi.skills: ["./skills"], keyword pi-package; версия синхронна с SKILL.md
├── README.md                   # Human-facing описание + установка через pi install
├── CHANGELOG.md                # История версий; секцию [Unreleased] заменяет make publish
├── LICENSE                     # MIT
├── Makefile                    # make publish v=<patch|minor|major|x.y.z>; make test (smoke)
├── .gitignore
├── .pi/                        # dev-инструкции — НЕ входят в навык
│   ├── SYSTEM.md               # этот файл
│   ├── APPEND_SYSTEM.md        # глобальные правила разработки (дополняются к системному промпту)
│   ├── .vscode-ready           # маркер VSCode (в .gitignore)
│   ├── review-requests/        # запросы на ревью
│   └── review-results/         # результаты ревью
├── plans/                      # планы разработки
│   └── 01-pi-package-install.md
└── skills/
    └── gxw2-st/                # директория навыка (имя = frontmatter name)
        ├── SKILL.md            # frontmatter (name, version, compatibility) + двухфазный workflow (Plan → Generate)
        ├── references/         # Detailed references
        │   ├── common-rules.md     # ОБЯЗАТЕЛЬНЫЙ (Phase 2, читать первым): запрещённые конструкции, нейминг, литералы, state machine
        │   ├── csv-variables.md    # ОБЯЗАТЕЛЬНЫЙ (Phase 2, читать вторым): форматы CSV (IO, GVL, POU-local, structure, FB/FUN)
        │   ├── data-types.md       # Типы данных и приведение
        │   ├── devices.md          # Карта устройств (X, Y, M, D, T, C, ...)
        │   ├── system-devices.md   # Специальные реле/регистры (M8000+, D8000+)
        │   ├── functions.md        # Встроенные FUN/FB
        │   ├── compatibility.md    # Совместимость по сериям FX (Phase 1, при указании модели)
        │   └── DB/                 # Каталог инструкций (~219 файлов)
        │       ├── 00_Instruction_List.md          # индекс всех инструкций (180+), колонка File = имя файла
        │       ├── 30_Type_Conversion.md … 38_Function_Blocks.md  # секции по группам инструкций
        │       └── {INSTR}.md      # один файл на инструкцию (MOV.md, ADD.md, ...)
        └── examples/               # Парные примеры: .st (код) + .csv (переменные Label Editor)
            ├── 01-io-assignment.st/.csv
            ├── 02-conditionals.st/.csv
            ├── 03-case-state-machine.st/.csv
            ├── 04-loops.st/.csv
            ├── 05-timers.st/.csv
            ├── 06-counters.st/.csv
            ├── 07-math.st/.csv
            ├── 08-strings.st/.csv
            ├── 09-bit-operations.st/.csv
            ├── 10-type-casting.st/.csv
            ├── 11-edge-detection.st/.csv
            ├── 12-function-block/MotorControl.st/.csv   # пример FB (в подпапке)
            ├── 13-function/ScaleValue.st/.csv           # пример FUN (в подпапке)
            ├── 14-pid-control.st/.csv
            ├── io.csv               # шаблон I/O привязок (проектный)
            ├── gvl.csv              # шаблон глобальных переменных (проектный)
            ├── pou-local.csv        # шаблон локальных переменных POU
            └── structure.csv        # шаблон определения структуры
```

## Ключевые правила разработки

- **Двухфазный workflow** описан в `SKILL.md`: Phase 1 — план с каталогом инструкций (`DB/00_Instruction_List.md`), Phase 2 — генерация кода с обязательными `common-rules.md` и `csv-variables.md`. Не дублируй его в SYSTEM.md.
- Каждый пример — **пара файлов**: `.st` (только код, без `VAR...END_VAR`) + `.csv` (переменные для GX Works 2 Label Editor: UTF-16 LE с BOM, таб-разделитель, все значения в кавычках).
- `references/DB/` — один файл на инструкцию. Некоторые инструкции делят файл (SET/RST, PLS/PLF, MEP/MEF) — точное имя файла указано в колонке File индекса.
- Версии в `package.json` и frontmatter `SKILL.md` держать синхронными.
- Релиз: `make publish v=<patch|minor|major|x.y.z>` — обновляет CHANGELOG, бампает версию, публикует в npm, создаёт GitHub release. Проверка навыка: `make test`.

> Все внутренние ссылки навыка относительны от `skills/gxw2-st/` — перенос/установка директории не ломает их.
