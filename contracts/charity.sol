pragma solidity ^ 0.5.0;
contract charity {

  uint public charity_count = 0;


  uint public org_count = 0;

  struct charity_structre {
    string name;
    string description;
    string bankAccount;
    string bankName;
    uint id;
    bytes32 hash;
    address address_of_charity;
    string  ether_coins;


  }

  struct personOrOrganisation_structure {

    string name;
    string bankAccount;
    string bankName;
    uint id;
    bytes32 hash;
    address address_of_organisation;



  }

  constructor() public {

      createCharity("anand_charity", "welcome to anand's charity, this is a default charity as I created this web page","bankacc","bankname",0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c,"0");

      createOrganisation("anand_organisation","bank account","bank name",0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);
  }

  mapping(uint => charity_structre) public charitys;


  mapping(uint => personOrOrganisation_structure) public org;

  event charityCreated(

    string name,
    string description,
    string bankacc,
    string bankname,
    uint id,
    bytes32 hash,
    address address_of_charity

  );


  event organisationCreated(


    string name,
    string bankacc,
    string bankname,
    uint id,
    bytes32 hash,
    address address_of_organisation
  );


  function createCharity(string memory _name, string memory _description, string memory _bankacc, string memory _bankname, address _address, string memory _ether_coins) public returns(uint){

      charity_count++;
      bytes memory name_byte = bytes(_name);
      bytes memory description_byte = bytes(_description);
      bytes memory bankacc_byte = bytes(_bankacc);
      bytes memory bankname_byte = bytes(_bankname);
      //string memory newStr = string(_address);
      //bytes memory address_byte = bytes(_address);
      string memory lengthabc = new string(name_byte.length + description_byte.length + bankacc_byte.length + bankname_byte.length );
      bytes memory hash = bytes(lengthabc);
      uint k = 0;
      for(uint i =0;i < name_byte.length; i++){
          hash[k] = name_byte[i];
          k++;
      }
      for(uint i = 0;i < description_byte.length;i++){
          hash[k] = description_byte[i];
          k++;
      }
      for(uint i = 0;i < bankacc_byte.length;i++){
          hash[k] = bankacc_byte[i];
          k++;
      }
      for(uint i = 0;i < bankname_byte.length;i++){
          hash[k] = bankname_byte[i];
          k++;
      }
      /*
      for(uint i = 0;i < address_byte.length; i++ ){

          hash[k] = address_byte[i];
          k++;
      }
      */

      bytes32 hash_address = keccak256(hash);
      //charitys[charity_count] = charity_structre(_name,_description,_bankacc,_bankname,charity_count,hash_address,_address);

      charitys[charity_count].name = _name;
      charitys[charity_count].description = _description;
      charitys[charity_count].bankAccount = _bankacc;
      charitys[charity_count].bankName = _bankname;
      charitys[charity_count].id = charity_count;
      charitys[charity_count].hash = hash_address;
      charitys[charity_count].address_of_charity = _address;
      charitys[charity_count].ether_coins = _ether_coins;
      //emit charityCreated(_name,_description,_bankacc,_bankname,charity_count,hash_address,_address);

      return(charity_count);


  }


  function createOrganisation(string memory _name, string memory _bankacc, string memory _bankname, address _address) public returns(uint){

    org_count ++;

    bytes memory name_byte = bytes(_name);
    bytes memory acc_byte = bytes(_bankacc);
    bytes memory bankname_byte = bytes(_bankname);
    //bytes memory address_byte = bytes(_address);
    string memory lengthabc = new string(name_byte.length + acc_byte.length + bankname_byte.length );
    bytes memory hash = bytes(lengthabc);

    uint k = 0;

    for(uint i = 0; i < name_byte.length;i++) {

      hash[k] = name_byte[i];
      k++;
    }

    for(uint i = 0; i < acc_byte.length; i++){

      hash[k] = acc_byte[i];
      k++;

    }


    for(uint i = 0; i < bankname_byte.length; i++) {

      hash[k] = bankname_byte[i];
      k++;
    }

    /*
    for(uint i = 0;i < address_byte.length; i++) {

      hash[k] = address_byte[i];
      k++;

    }
    */


    bytes32 hash_address = keccak256(hash);

    //org[org_count] = personOrOrganisation_structure(_name,_bankacc,_bankname,org_count,hash_address,_address);


    org[org_count].name = _name;
    org[org_count].bankAccount = _bankacc;
    org[org_count].bankName = _bankname;
    org[org_count].id = org_count;
    org[org_count].hash = hash_address;
    org[org_count].address_of_organisation = _address;


    //emit organisationCreated(_name,_bankacc,_bankname,org_count,hash_address,_address);

    return org_count;


  }


/*
  function parseAddr(string memory _a) public returns (address _parsedAddress) {
    bytes memory tmp = bytes(_a);
    uint160 iaddr = 0;
    uint160 b1;
    uint160 b2;
    for (uint i = 2; i < 2 + 2 * 20; i += 2) {
        iaddr *= 256;
        b1 = uint160(uint8(tmp[i]));
        b2 = uint160(uint8(tmp[i + 1]));
        if ((b1 >= 97) && (b1 <= 102)) {
            b1 -= 87;
        } else if ((b1 >= 65) && (b1 <= 70)) {
            b1 -= 55;
        } else if ((b1 >= 48) && (b1 <= 57)) {
            b1 -= 48;
        }
        if ((b2 >= 97) && (b2 <= 102)) {
            b2 -= 87;
        } else if ((b2 >= 65) && (b2 <= 70)) {
            b2 -= 55;
        } else if ((b2 >= 48) && (b2 <= 57)) {
            b2 -= 48;
        }
        iaddr += (b1 * 16 + b2);
    }
    return address(iaddr);
}
*/


function transaction_org_to_charity(address add_of_charity,address add_of_org,uint amount) public {


  uint index_charity = 0;
  uint index_org = 0;
  uint flag1=0;
  uint flag2=0;

  for(uint i =0;i<charity_count;i++) {

    if(charitys[i].address_of_charity == add_of_charity){

        flag1 = 1;
        index_charity = i;

    }
  }

  for(uint i = 0;i<org_count;i++) {

      if(org[i].address_of_organisation == add_of_org) {
          flag2 = 1;
          index_org = i;
      }

  }

  if(flag1 == 1 && flag2 ==1){



  }





}


}
