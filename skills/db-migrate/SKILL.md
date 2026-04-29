---
name: db-migrate
description: Valida una migración de base de datos antes de aplicarla. Detecta cambios destructivos y verifica reversibilidad. Usar antes de ejecutar migraciones en staging o producción.
argument-hint: [archivo de migración o nombre]
---

Valida la migración: $ARGUMENTS

Si no se especifica archivo, buscar la migración más reciente en los directorios comunes (`migrations/`, `prisma/migrations/`, `alembic/versions/`).

Checklist de seguridad:

1. **Cambios destructivos** — buscar:
   - `DROP TABLE`, `DROP COLUMN`, `TRUNCATE`
   - `ALTER COLUMN` que cambia tipo de datos (puede perder datos)
   - Eliminación de índices únicos o constraints

2. **Reversibilidad** — verificar si existe script de rollback (`down()`, `downgrade()`, migración inversa)

3. **Datos existentes** — si hay `NOT NULL` en columna nueva sin `DEFAULT`, fallará en tablas con datos

4. **Rendimiento** — operaciones que bloquean la tabla en producción:
   - `ADD COLUMN` con `DEFAULT` en tablas grandes (PostgreSQL < 11)
   - `CREATE INDEX` sin `CONCURRENTLY`
   - Reescritura de tabla completa

5. **Nomenclatura** — nombre de migración describe el cambio

Resultado: 🟢 segura / 🟡 advertencias (continuar con cuidado) / 🔴 riesgo alto (no aplicar sin revisión)
