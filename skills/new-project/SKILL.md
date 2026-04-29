---
name: new-project
description: Inicializa un nuevo proyecto con estructura básica, git y configuración esencial. Usar cuando se va a comenzar un proyecto desde cero.
disable-model-invocation: true
argument-hint: [nombre] [tipo: python|node|react|nextjs|fastapi]
---

Crea un nuevo proyecto: $ARGUMENTS

1. **Preguntar** (si no se especificó):
   - Nombre del proyecto
   - Tipo: python / node / react / nextjs / fastapi

2. **Crear estructura** según el tipo:
   - `python`: `src/`, `tests/`, `requirements.txt`, `venv`
   - `node`: `src/`, `package.json` con scripts básicos
   - `react`: usar Vite (`npm create vite@latest`)
   - `nextjs`: usar `npx create-next-app@latest`
   - `fastapi`: `app/`, `tests/`, `requirements.txt`, `main.py`

3. **Inicializar git**:
   - `git init -b main`
   - Crear `.gitignore` apropiado para el tipo de proyecto
   - Commit inicial: `chore: initial project setup`

4. **Confirmar** mostrando la estructura de directorios creada.

No crear README salvo que se pida explícitamente.
