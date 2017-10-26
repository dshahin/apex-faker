public with sharing class FabricatorLocaleMapping {
    private static final Map<Locale, Type> LOCALE_MAPPING = new Map<Locale, Type> {
        Locale.EN_US => Fabricator_EN_US.class
    };

    public static Type getLocaleFabricatorType(Locale locale) {
        return LOCALE_MAPPING.get(locale);
    }
}