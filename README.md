# qb-crates
## Description
Treasure crates with loot for QBCore FiveM servers. The crates can contain money (dirty/clean), weapons or items. Supports multiple crates and the script keeps track of which one was opened by who.
## Dependencies
* [qb-target](https://github.com/qbcore-framework/qb-target)

## Setup
* Install into resources/[QBCore]
* Import `qb-crates.sql` in your database
* Add the following line to your server.cfg
```
start qb-crates
```

* If you want the crate to be opened only once/server, you have to set `Config.OnePersonOpen` to `true` in `config.lua`. On `false`, each player can open the crate once.
* If you want the crates to give dirty money instead of clean cash, you have to set `Config.IsMoneyDirtyMoney` to `true` in `config.lua`.

## Credits for the orginal script
https://github.com/KlibrDM/esx_treasure 
