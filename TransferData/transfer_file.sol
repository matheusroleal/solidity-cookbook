pragma experimental ABIEncoderV2;

contract TransferFile {

    // Data related to the transaction
    mapping (string => bool) private transaction;
    mapping (string => string) private data;

    // Store file transaction data
    struct Transfer {
        string sender;
        string receiver;
        string transactionId;
        string fileId;
    }

    Transfer[] transactions;

    function setTransaction(string memory data_to_send, string memory receiver) public payable {
        // Change sender to string
        string memory transaction_sender = toString(msg.sender);
        // Concatenate sender, receiver, and time in one string
        string memory transaction_id = string(abi.encodePacked(transaction_sender,receiver,Time_call()));
        // Add transaction info in maps
        transaction[transaction_id] = true;
        data[transaction_id] = data_to_send;
        // Store data of the transaction
        transactions.push(Transfer({sender: transaction_sender, receiver: receiver, transactionId: transaction_id, fileId: data_to_send}));
    }

    function getTransctions() public payable returns(Transfer [] memory){
        return transactions;
    }

    function getFile(string memory tran_id) public returns (string memory){
        require(transaction[tran_id] == true, "No File Found For This Transaction");
        return data[tran_id];
    }

    function hasTransaction(string memory tran_id)public returns(bool){
        return transaction[tran_id];
    }

    // Utils fun
    function toString(address x)private returns (string memory) {
        bytes memory b = new bytes(20);
        for (uint i = 0; i < 20; i++){
            b[i] = byte(uint8(uint(x) / (2**(8*(19 - i)))));
        }
        return string(b);
    }

    function Time_call()private returns (uint256){
        return now;
    }

}
