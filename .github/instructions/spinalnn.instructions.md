---
description: "Apply when creating, editing, or refactoring any .scala file in this project."
applyTo: "**/*.scala"
---

# spinalnn Coding Rules

See [docs/PATTERN_GUIDE.md](docs/PATTERN_GUIDE.md) for the full architecture overview.

## Core

- `object`, not `class`
- Returns `case class Io` -- never `Bundle`
- All `Reg` and `Mem` inside `new PrefixArea(periphName)`
- `require()` guards before any hardware
- No `Component` instantiation inside `build()`

## Plugin

- `case class` extending `FiberPlugin`
- Handles as `val` fields on the class body, outside `during build`
- Single `val logic = during build new Area { }` per plugin
- No `Reg`, `when`, or signal assignments outside `during build`
- Consume upstream: `host[SomeTrait].someHandle.await`
- Publish result: `someHandle.load(value)`

## TopIoExportPlugin

- Phase 1: all `.load()` calls (non-blocking)
- Phase 2: all `.await()` calls (blocking)
- `Try(host[X]).toOption` for any plugin that might be absent
- `case None` always drives a safe constant

## Naming

- Plugin: `XxxPlugin`
- Core: `XxxCore`
- Harness: `XxxHarness`
- Test: `XxxCoreTest`
- Registers: `${periphName}_xxxReg` via `PrefixArea`
- Top IO ports: `snake_case` via `setName()`
