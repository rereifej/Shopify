# Shopify Customer Migration and Activation

This script iterates through the [Shopify](https://www.shopify.com/?ref=createur) customers list, generates activation URLs for each, then dumps them into a CSV file. It was written by [Createur](http://createur.com.au/) to help migrate large customer lists into Shopify from another platform.

Consider this very much a work in progress, with no guarantees offered as to its completeness. We'll try to update it as we add features to our own API methods for this. It's quick and dirty, so don't expect too much elegance. We'll improve it over time and keep it public here.

## Config

We assume that you have a `config.yml` saved in your root, next to the `activate.rb` script.

```
---
:api_key: xxxx
:password: xxxx
:store: storename.myshopify.com
```

We recommend you **don't** commit auth credentials to your codebase, so you should add `config.yml` to your `.gitignore` and keep this separate from any script modifications you make.

## Limitation of Liability

- Use at your own risk
- No responsibility accepted if this script breaks your things
