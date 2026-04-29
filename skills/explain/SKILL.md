---
name: explain
description: Explica cómo funciona un fragmento de código, archivo o módulo usando analogías y diagramas ASCII. Usar cuando se pide "cómo funciona", "explícame esto" o "qué hace".
argument-hint: [archivo, función o fragmento]
---

Explica el código: $ARGUMENTS

Estructura de la explicación:

1. **Analogía** — comparar el código con algo del mundo real en una frase
2. **Diagrama ASCII** — mostrar el flujo, estructura o relaciones entre componentes
3. **Paso a paso** — explicar qué hace el código en orden de ejecución
4. **Gotcha** — señalar algo no obvio, un caso límite o una decisión de diseño que podría sorprender

Reglas:
- Explicar en español
- Adaptar el nivel de detalle al contexto (no explicar lo que ya es obvio)
- Usar nombres de variables y funciones del código real al explicar
- Para código complejo, priorizar el flujo de datos sobre los detalles de implementación
