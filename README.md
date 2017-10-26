# fabricator
Implementation of popular faker libraries in apex. Generates randomized localized fake data.

## Usage
```
Fabricator fab = FabricatorFactory.getFabricator(Locale.EN_US);
system.debug(fab.fullName());
```
## Supported Data
* Names (first, last, full)

## Supported Locales
* EN_US : United States
