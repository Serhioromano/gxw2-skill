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

## Структура навыка

Навык следует стандарту [Agent Skills](https://agentskills.io/specification) и упакован как **Pi package** (npm/git), устанавливается командой `pi install`.

```
gxw2-skill/                          # корень репо = корень Pi-пакета
├── package.json                     # pi.skills: ["./skills"], keyword pi-package
├── README.md                        # Human-facing description + установка через pi install
├── LICENSE                          # MIT
├── .pi/                             # dev-инструкции (этот файл) — НЕ входят в навык
├── plans/                           # планы разработки
└── skills/
    └── gxw2-st/                     # директория навыка (имя = frontmatter name)
        ├── SKILL.md                 # Main skill file (frontmatter + instructions)
        ├── references/              # Detailed references
        │   ├── devices.md           # Device map (X, Y, M, D, T, C, ...)
        │   ├── DB/                  # Per-instruction files
        │   │   └── 00_Instruction_List.md  # Index of all instruction files
        │   ├── data-types.md        # Data types and casting
        │   ├── functions.md         # Built-in functions and FB
        │   └── compatibility.md     # Compatibility table by PLC series
        └── examples/                # Code examples
            ├── basics/              # Simple examples
            └── advanced/            # Complex examples (PID, comms, etc.)
```

> Все внутренние ссылки навыка относительны от `skills/gxw2-st/` — перенос/установка директории не ломает их. Версии в `package.json` и frontmatter `SKILL.md` держать синхронными.

