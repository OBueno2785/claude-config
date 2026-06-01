# Contribuir a claude-config

Guía para Claude Code (y para Oscar) al trabajar en este repositorio.

## Qué es este repo

No es una aplicación. Es la **configuración global de Claude Code** que se distribuye a todas las máquinas:

- `CLAUDE.md` — instrucciones globales. **Es un artefacto que se instala**, no documentación interna. `install.*` lo copia tal cual a `~/.claude/CLAUDE.md`. No lo conviertas en una guía meta del repo.
- `skills/<nombre>/SKILL.md` — librería de skills. Cada subdirectorio es una skill; `install.*` copia cada `SKILL.md` a `~/.claude/skills/<nombre>/SKILL.md`.
- `install.ps1` (Windows) / `install.sh` (Unix/Mac/WSL) — instaladores espejo. **Cualquier cambio en la lógica de instalación debe replicarse en ambos.**
- `README.md` — incluye la tabla de skills disponibles.

`install.ps1` itera sobre `skills/*/` automáticamente, así que **añadir una skill no requiere tocar los instaladores** — basta con crear su directorio.

## Cómo añadir una skill

1. Crear `skills/<nombre>/SKILL.md` (el directorio debe llamarse igual que `name`).
2. Frontmatter YAML obligatorio:
   - `name` — kebab-case, igual al directorio.
   - `description` — en español; indica explícitamente cuándo invocarla (frases gatillo como *"crea un componente"*, *"genera changelog"*). Es lo que usa el modelo para auto-invocar.
   - `argument-hint` — formato esperado de `$ARGUMENTS` (opcional).
3. El cuerpo es el prompt de la skill. Usa `$ARGUMENTS` para los argumentos del usuario.
4. Añadir la fila correspondiente a la tabla del `README.md`.

### Skills manuales vs. auto-invocables

- **Auto-invocable** (por defecto): el modelo puede lanzarla según la `description`. Para revisiones largas puede correr en subagente: `context: fork` + `agent: Explore`.
- **Manual** (solo `/skill`): añadir `disable-model-invocation: true`. Reservado para acciones sensibles o con efectos (git push, deploy, commits, migraciones).
- Restringir herramientas con `allowed-tools`, p. ej. `Bash(git *) Bash(gh *)`. Aplícalo siempre a skills que ejecutan comandos.

## Convenciones del proyecto

- Todo el contenido de skills y `CLAUDE.md` va en **español**.
- En Windows, `gh` está en `C:\Program Files\GitHub CLI\gh.exe`.
- Al publicar/cerrar fase: `git add -A`, commit descriptivo, y `gh repo create` o `git push` (ver `skills/github-push/SKILL.md`). Nunca `--no-verify` ni `push --force` a main.

## Verificar la instalación

No hay tests. Para validar cambios, ejecutar el instalador y confirmar que `~/.claude/CLAUDE.md` y `~/.claude/skills/` quedan actualizados:

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```
```bash
bash install.sh
```
