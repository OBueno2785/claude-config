---
name: deps
description: Audita las dependencias del proyecto: versiones desactualizadas, vulnerabilidades conocidas y paquetes no usados. Usar cuando se pide "actualiza dependencias", "revisa paquetes" o "audita dependencias".
disable-model-invocation: true
allowed-tools: Bash(npm *) Bash(pnpm *) Bash(pip *) Bash(python *)
---

Audita las dependencias del proyecto actual:

**Para proyectos Node.js / npm / pnpm:**
1. `npm outdated` o `pnpm outdated` — listar paquetes desactualizados
2. `npm audit` o `pnpm audit` — vulnerabilidades conocidas
3. Identificar dependencias en `package.json` que no aparecen en el código fuente

**Para proyectos Python:**
1. `pip list --outdated` — paquetes desactualizados
2. `pip-audit` si está disponible, o revisar CVEs conocidos de los paquetes críticos
3. Comparar `requirements.txt` con imports reales en el código

**Clasificar hallazgos:**
- 🔴 Vulnerabilidades de seguridad críticas → actualizar de inmediato
- 🟡 Versiones muy desactualizadas (major version atrás) → planificar actualización
- 🔵 Actualizaciones menores disponibles → opcional
- ⚫ Dependencias no usadas → candidatas a eliminar

Mostrar el resumen y preguntar qué actualizaciones aplicar antes de hacer cambios.
