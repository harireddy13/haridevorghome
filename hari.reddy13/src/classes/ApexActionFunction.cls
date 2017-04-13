Public class ApexActionFunction {
Public string MyString_From_Methode{get;set;}

    public ApexActionFunction(ApexPages.StandardController controller) {

    }

    public string ActionFunMethode(){
     MyString_From_Methode = 'Method called from js using Action function';
     return null;
    }
}