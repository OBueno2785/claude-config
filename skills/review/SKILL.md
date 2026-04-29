---
name: review
description: Revisa el código de los cambios actuales o de un archivo específico. Busca bugs, problemas de seguridad, código muerto y mejoras de calidad.
context: fork
agent: Explore
argument-hint: [archivo o ruta opcional]
---

Revisa el código indicado en $ARGUMENTS. Si no se especifica nada, revisar todos los cambios no commiteados (`git diff`).

Analizar en este orden:

1. **Bugs y errores lógicos** — condiciones incorrectas, null/undefined sin manejar, race conditions
2. **Seguridad** — inyecciones (SQL, command, XSS), credenciales hardcodeadas, datos expuestos
3. **Calidad** — código duplicado, funciones demasiado largas, nombres confusos
4. **Rendimiento** — bucles innecesarios, queries N+1, memoria no liberada
5. **Tests** — si hay lógica nueva, ¿tiene tests?

Formato de respuesta:
- Listar hallazgos con severidad: 🔴 crítico / 🟡 advertencia / 🔵 sugerencia
- Para cada hallazgo: archivo:línea — descripción — cómo corregirlo
- Si no hay problemas, decirlo claramente.
