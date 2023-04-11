Mount your own `users.acl` file to `/redis/conf/users.acl` and enable multi-user access control.

Mount your own:

- `cert.pem` file to `/redis/cert/cert.pem`.
- `key.pem` file to `/redis/cert/key.pem`.

to enable TLS on Redis server.

### Example (Redis server without TLS)

```yaml
version: '3.9'

services:
  redis:
    container_name: redis
    image: 'dongsxyz/redis:latest'
    restart: always
    volumes:
      - type: bind
        source: ./users.acl
        target: /redis/conf/users.acl
    ports:
      - 6379:6379
```
