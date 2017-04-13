global class AccRecordsDisplayCls{
    webservice static string returnrecords(){
    string output ='';
    List<account> accList = [select id, name from account limit 50];
    output = json.serialize(accList);
    return output;
    }
}