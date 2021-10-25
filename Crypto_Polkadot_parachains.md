# Polkadot parachains

## Polkadot JS

polkadot.js website shows block explorer, status etc.  
Block time 6s  
can see Kasuma auctions on here  
Can see the validators (max 297), waiting validators etc. 

1 era = 6 epochs
epoch is about 4 hours

Inflation rate depends on currently staked vs ideal staked. Staking rewards based on this. 

Nominator choses validators.  
You need to choose a validator which will be picked to be an active validator. Only a proportion (currently 30%) of validators at any time (max 297) are active. Targets tab shows the expected returns from each validator.  

### account on polkadot.js

browser extension, or ledger.  
With browser extension, generates keys.  
Generic accounts, so works on any substrate. That means you can create an account on any of the networks.  
Account is portable, can move to different wallets via JSON export / import.  

Go to web site to transact with. Allow access to the browser wallet. 

### auctions

network -> parachains -> parathreads (candidate parachains, need to win an auction first). 
crowdloan to fund the auction for parachain slot.
Crowdloans manaed by network, so don't use transfer. Just lock up.  
Locked until lease period ends or you loose the auction.  

### Staking

Create an account on polkadot.js browser extension.  
Min bonding is now 120 DOT.  

Simple but less secure way to stake:

- network -> staking -> actions
- use same acouunt vfor stash and controller accounts as simpler  
- can control is staking rewards go to same acocunt or specific account.
- targets tab in staking page shows the expected staking rewards
- make sure validator is not oversubscribed

more security:

- stash account should be on a cold wallet, and use a controller account to control the staked funds in the stash account. 
- controller account has funds for fees
- create a new account as controller for stash account

### Add ledger wallet to polkadot.js extension

https://www.youtube.com/watch?v=KjgWehjRWek  
pokldot.js  
menu option to attach ledger account  







