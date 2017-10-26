public with sharing class FabricatorFactory {
    public static Fabricator getFabricator(Locale locale) {
        Type fab = FabricatorLocaleMapping.getLocaleFabricatorType(locale);
        
        return (Fabricator)fab.newInstance();
    }
}