public abstract with sharing class Fabricator {
    /**
     * An apex implementation of the Faker library
     * <p>
     * Borrows/references other language implementations including
     * Python -> https://github.com/joke2k/faker  
     * Java -> https://github.com/DiUS/java-faker 
     * </p>
     * Fabrictors should be generated through through the FabricatorFactory
     * which handles localization. Otherwise the Fabricator will default to
     * English locale
     *<p>
     * Large data sets like name, are stored in the Fabricator_Data custom
     * metadata type. Smaller data sets and formatting are stored in the 
     * fabricator locale class e.g Fabricator_EN_US
     *</p>
    */

    public FabricatorData data;

    private List<String> firstNames;

    /**
     * Constructor
     * @return none
    */
    public Fabricator() {
        List<Fabricator_Data__mdt> fabDataRecords = [SELECT Data__c FROM Fabricator_Data__mdt WHERE DeveloperName = :this.getLocaleCode().name()];
        
        if(fabDataRecords.size() != 1) {
            throw new FabricatorException('No data found for that locale');
        }

        this.data = (FabricatorData)JSON.deserialize(fabDataRecords[0].Data__c, FabricatorData.class);

        //combine female and male arrays of first names
        this.firstNames = new List<String>();
        
        //NOTE: should this throw exception if null?
        if(data.femaleNames != null) {
            this.firstNames.addAll(data.femaleNames);
        }

        //NOTE: should this throw exception if null?
        if(data.maleNames != null) {
            this.firstNames.addAll(data.maleNames);
        }
    }

    /***********************************
        Public Functions
    ************************************/
    

    public String firstName() {
        return this.firstNames[this.getRandomNumber(this.firstNames.size())];
    }

    public String lastName() {
        if(this.data.lastNames == null) {
            throw new FabricatorException('Data set is missing last names');
        }

        return this.data.lastNames[this.getRandomNumber(this.data.lastNames.size())];
    }

    public String fullName() {
        String fullNameFormat = this.getNameFormats()[this.getRandomNumber(this.getNameFormats().size())];

        return String.format(fullNameFormat, new List<String>{this.firstName(), this.lastName(), this.lastName()});
    }

    /***********************************
        Private Functions
    ************************************/

    //TODO: could be moved into a FabricatorUtils if
    // a # of util functions grows
    private Integer getRandomNumber(Integer upperBound) {
        return (Integer)Math.floor(Math.random() * upperBound);
    }

    private virtual List<String> getNameFormats() {
        return new List<String>{
            '{0} {1}',
            '{0} {1}-{2}'
        };
    }

    /***********************************
        Abstract Functions 
    ************************************/
    private abstract Locale getLocaleCode();

}