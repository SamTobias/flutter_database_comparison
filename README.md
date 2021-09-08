# flutter_database_comparison

Comparing SQLite database packages for Flutter

## Packages

- [SQFlite](https://github.com/tekartik/sqflite)
- [Floor](https://floor.codes/)
- [Moor](https://moor.simonbinder.eu/) (Pending comparison)

## Requirements

What do I think a good database package needs?
- Good documentation
- Active development / maintenance
- Migration support
- Cross-platform support
- Reliable
- Easy to use
- ...?

## Comparison

| Feature | SQFlite | Floor | Moor
--- | --- | --- | ---
| Cross-platform support | ✅ | ✅ | ✅
| Migration | ✅ | ✅ | ✅
| Good documentation | ☑ | ✅ | 🤔
| Active development | ✅ | ✅ | ✅
| Easy to use | ✅ | ✅ | 🤔
| In Memory Database | 🤔 | ✅ | ✅
| Null Safety Entities | ❌ | ✅ | ✅
| Encription | ☑ | ❌ | ✅ 
| Compile-time Query Validation | ❌ | ❌ | ✅

- ✅ : Yes
- ❌ : No
- ☑ : Partially
- 🤔 : Not verified yet

## Examples

- [SQFlite](./sqflite_sample)
- [Floor](./floor_sample)
- [Moor](./moor_sample)

## Contributing

Feel free to increase this comparison by submitting a Pull Request or creating an issue
