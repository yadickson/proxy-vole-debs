# proxy-vole-debs
Build Debian Package for Proxy Vole (v1.0.1-SNAPSHOT)

**Instructions**

Inside of the debs folder

**Gets orig source code**

```
debian/rules get-orig-source
```

**Check dependencies**

```
dpkg-checkbuilddeps
```

**Build source package**

```
debuild -S -nc -uc -us
```

**Tested**

```
Debian jessie
```

