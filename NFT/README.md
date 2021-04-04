# Non-fungible Tokens
Non-fungible tokens generic example.

## What it is ?

Non-fungible tokens are unique entities that can’t be replaced with something else. For example, a one-of-a-kind trading card is non-fungible. If you traded it for a different card, you’d have something completely different. NFTs can be anything digital, but a lot of the current excitement is around using the tech to sell digital art.

## How it works?

Generally, these NTFs use the same token structure. The ERC-721 standard is a type of token created for an Ethereum network under the standards of its smart contracts. This pattern was designed to create interchangeable tokens, but with the particularity of being unique and not expendable. We had created a file containing the interface with this token pattern. This is the interface of our token. The main difference about a fungible token is the existence of a unique ID for each token.

<br>

In the next file, we will create the product ownership structure. Modifiers are used to change the behavior of functions. This contract is declaring the onlyOwnerOf modifier that checks whether the account that is interacting with the contract is the owner of a particular product. The required function throws an exception if the condition is not met. The NFT interface has the methods and events that must be implemented by our token, the ProductFactory has the data structure and the function responsible for creating new products and the ProductOwnership contract implements the methods of the NFT interface.
