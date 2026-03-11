---
title: "The pre-history: chroot and the first “fake filesystem”"
date: 2026-03-11
slug: "containers-prehistory-chroot-02"
tags: ["containers", "history", "unix", "linux"]
categories: ["dev"]
draft: true
---

Second part of a series:  _Containers, from roots to reality_

# The pre-history: chroot and the first “fake filesystem”

If containers are a modern religion, `chroot` is one of the earliest saints: obscure, misunderstood, and constantly credited with miracles it never actually performed.

`chroot` is not “a container.” It’s one ingredient. But it’s an important one, because it’s the moment we started telling a process:

> “No, you don’t get the whole machine. You get *this* little world. Behave.”

## What `chroot` does (the part people remember)

`chroot` changes a process’s idea of `/` — the root of the filesystem. From inside the jail, `/` is no longer the host’s real root. It’s whatever directory you pointed it at.

So if you `chroot` a process into `/srv/jail`, then inside the process:
- `/` *looks like* `/srv/jail`
- `/bin`, `/etc`, `/usr`… all resolve relative to that new root

That’s legitimately useful:
- testing software in a “clean” filesystem
- running old software with old libraries
- limiting accidental filesystem damage (sometimes)

## What `chroot` does *not* do (the part people forget)

`chroot` is **not** a complete isolation model. It only touches filesystem view. Everything else is still the same shared universe:

- same kernel
- same process table (unless something else isolates it)
- same network stack (unless something else isolates it)
- same users/permissions model (and root is still root)

Which means `chroot` is not a security boundary you can bet your job on. If you treat it like a vault, it will treat you like a mark.

Think of it this way:

> `chroot` is a locked door in a house where the windows are still open.

## Why `chroot` matters anyway

Because it introduced the core *shape* of container thinking:

1. Give a workload a constrained view of the world  
2. Make that constraint repeatable  
3. Compose multiple constraints until it starts to look like “a container”

`chroot` is the early move. It doesn’t win the game. But it’s the first time the OS says “we can partition reality,” even if it was just the filesystem.

## The trail forward (what comes next)

Once you’ve tasted filesystem isolation, you immediately want the rest:

- “Can I hide other processes too?” (PID isolation)
- “Can I give it its own network stack?” (NET namespaces later)
- “Can I stop it from eating the whole machine?” (cgroups later)
- “Can I keep ‘root’ from being god?” (user namespaces later)

That’s how you end up with jails, zones, namespaces, cgroups — and eventually the container stack everyone pretends was obvious.

## What to remember

- `chroot` is **filesystem view isolation**.
- It’s **useful**, but **not sufficient** for “container-level” isolation.
- Containers are the result of **composing multiple isolation and control mechanisms**, not one clever trick.

## Sources

- Linux Foundation overview (roots of containers; includes historical context for `chroot`): https://www.linuxfoundation.org/blog/blog/a-brief-look-at-the-roots-of-linux-containers  
- Version 7 Unix context (often cited in the `chroot` timeline): https://en.wikipedia.org/wiki/Version_7_Unix  
