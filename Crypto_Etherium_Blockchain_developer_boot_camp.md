# Etherium Blockchain developer boot camp

## Basics

### Metamask setup for developer

Installed on separate developer chrome profile. Not logged in to google or that will sync with main account.

Use test network, Ropsten or Goerli network.  
Facets: use to get test ETH.  

https://etherscan.io/ for block explorer. Locate transactions from Wallet Address or from transaction id.  

Metamask interfaces with Infura service, that has a full blockchain and provides easy services to wallets. 

![](jbnotes_images/Crypto_Etherium_Blockchain_developer_boot_camp_2021-05-27-12-08-40.png)

Create multiple accounts in this wallet, and send test ETH between them. 

### Transaction details

Transaction object has:

- From
- To
- value (integer in Wei, 10-18 eth)
- transaction fee
- data (for smart contracts)
- nonce (integer incremented with each transaction to avoid replay attacks)

How does it know the transaction is allowed? Use signatures.  

### Transaction Signatures

function to sign a transaction.
Needs an unlocked account.

e.g. web3.signTransaction(transactionObject, address)
creates transaction signature using the private keys, get output with v, r, s fields included. These 3 are used to verify the signature.

Private key is 32 bytes, made up of 64 hex characters. 
Can create a public key from a private key using elliptic process (ECDSA).  
Public key used to create Etherium account (using last 20 bytes of the keccak hash of the public key).  
One way, can't go back
Transaction signed with private key generating v, r, s fields.  
With the r and s you can use ECrecover to recreate the public key and the account number.  
This makes it easy to verify that the transaction is valid to come from the account.  

### Cryptographic hashing

Hash function takes input and outputs a long number (digest).

properties:

- small change in input gives a big change in output
- can't recreate the original
- nearly unique
- fast
- deterministic

Blockchain does hashing of hashes.  
Adds new transactions plus previous hash, so all linked together, on many nodes.  
Can't change an old block, need to change all blocks after that.  

On Etherscan, see the block number (sequential). See the parent block. Can walk through the whole blockchain.  

### lab info

https://ethereum-blockchain-developer.com/

### 1st smart contract

Can use various envs, but remix is online smart contract dev environment. https://remix.ethereum.org  
Activate debugger and compiler plugins  
Create new solidity text file, myContract.sol
1st line is pragma line with target version info

HTTP vs HTTPS: Be careful with the https vs http domain. Remix stores edited files in local storage of the browser. If your smart contracts are suddenly gone, look at the protocol. In this course we work with http, not https. This is especially important later when we do private blockchains which require CORS to be setup correctly.

SPDX License identifier: license under which smart contract published.
pragma: tells the compiler which version of solidity (pre-compiler statement).

### Solidity

- derived from ECMA script, javascript.  
- changes in smart contracts need to be mined before they take effect.  
- Compiled language, binary bytecode is sent to the blockchain.  
- every node executes the transaction and checks it's valid.  
- Other languages are Viper, Serpent. But solidity is taking over.  

### Language Structure

- class like structure
- contains functions
- IF/ELSE
- Loops
- variables, datatypes (no floats)
- inheritable
- imports

### Blockchain nodes

Don't want to wait for full deployment to blockchain in a development environment. 2 solutions:

1. use local javascript VM (environment dropdown on deloy and rum)
2. connect to web3 provider in external blockchain. e.g. Ganache truffle suite. Install for windows. It's a local app, runs RPC server.  

Multiple implementations of Etherium nodes, e.g. Parity, GoEtherium are 2 implementations, both know how to talk the Etherium protocol to other nodes.  
Nodes can be private: there's a main Etherium blockchain, but you can use the Etherium protocol to set up a private network.  
You could e.g. fork the data on the main network, copy the data, run a private network.  
Genesis block is the first block, need to configure this in your private network.  

### Test networks

Lots of Etherium test networks. May be be in advance of main network, these still require mining.  
Slight differences, so you should test on a real network after developing on Ganache.  
Test network transactions can be deleted.  

- Ropstan is a clone of the real network.
- Girly, kovan beta testing
- Ganache is a developer network, more for unit testing. Fast mining, not persistent.  
- Private, run your own chain.

### deploy a contract with Remix

- use developer chrome profile
- Go to Remix to write smart contract
https://remix.ethereum.org/#optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.1+commit.df193b15.js
- activate plugins for smart contact compiler, and deploy and run.
- compile
- on deploy and run, choose injected web 3 as the source of the deployment (that's metamask)
- that opens metamask, make sure the account is active. May have to refresh the page.
- choose the contact
- deploy
- wait for mining
- test

### Local Javascript VM blockchain in Remix

The JavaScript VM is a simulated Blockchain Environment that only exists in your browser. It also only exists as long as you keep the browser-tab open. Close it or reload it, you start from scratch.

On the positive side: it's super fast! No waiting for Transactions to be mined. No complicated setup. It's just there and it works out of the box

On the negative side: There's only limited ways to connect to it. Once you reload everything is gone (non persistant). Sometimes things in the browser simulation work, which won't work on a real blockchain.

Just choose it on the remix dropdown, and it works, but you can't do much, Ganache is better.

### Ganache

Connecting using a Web3 Provider actually establishes a connection to a software outside of the browser. Like you'd connect to a database. Or to any other API. It's either a RESTful interface or a WebSocket interface. And behind that interface sits a blockchain. This can be Go-Ethereum, Hyperledger Besu, Nethereum - or - Ganache for Development.

https://www.trufflesuite.com/ganache

Quickstart crates 10 accounts with 100 Eth

Http end point: HTTP://127.0.0.1:7545

Ganache is now a Blockchain and a Wallet. Two in one. Anyone can connect to it using a Web3 Provider Method either via http RPC or WebSockets.  

Deploy to ganache by choosing web3 provider in remix, paste in the RPC server id (http:127...) and deploy. Quick.  

### Cheat sheets

![](jbnotes_images/Crypto_Etherium_Blockchain_developer_boot_camp_2021-06-11-17-09-17.png)

![](jbnotes_images/Crypto_Etherium_Blockchain_developer_boot_camp_2021-06-11-17-10-06.png)

### variables

```solidity
uint256 public myInt;
# all variables are initialized to false, zero etc
# uint is a unit256

function setMyUint(uint _myUint) public {
    myUint = -myUint
}

bool public myBool;

function setMyBool(_myBool bool) public {
    myBool = _myBool
}

# wraparound
# uint8 goes from 0 to 255
uint8 public myUin8;

function incrementMyUint8() public {
    myUint8++
}

function decrementMyUint8() public {
    myUint8--
}

# increment 0 -> 1
# decrement 1->0->255
# no warnings on wrap around need to take care yourself

# address
address public myAddress;

function setAddress(_myAddress) public {
    myAddress = _myAddress
}

function getBalanceOfAddress() public view returns(uint) {
    # view function read only
    return myAddress.balance;
    # balance stored on blockchain in wei
    # return address(this).balance to get the balance of this smart contract
}

# strings
# need to specify memory type, different gas price. 
internally stored as byte array. no string manipulation functions, expensive to use. Easier to store outside in blockchain, hash in blockchain.
string public myString = "hello world";

function setMyString(string memory _myString) public {
    myString = _myString
}
```

All variables

- initialized as default
- no null or undefined
- public variables have an auto getter generated, same name.
- reference types need to specify memory location (either memory or storage, generally use memory.

Integers

- uint8 to uint256 in 8 bit increments
- Int8 from -128 to 127
- Uint8 from 0 to 255
- auto wrap around, until version 0.8
- after 0.8, decrement zero gives error and rolls back transaction
- to keep the wrap around behavior, use unchecked block
- unchecked {myUint8--;}

Floats

- not implemented yet!
- set decimal point variable and use ints

Addresses

- Every interaction address based
- 20 byte values
- has Balance value
- "address payable" has additional values, amount and from.

Strings and Bytes

- both are special arrays
- don't really use as few manipulations, expensive
- for byte arrays can access an index

### Transaction vs Call

A transaction is necessary, if a value in a Smart Contract needs to be updated (writing to state). A call is done, if a value is read (a view method). Transactions cost Ether (gas), need to be mined and therefore take a while until the value is reflected, which you will see later. Calls are virtually free and instant.

### Important Concepts

- The Smart Contract is stored under its own address
- The Smart Contract can store an address in the variable "myAddress", which can be its own address, but can be any other address as well.
- All information on the blockchain is public, so we can retrieve the balance of the address stored in the variable "myAddress"
- The Smart Contract can transfer funds from his own address to another address. But it cannot transfer the funds from another address.
- Transferring Ether is fundamentally different than transferring ERC20 Tokens, as you will see later.

### strings

- Natively, there are no String manipulation functions.
- No even string comparison is natively possible
- There are libraries to work with Strings
- Strings are expensive to store and work with in Solidity (Gas costs, we talk about them later)
- As a rule of thumb: try to avoid storing Strings, use Events instead (more on that later as well!)

### transferring funds

- make a function 'payable' if it needs to send / receive funds (since 0.8, need to make the address a payable)
- get balance of this smart contract with address(this).balance
- message object is a global available inside the contract during the transaction
  - message.value property is the amount in wei stored with this transaction (sent to the smart contract)
  - message.sender is the address which called the smart contract
- address object has a transfer function, 1 arg which is the amount.

### account definitions

- Externally owned accounts: private key behind it. External accounts live on the edge of the blockchain, have a balance on the blockchain, store funds. Ledger stores the balance of the address.
- Contract account: inside the blockchain, code is there to manage account, no private key. Has a balance, stores funds.

Initiate transaction from an external account to a contract account.  
Contract accounts can't initiate transactions, have to be externally triggered.  

Atomic transactions, during this a contract can interact with another contract account, but always external initiation.

Address has 2 important members:

- address.balance
- address.transfer(amount)
- address.send() returns boolean for success / fail, you need to recover, older version of transfer, doesn't cascade exceptions.
- address.call.gas().value() lets you forward a specific amount of gas

send and transfer both only transfer 2300 gas.  

Global Objects

- msg.sender: the address of the account initialising the transaction
- msg.value: how much Eth
- now: the current timestamp, but not very reliable

payable functions addresses

A function can't receive either unless

- function marked as payable (function MyFunc() public payable{})
- address marked as payable (address payable MyAddress)
- will fail with exception otherwise

### Start stop update smart contracts

check for owner permissions:

constructor() - called only during contract deployment. Good to save msg.sender to variable owner, then check operations with require statement. 
Require checks if a specific state is met at a specific point
e.g. require(msg.sender == owner, "you are not the owner")

Pause contract:

set a paused boolean variable

Destroy:

Call solidity function selfDestruct, argument for address to receive remaining funds.  
historical data remains on blockchain, but current state is dead, can't interact.  
Address has no code, but can still send ether there, but can;'t get it back - no error codes.  
Can deploy to same address if use CREATE2 addresses where you specify the contract address.  
Contract address is normally derived from external account + nonce.  

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract StartStopUpdateExample {

    
    address public creator;
    bool public paused;

    // constructor runs on contract creation, can't be called again. special name.
    constructor() {
        creator = msg.sender;
    }
    
    function setPaused(bool _paused) public {
        require(msg.sender == creator, "cant pause not the creator");
        paused = _paused;
    } 
    
    function sendMoney() public payable {
    // just receives money from external account    
    }
    
    function withdrawAllMoney(address payable _to) public {
        // require checks state
        require(msg.sender == creator, "You are not the creator, not allowed");
        require(paused == false, "paused so can't withdraw");
        _to.transfer(address(this).balance);
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    // destroy function
    function destroy(address payable _to) public {
        require(msg.sender == creator, "youre not allowed");
        require(!paused, "no");
        selfdestruct(_to);
    }
}
```

### immutable blocks and lifecycle

Nodes download all blocks, build up state tree.  
If delete an intermediate block, would need to delete on all nodes.  
Lifecycle: start, gets address, running, stop.  

- deploy: sendTransaction(from.., to: (empty), data: contract byte code)
- interact: sendTransaction(to: smart contract address, data: encoded interaction with function calls and arguments, value: amount in Wei)
- destroy: call selfDestruct(address to send funds) in a solidity function
- then not available for interaction

smart contracts compiled and sent to the blockchain as a transaction
once mined transactions are immutable.  

### Mappings

store value lke key map or array.
mapping(key type => value type) myMapping
e.g. mapping(uint => bool) public MyMapping
automatically initialized with default values.
index can be e.g. address
Access with e.g. address[123], no out of bounds exceptions as all possible key/values pairs are default initialized.  
can do mappings of mappings: mapping (uint => mapping(uint => bool)) uintUintBoolMapping;
good for e.g. storing balance for each address.  

```solidity
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract SimpleMappingExample {

    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;
    mapping (uint => mapping(uint => bool)) uintUintBoolMapping;
    
    function setValue(uint _index) public {
        myMapping[_index] = true;
    }

    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }

    function set2dMappingValue(uint _1d, uint _2d, bool _bool) public {
        uintUintBoolMapping[_1d][_2d] = _bool;
    }

    function get2dMappingValue(uint _1d, uint _2d) view public returns(bool) {
        return uintUintBoolMapping[_1d][_2d];
    }
}
```

### checks effects interaction pattern

1. check you are ok to do the transaction
2. make the effects
3. do interactions with other accounts (interaction needs to come last, prevents re-entry bug)

### Variable types

- Mappings.
  - Like hashmaps
  - key to value
  - Keys can be any solidity type
  - value type can be any type, including mappings.
  - all values initialized by default.
  - don't have a length, unless you implement it separately
  - generally can't iterate because no length, but external library has iterable mappings
  - access with map[key]
- Structs
  - custom variable types
  - access with struct.member
  - member can't be same type of struct iteslf, but can be another struct
- Arrays
  - Fixed or dynamic size
  - T[k] : fixed size of typer T, k elements
  - T[] : dynamic of T
  - T[][5] : 5 dynamic arrays.
  - be careful of gas costs, mappings are cheaper
  - members to array.push(element), array.length
- Enums
  - Another way to get user defined types
  - e.g. enum ActionChoices { left, right, up, down}
  - converts and stores as uint8, or more if > 256 values.

Mappings are better then arrays.

