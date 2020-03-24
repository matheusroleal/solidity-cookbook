pragma solidity ^0.5.3;
pragma experimental ABIEncoderV2;

contract StoreData {

    // Data related to the transaction
    mapping (string => bool) private user_transaction;
    mapping (string => bool) private admins;
    
    // Transaction data map
    mapping (string => string) private data;
    
    //List of transaction_id
    mapping (string => string) private transaction_id_list;

    function setTransaction(string[] memory dataBulk, string memory user_id) public {
        for(uint i = 0; i < dataBulk.length; i++){
            string memory data_to_send = dataBulk[i];
            
            // Concatenate sender and time in one string
            string memory transaction_id = strConcat(data_to_send,uint2str(Time_call()));
            
            // Add transaction info in maps
            user_transaction[strConcat(user_id,transaction_id)] = true;
            data[transaction_id] = data_to_send;
            transaction_id_list[user_id] = strConcat(strConcat(transaction_id_list[user_id],","),transaction_id);
        }
    }
    
    function getTrasanctionIds(string memory user) public view returns (string memory){
        return transaction_id_list[user];
    }

    function getData(string memory tran_id, string memory user) public view returns (string memory){
        if(checkUser(user,tran_id) == true){
            return data[tran_id];
        }
        return "No Data Found For This Transaction";
    }
    
    function checkUser(string memory user_id, string memory tran_id) internal view returns (bool){
        if (user_transaction[strConcat(user_id,tran_id)] == true){
            return true;
        } else if(admins[user_id]){
            return true;
        }
        return false;
    }

    // Utils function
    function Time_call()private returns (uint256){
        return now;
    }
    
    function strConcat(string memory _s1, string memory _s2)internal pure returns (string memory _concatString){
        bytes memory _s;

        _s = abi.encodePacked(_s1);
        _s = abi.encodePacked(_s, _s2);
        
        return string(_s);
    }
    
	function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }
    

}
