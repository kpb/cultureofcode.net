---
title: "The Pre-History: chroot and the First Fake Filesystem"
date: 2026-03-23
slug: "containers-prehistory-chroot-02"
tags: ["containers", "history", "unix", "linux"]
categories: ["dev"]
series: "containers"
series_title: "Containers: How We Learned to Stop Worrying and Love the Host Kernel"
series_part: 2
series_total: 12
series_prev: "/blog/dev/containers/containers-one-sentence-01/"
series_next: "/blog/dev/containers/part-03/"
series_toc: "/blog/dev/containers/"
draft: false
---

If containers are a modern religion, _chroot_ is one of the earliest saints.
<!--more-->
Obscure, misunderstood, and constantly credited with miracles it never actually performed.


_chroot_ is not “a container.” It’s one ingredient. But it’s an important one, because it’s the moment we started
telling a process, "No, you don’t get the whole machine. You only get this little slice. Behave."

## What _chroot_ does

_chroot_ changes a process’s idea of `/`, the root of the filesystem. From inside the _chroot jail_, `/` is no longer
the host’s real root. It’s whatever directory you pointed it at.

After `chroot /srv/jail`, any absolute path like `/etc/hosts` is interpreted as `/srv/jail/etc/hosts` on the host filesystem.

That’s legitimately useful:
- testing software in a “clean” filesystem
- running old software with old libraries
- limiting accidental filesystem damage (sometimes)

## What _chroot_ does not do

_chroot_ is **not** a complete isolation model. It only touches filesystem view. Everything else is still the same shared universe:

- same kernel
- same process table (unless something else isolates it)
- same network stack (unless something else isolates it)
- same users/permissions model (and root is still root)

Which means _chroot_ is not a security boundary you can bet your job on. If you treat it like a vault, it will treat you like a mark.

Think of it this way: _chroot_ is a locked door in a house where the windows are still open.

## Why _chroot_ matters anyway

It matters because it introduced the core shape of container thinking. Give a workload a constrained view of the world. Make that
constraint repeatable. Compose multiple constraints until it starts to look like “a container.”

_chroot_ is the early move. It doesn’t win the game. But, it’s the first time the OS says “we can partition reality,”
even if it was just the filesystem.

## What comes next

Once you’ve tasted filesystem isolation, you immediately want the rest:

- “Can I hide other processes?” (PID isolation)
- “Can I give it its own network stack?” (NET namespaces later)
- “Can I stop it from eating the whole machine?” (cgroups later)
- “Can I keep ‘root’ from being god?” (user namespaces later)

That’s how you end up with jails, zones, namespaces, cgroups — and eventually the container stack everyone pretends was obvious.

## What to remember

_chroot_ is filesystem view isolation. It’s useful, but not sufficient, for “container-level” isolation. Containers are
the result of composing multiple isolation and control mechanisms, not one clever trick.

## Sources

- Linux Foundation overview (roots of containers; includes historical context for _chroot_): https://www.linuxfoundation.org/blog/blog/a-brief-look-at-the-roots-of-linux-containers  
- Version 7 Unix context (often cited in the _chroot_ timeline): https://en.wikipedia.org/wiki/Version_7_Unix  
