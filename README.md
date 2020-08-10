To set application you have to `bundle` and then create file `.env`

In `.env` file you must place valued for PROXY_TOKEN, AUTH_USER, AUTH_PASSWORD
PROXY_TOKEN - Token from https://proxycrawl.com/
AUTH_USER - user for API
AUTH_PASSWORD - password for API

Notes:
Authorization can be done in database if we want to have different keys. For example, each developer that want use that API shoul registrate and receive an token.

Some services/templates look the same. But if we want develop them, they easly can go in separate ways. So we don't need to worry to keep one massice service/template for all products.
