---
name: fix-bug
description: Diagnostica y corrige un bug de forma sistemática. Usar cuando hay un error, excepción o comportamiento inesperado.
argument-hint: [descripción del bug o archivo]
---

Corrige el bug: $ARGUMENTS

Proceso de diagnóstico:

1. **Reproducir** — entender exactamente cuándo ocurre (inputs, condiciones, entorno)
2. **Localizar** — buscar en el código el punto exacto del fallo con Grep y Read
3. **Causa raíz** — identificar POR QUÉ ocurre, no solo dónde
4. **Hipótesis** — plantear la corrección mínima que resuelve la causa raíz
5. **Corregir** — aplicar el fix más pequeño posible sin refactorizar código circundante
6. **Verificar** — confirmar que la corrección resuelve el problema

Reglas:
- No introducir refactorizaciones ni limpiezas no relacionadas con el bug
- No agregar manejo de errores para casos que no pueden ocurrir
- Si el bug revela un problema de diseño mayor, mencionarlo pero no resolverlo sin pedir confirmación
