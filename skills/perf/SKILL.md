---
name: perf
description: Analiza y optimiza el rendimiento de código o una ruta específica. Usar cuando hay lentitud, alto consumo de memoria o problemas de escalabilidad.
argument-hint: [archivo, función o descripción del problema]
---

Analiza el rendimiento de: $ARGUMENTS

Áreas a investigar según el tipo de proyecto:

**Backend / Python / Node.js:**
- Queries N+1 — llamadas a DB dentro de bucles
- Carga de datos innecesaria — traer más datos de los que se usan
- Operaciones síncronas bloqueantes que deberían ser async
- Caches faltantes para datos que no cambian frecuentemente
- Bucles O(n²) que pueden simplificarse

**Frontend / React:**
- Re-renders innecesarios — componentes sin `memo`, `useCallback`, `useMemo`
- Imports de librerías pesadas sin tree-shaking
- Imágenes sin optimizar o sin lazy loading
- Bloqueo del hilo principal con operaciones CPU-intensas

**General:**
- Lectura/escritura de archivos en bucles
- Llamadas de red en serie que podrían hacerse en paralelo

Proceso:
1. Leer el código objetivo
2. Identificar los cuellos de botella más impactantes (no optimizar prematuramente lo trivial)
3. Proponer las optimizaciones ordenadas por impacto vs esfuerzo
4. Implementar solo las aprobadas por el usuario si son cambios grandes
