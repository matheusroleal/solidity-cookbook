pragma solidity ^0.6.1;

contract StoreData {

    // Data related to the transaction
    mapping (string => bool) private user_transaction;
    mapping (string => bool) private admins;
    
    // Transaction data map
    mapping (string => string) private data;
    
    function setTransaction(string memory data_to_send, string memory user_id) public returns(string memory){
        // Concatenate sender and time in one string
        string memory transaction_id = string(abi.encodePacked(user_id,Time_call()));
        
        // Add transaction info in maps
        user_transaction[strConcat(user_id,transaction_id)] = true;
        data[transaction_id] = data_to_send;
        
        // return the transaction id
        return transaction_id;
    }

    function getData(string memory tran_id, string memory user) public returns (string memory){
        if(checkUser(user,tran_id) == true){
            return data[tran_id];
        }
        return "No Data Found For This Transaction";
    }
    
    function checkUser(string memory user_id, string memory tran_id) internal returns (bool){
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
    
    function strConcat(string memory _a, string memory _b) internal returns (string memory){
	    bytes memory _ba = bytes(_a);
	    bytes memory _bb = bytes(_b);
	    string memory ab = new string(_ba.length + _bb.length);
	    bytes memory bab = bytes(ab);
	    uint k = 0;
	    for (uint i = 0; i < _ba.length; i++) bab[k++] = _ba[i];
	    for (uint i = 0; i < _bb.length; i++) bab[k++] = _bb[i];
	    return string(bab);
	}
    

}
