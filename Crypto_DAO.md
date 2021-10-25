# Crypto DAO

## Definition

- group of stakeholders
- work within smart contract decision making system
- generally rewarded for contributions
- governance by vote, generally based on token ownership
- organise the work amongst DAO members

A decentralized autonomous organization (DAO) is a set of smart contracts running on a blockchain that coordinate multiple parties to achieve a specific goal. DAOs mimic traditional organizations — both are trusted by diverse stakeholders (that do not necessarily trust each other) to facilitate multi-party processes. However, what differentiates DAOs from traditional organizations is their decentralized and autonomous properties. This can be best explained by breaking down each term:

- Decentralized: DAOs are not organized hierarchically or controlled by any single entity; rather, they are openly accessible and governed in a distributed manner.
- Autonomous: the operating rules of a DAO are not subject to interpretation; rather, business logic is auto-enforced by programmable smart contracts after predefined conditions are met
- Organization: DAOs are digital representations of traditional organizations, which have a common purpose, coordinated effort, division of labor, and trusted authority.

The decentralized and autonomous properties of DAOs protect them from external and internal errors and attacks — in other words, no single entity can stop, change, or manipulate a DAO. This concept is being explored across the blockchain industry for insurance, finance, art, and more. In the IoT space, DAOs will play a critical role to coordinate trusted interactions between a large number of humans and machines.

- avoid the problems of centralised and hierarchical control
- better information freedom
- aligns interests of the peers, gets away from owners vs customers.


## Setup

1. Create a set of rules, and program these to smart contracts. This allows automation and enforcement without human bias.

2. Set up initial treasury. This is an incentive to reward those participating. Funding for projects and costs. Generally token based rewards, receive the token created by the group for doing work for the group. Best to have regular funding, or you end up with funds dwindling and initiatives not working.

3. Let it run autonomously

## Governance

Can have e.g. community voting on projects, but then higher level senior people vote again. Don't need to be completely decentralised.

Inefficient to have distributed decisions, not have a leader. So Technology for votes, and for collective attention. So need to decide on rules for who can propose changes. Incentivize people to work for the greater good.

## Problems

Aiming for decision making to be fair and transparent, but that means loss of confidentiality. Also security risks.

You may have DOA funds in a multi sig wallet, but the reality of DeFi is that you need the funds in a compatible wallet to take action (staking, exchanging etc) and that is a point of risk. Person dies, runs off, subject to tax, govt control etc.

## Tokens

### Token creation

Write a smart contract.  
put liquidity into it. This needs to be transparent, so people can see it's genuine. Get liquidity tokens, potentially burn tokens so you make remainder more valuable. Need to have no rub pull ability for the Devs, that means no mint function, no self destruct.  

### Token promotion

Put in some money.  
Web site.  
Marketing budget  

### Token information

Take a look at new tokens in https://poocoin.app/ape
Look at smart contract.  
Check for a mint function.  
check how many wallets, how many transactions.  

### Simpler setups

DAOstack to create a DAO on Etherium
Set voting parameters. Can do voting offline with no transaction costs using e.g. snapshot

## Examples

### FWB

Initially open to everyone holding 60 tokens. Now community to review applications.Everyone fills out a form. Reviewers get rewards.  
Earn tokens for contributing to discord. 
Analytics to work out which channels and contributions generate interest.  

buy FWB tokens for membership.  
Tokens aridropped  

### Curation networks

Curation networks leverage the wisdom of the crowd to rank the subjective quality of objects. What content should be featured in the feed, or the newsletter? How trustworthy is this company? How good is the food at that diner?

Examples include decentralized versions of the following:

- Restaurant or hotel guides, similar to Yelp or TripAdvisor
- Article or video feeds, akin to social news feeds or Reddit
- Website listings, like a socially curated Google search

### Dara

#### Tokenomics

There will be a maximum total of 42,000,000 DARA tokens  

- Team (15%, vested over 12 months)
- Angel/Adviser* (15%, vested over 12 months)
- The DAO Fund (10%, locked)
- Marketing (3%, unlocked and distributed after launch)
- DARA token liquidity for Pancakeswap DEX (21%, locked)
- Public Sale (36% ,unlocked and distributed after launch)

The sale of 15,120,000 DARA will take place on DXSale, and will be held on August 8th. The hard cap of the sale will be 200 BNB, and the soft cap 100 BNB.  
70% of the BNB raised in the sale will immediately be locked as liquidity for the Pancakeswap decentralised exchange  
DARA will be listed on Pancakeswap and open for trading immediately after the conclusion of a successful sale  
All unsold tokens will be burned.

#### The Business Model — Freemium

- The Immutable will use the freemium model combined with The DAO Fund to create a self-sustaining economy.  
- The core features of DARA and future products will be free. The premium features will have a small cost  
- DARA is the first of many products that collectively form The Immutable Network  
- The DAO Fund pays for Immutable’s fleet of IPFS nodes  
- 50% of the revenue generated from premium feature will go back into The DAO Fund
- The other 50% of revenue from premium features is paid out to DARA token holders on a regular basis  
- Decentralised voting in the DAO unlocks funds in The DAO Fund, and the community controls   Immutable’s store of knowledge and products, of which DARA is the first.  
- Holding the DARA token entitles you to share in the revenue from ALL The Immutable Network products.  

#### What is the DARA token used for?

- The DARA token is used to pay for all premium features across all Immutable Network products and services
- DARA token holders share 50% of all revenue from premium features
- DARA token holders vote on the future of The Immutable Network and The DAO Fund

#### What is The DAO Fund used for?

1. DARA token holders vote on the spending/allocation of The DAO Fund
2. The DAO Fund receives 50% of the revenue from premium features
3. From genesis, The DAO Fund pays for the cluster of IPFS nodes Immutable runs to ensure data integrity. This can always be changed through DAO proposals
4. People can submit product concepts or other proposals to The DAO Fund, and the proposals can be approved/disapproved through decentralised voting.
5. The DAO Fund starts life holding 10% of DARA tokens.

## Solutions

### Meryt

https://medium.com/meryt-protocol/meryt-initial-dao-use-case-is-on-chain-investment-decisions-execution-e815c1d1c71

Offers tools for consensus management, and execution to e.g. provide liquidity until a price is reached.  

### Gen

Large organizations need to make lots of decisions quickly, so in order for DAOs to scale, they must be able to make voter-aligned decisions at a high frequency. To do that, we need to ensure that a DAO can focus its attention on only the most important issues, and when it focuses, quickly make decisions that are aligned with its members’ views.

This is where the GEN token comes into play. GEN is a cryptocurrency that manages attention within the DAOstack ecosystem. GEN cannot buy voting power, nor does holding it grant voting privileges, but you can use GEN to place a stake for or against a proposal. This stake influences whether or not the proposal rises into the collective attention of the voters. If you stake for proposals that the voters then pass, you’re rewarded with more GEN. If you stake for a proposal that then fails, you lose your GEN. And vice versa if you stake against a proposal.
This staking system effectively amounts to a prediction market that runs in parallel to the voting apparatus.

Since predictors are incentivized to pick out the best, most DAO-aligned proposals, we can lower the passing requirements for the top predicted proposals: these proposals can be passed much more quickly and with fewer total votes than other proposals. This creates a dynamic we call holographic consensus. Here, as in a hologram, a smaller part of the whole (a small group of voters) can be made to effectively represent the whole (all the voters), allowing DAOs to make fast decisions while maintaining value-alignment. This effect is compounded by opening the staking system to anyone, be they a voting member of the DAO or not.


