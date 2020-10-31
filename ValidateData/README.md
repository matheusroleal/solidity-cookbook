# Validate Data
Verifying Documents Through a Blockchain System.

## What it is ?

It is common to need to confirm that we agree with a document. Currently, this process is done through intermediaries, manual tasks, or digital systems that emulate tasks that we would do personally. We can say that even efficient, none of the tasks is agile enough for today's world. In this scenario of mistrust, it is possible to identify the advantages of implementing a blockchain-based system. Blockchain is more resistant to malicious attacks, allowing the acceptance of documents securely and digitally. Our solution uses Ethereum Smart Contracts to verify documents.

## How it works?

The system can be divided into two smart contracts: ValidateData and DataTrack. The first one is responsible for the Digitalization of the data and also the mechanisms of validation. This smart contract also contains functions to facilitate de exposure of ownership, file attributes and also the list of validators. 
<br>
The second one is responsible for the multiple ValidateData contracts. This maintains the history of the documents created. We could do this in a system outside the Blockchain(off-chain). But we believe that this could generate a possible point of manipulation of the stored documents. 