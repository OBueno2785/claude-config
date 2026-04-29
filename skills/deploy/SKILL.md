---
name: deploy
description: Ejecuta el checklist de pre-deployment y prepara el proyecto para producción.
disable-model-invocation: true
allowed-tools: Bash(git *) Bash(npm *) Bash(pnpm *) Bash(python *)
argument-hint: [entorno: staging|production]
---

Prepara el deployment a $ARGUMENTS (default: production).

Checklist pre-deploy:

1. **Estado del código**
   - `git status` — no debe haber cambios sin commitear
   - `git log origin/main..HEAD` — revisar commits pendientes de push

2. **Tests**
   - Ejecutar el comando de tests del proyecto (`npm test`, `pytest`, `pnpm test`)
   - Detener si hay tests fallando

3. **Build**
   - Ejecutar el build del proyecto (`npm run build`, `pnpm build`, etc.)
   - Verificar que no hay errores de compilación ni warnings críticos

4. **Variables de entorno**
   - Confirmar que `.env.production` o las variables del entorno destino están configuradas
   - Verificar que no hay claves hardcodeadas en el código (`git grep -i "api_key\|secret\|password"`)

5. **Resumen final**
   - Mostrar los últimos 5 commits que se van a deployar
   - Confirmar con el usuario antes de proceder

Si algún paso falla, detener y reportar el problema.
