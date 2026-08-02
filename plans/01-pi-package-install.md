# План: упаковка навыка gxw2-skill как устанавливаемого пакета Pi

> Статус: черновик для реализации
> Цель: превратить репозиторий `Serhioromano/gxw2-skill` в **pi-пакет**, который устанавливается одной командой `pi install` и авто-обнаруживается агентом как навык `gxw2-st`.

---

## 1. Аудит текущего состояния

| Факт | Значение |
|------|----------|
| Репозиторий | `https://github.com/Serhioromano/gxw2-skill` (git remote: origin) |
| Рабочая копия | `/home/sergey/www/gxw2-skill`, HEAD `059b6ef` |
| Текущий способ установки | ручное копирование в `~/.agents/skills/gxw2-st` (описано в README) |
| Установленная копия | `/home/sergey/.agents/skills/gxw2-st` — **устарела** (commit `b57d11d`, нет новых DB-файлов) |
| package.json | есть, но **нет** `pi`-манифеста и ключевого слова `pi-package`; version `1.0.2` (разъехалась с SKILL.md `1.3.0`) |
| SKILL.md | frontmatter: `name: gxw2-st`, `version: 1.3.0` |
| Файлов в навыке | ~226 reference-файлов (`references/DB/`), 32 example-файла, итого ~3.9 MB |
| LICENSE | файла нет (в package.json заявлен MIT) |
| npm | имена `gxw2-skill` и `pi-gxw2-skill` **свободны** (проверено 404) |
| Незакоммиченные правки | 4 файла: `SKILL.md`, `00_Instruction_List.md`, `ABSD.md` (M), `instruction-db.md` (D) |

**Вывод:** репозиторий по сути уже является Agent Skills-навыком, не хватает только pi-обёртки (манифест + структура `skills/`), LICENSE, синхронизации версий и обновления README.

---

## 2. Как устроены pi-пакеты (факты из документации Pi)

- Пакет = npm-пакет (или git-репо) с ключом `pi` в `package.json`:
  ```json
  {
    "name": "my-package",
    "keywords": ["pi-package"],
    "pi": { "skills": ["./skills"] }
  }
  ```
- Пути в `pi` относительны корня пакета; поддерживаются glob и исключения `!`.
- Без манифеста работает **convention-каталог** `skills/` — pi рекурсивно находит папки с `SKILL.md`.
- Установка: `pi install npm:... | git:github.com/user/repo | https://github.com/user/repo | ./local/path`.
  - git-источники клонируются в `~/.pi/agent/git/<host>/<path>`;
  - локальные пути добавляются в settings **без копирования**;
  - npm-пакеты — в `~/.pi/agent/npm/node_modules/`.
- Обнаружение навыков: `~/.pi/agent/skills/`, `~/.agents/skills/`, `.pi/skills/`, `.agents/skills/`, **пакеты**, `settings.skills`, CLI.
- Навык регистрируется как `/skill:gxw2-st`.
- При конфликте имён (два `gxw2-st`) pi **предупреждает и берёт первую найденную** → старую ручную копию нужно удалить.
- Эталонный пример: `@micka33/pi-karpathy-skill` — `skills/karpathy-guidelines/SKILL.md`, публикация через GitHub Actions по тегу `vX.Y.Z`.

---

## 3. Целевая структура (рекомендуемая, по образцу karpathy)

```
gxw2-skill/                      # корень репо = корень пакета
├── package.json                 # + pi.skills: ["./skills"], keywords, files[], version 1.3.0
├── README.md                    # + раздел установки через pi install
├── LICENSE                      # добавить (MIT)
├── assets/                      # (опц.) social-preview.png для галереи pi.dev/packages
├── .pi/SYSTEM.md, APPEND_SYSTEM.md   # dev-инструкции — остаются в репо, НЕ входят в навык
├── plans/                       # планы разработки
└── skills/
    └── gxw2-st/                 # директория навыка (имя = frontmatter name)
        ├── SKILL.md             # ← переносится из корня (git mv, история сохранится)
        ├── references/          # ← переносится целиком
        └── examples/            # ← переносится целиком
```

**Альтернатива (минимальная):** оставить SKILL.md в корне и указать `pi.skills: ["."]`. Работает, но смешивает корень пакета с директорией навыка и нестандартно для галереи — **не рекомендую**, берём основную.

---

## 4. Изменения package.json

```json
{
  "name": "gxw2-skill",               // или pi-gxw2-skill, если решим публиковать под pi-префиксом
  "version": "1.3.0",                 // синхронизировать с SKILL.md
  "description": "Pi skill: Structured Text (ST) code and CSV variable files for Mitsubishi FX series PLCs in GX Works 2",
  "keywords": ["pi-package", "pi-skill", "agent-skills", "PLC", "GX Works 2", "Mitsubishi", "FX3U", "FX3G", "FX3S", "FX5U"],
  "license": "MIT",
  "files": ["README.md", "LICENSE", "assets", "skills"],   // что уходит в npm-тарболл
  "pi": {
    "skills": ["./skills"],
    "image": "https://raw.githubusercontent.com/Serhioromano/gxw2-skill/main/assets/social-preview.png"
  },
  "main": "skills/gxw2-st/SKILL.md"   // убрать или переуказать; для skill-only пакета не критично
}
```

- Убрать `"type": "commonjs"` и старый `"main": "SKILL.md"` (после переезда файла путь устарел).
- `publishConfig.access: "public"` — если имя будет scoped (`@serhioromano/...`).

---

## 5. Шаги реализации

### Фаза 0 — зафиксировать текущее состояние
1. Закоммитить WIP: `SKILL.md`, `references/DB/00_Instruction_List.md`, `references/DB/ABSD.md` (M), удаление `references/instruction-db.md` (D).
   ```bash
   git add -A && git commit -m "chore: commit WIP before packaging as pi-package"
   ```

### Фаза 1 — реструктуризация (git mv сохраняет историю)
2. Создать `skills/gxw2-st/` и перенести содержимое навыка:
   ```bash
   mkdir -p skills
   git mv SKILL.md skills/gxw2-st/SKILL.md
   git mv references skills/gxw2-st/references
   git mv examples skills/gxw2-st/examples
   ```
3. Проверить, что внутри SKILL.md/справок **все относительные пути остаются валидны** — они разрешаются от директории навыка (`skills/gxw2-st/`), поэтому после переноса менять нечего. Прогнать поиск битых ссылок:
   ```bash
   grep -rn "](references/" skills/gxw2-st/ | head
   ```

### Фаза 2 — pi-манифест и метаданные
4. Обновить `package.json` (см. раздел 4).
5. Добавить `LICENSE` (MIT, © Serhioromano).
6. Обновить `README.md`:
   - заменить раздел Installation на `pi install`-команды (git/npm/local);
   - добавить раздел «Разработка» с указанием, что навык теперь в `skills/gxw2-st/`;
   - ручное копирование оставить как fallback.
7. Обновить `.pi/SYSTEM.md` (структура навыка изменилась — правило APPEND_SYSTEM.md).

### Фаза 3 — локальный тест
8. Пробный запуск без установки:
   ```bash
   pi -e /home/sergey/www/gxw2-skill
   # затем в сессии: /skill:gxw2-st
   ```
9. Полная установка из локального пути:
   ```bash
   pi install /home/sergey/www/gxw2-skill
   pi list            # пакет должен появиться
   pi config          # навык gxw2-st должен быть виден и включён
   ```

### Фаза 4 — миграция с ручной установки
10. Удалить устаревшую копию, чтобы не было конфликта имён:
    ```bash
    rm -rf ~/.agents/skills/gxw2-st
    ```
11. Перезапустить pi-сессию и убедиться, что в available skills навык `gxw2-st` резолвится из пакета (`~/.pi/agent/npm/...` или `~/.pi/agent/git/...`).

---

## 6. Каналы распространения

| Канал | Команда | Когда |
|-------|---------|-------|
| **Git (GitHub)** — основной | `pi install git:github.com/Serhioromano/gxw2-skill` | сразу после merge, без npm |
| **Локальный путь** — dev/тесты | `pi install /home/sergey/www/gxw2-skill` | разработка |
| **npm** — для галереи/обнаруживаемости | `pi install npm:gxw2-skill` (или `pi-gxw2-skill`) | после `npm publish` |
| **GitHub Actions** — автопубликация | тег `vX.Y.Z` → `npm publish` (как у pi-karpathy-skill) | опционально, позже |

---

## 7. Критерии готовности (чек-лист)

> **Статус: ВЫПОЛНЕНО ✅ (2025-08-02)** — все пункты закрыты, пакет установлен на этой машине из git-источника.

- [x] `pi install` (git и/или локальный путь) работает без ошибок
- [x] `pi list` показывает пакет; `pi config` показывает навык включённым
- [x] `/skill:gxw2-st` в сессии загружает навык
- [x] в списке available skills путь навыка — из пакета, дубликата `~/.agents/skills/gxw2-st` нет
- [x] все относительные ссылки внутри навыка (`references/`, `examples/`) валидны
- [x] `package.json` и `SKILL.md` версии синхронизированы (1.3.0)
- [x] LICENSE присутствует; npm-тарболл (`npm pack --dry-run`) содержит только нужное (README, LICENSE, skills/)
- [x] `.pi/SYSTEM.md` обновлён под новую структуру
- [x] README обновлён (установка через `pi install`)

### Итог реализации

- Реструктуризация: `git mv` → `skills/gxw2-st/` (история сохранена, 259 rename)
- `package.json`: `pi.skills: ["./skills"]`, keyword `pi-package`, `files[]`, version 1.3.0
- Добавлены `LICENSE` (MIT) и обновлён README (разделы Installation/Structure/Development)
- Коммиты `dec5cf8`, `6baebbd` запушены в `main` на GitHub
- Локальный тест: `pi install ./path` + функциональный прогон (TON-пример) — OK
- Миграция: старая копия `~/.agents/skills/gxw2-st` удалена, пакет переустановлен из `git:github.com/Serhioromano/gxw2-skill`
- Итоговая установка: `~/.pi/agent/git/github.com/Serhioromano/gxw2-skill/skills/gxw2-st/SKILL.md`
- Функциональный smoke-тест из git-клона (MEP/rising edge) — OK

### Осталось (опционально, не блокирует использование)

- [x] Makefile `make publish v=<patch|minor|major|X.Y.Z>` — полный workflow публикации в npm + GitHub release (адаптирован из pi-defender), проверен `make test` и логика версий/CHANGELOG
- [ ] Запустить реальную публикацию: `make publish v=patch` → `pi install npm:gxw2-skill` (нужен npm-логин)
- [ ] GitHub Actions: автопубликация npm по тегу `vX.Y.Z`
- [ ] `assets/social-preview.png` + поле `pi.image` для галереи pi.dev/packages

---

## 8. Риски и нюансы

1. **Конфликт имён `gxw2-st`:** старая ручная копия в `~/.agents/skills/` + пакет. Pi берёт первую найденную → удалить копию (шаг 10).
2. **Имя на npm:** `gxw2-skill` свободно (проверено). Если позже займут — `pi-gxw2-skill`.
3. **`.pi/` и `plans/` в корне:** не входят в `files[]` npm, но попадают в git-клон. Не мешают навыку (он живёт в `skills/`), но стоит добавить их в `.npmignore`/`files[]` для чистоты тарболла.
4. **Версии:** package.json (1.0.2) ≠ SKILL.md (1.3.0). Привести к 1.3.0 и впредь бампать синхронно.
5. **Язык контента:** навык и справки остаются на английском (правило APPEND_SYSTEM.md); план/README-метаданные можно на русском.
6. **Галерея pi.dev/packages:** чтобы пакет отображался, нужен keyword `pi-package` и опционально `image`/`video` — добавить `assets/social-preview.png`.

---

## 9. Примечания по альтернативам

- **Кросс-харнесс (Claude Code / Codex):** навык в `skills/gxw2-st/` уже соответствует Agent Skills spec, его можно шарить через `settings.skills` → `~/.claude/skills` (Pi поддерживает подключение чужих каталогов навыков). Это отдельная задача, не блокирует упаковку.
- **Не публиковать на npm вовсе:** git-канал достаточен; npm — только для галереи и удобства `pi install npm:...`.
