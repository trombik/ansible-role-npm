# `trombik.npm`

`ansible` role for `npm`.

# Requirements

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `npm_package` | Name of package | `{{ __npm_package }}` |
| `npm_extra_packages` | List of extra packages to install | `[]` |

## Debian

| Variable | Default |
|----------|---------|
| `__npm_package` | `npm` |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__npm_package` | `www/npm` |

## OpenBSD

| Variable | Default |
|----------|---------|
| `__npm_package` | `node` |

## RedHat

| Variable | Default |
|----------|---------|
| `__npm_package` | `nodejs` |

# Dependencies

# Example Playbook

```yaml
---
- hosts: localhost
  roles:
    - role: trombik.redhat_repo
    - role: ansible-role-npm
  pre_tasks:
    - name: Dump all hostvars
      debug:
        var: hostvars[inventory_hostname]
  post_tasks:
    - name: List all services (systemd)
      # workaround ansible-lint: [303] service used in place of service module
      shell: "echo; systemctl list-units --type service"
      changed_when: false
      when:
        # in docker, init is not systemd
        - ansible_virtualization_type != 'docker'
        - ansible_os_family == 'RedHat' or ansible_os_family == 'Debian'
    - name: list all services (FreeBSD service)
      # workaround ansible-lint: [303] service used in place of service module
      shell: "echo; service -l"
      changed_when: false
      when:
        - ansible_os_family == 'FreeBSD'
  vars:
    redhat_repo:
      nodesource:
        baseurl: https://rpm.nodesource.com/pub_12.x/el/$releasever/$basearch
        gpgcheck: yes
        gpgkey: https://rpm.nodesource.com/pub/el/NODESOURCE-GPG-SIGNING-KEY-EL
```

# License

```
Copyright (c) 2020 Tomoyuki Sakurai <y@trombik.org>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <y@trombik.org>
