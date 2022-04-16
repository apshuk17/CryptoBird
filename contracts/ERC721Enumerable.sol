// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import './ERC721.sol';
import "./interfaces/IERC721Enumerable.sol";

contract ERC721Enumerable is IERC721Enumerable, ERC721 {
    uint[] private _allTokens;

    // mapping from tokenId to position in _allTokens array
    mapping(uint => uint) private _allTokensIndex;

    // mapping of owner to list of all owned token ids
    mapping(address => uint[]) private _ownedTokens;

    // mapping from tokenId to the index of the owners token list
    mapping(uint => uint) private _ownedTokensIndex;

    // Register the interface or Data Fingerprints for the ERC721Enumerable contract
    // that includes totalSupply, tokenByIndex, tokenOfOwnerByIndex
    constructor() {
        _registerInterface(bytes4(keccak256(abi.encodePacked('totalSupply(address)'))^
            keccak256(abi.encodePacked('tokenByIndex(uint)'))^
            keccak256(abi.encodePacked('tokenOfOwnerByIndex(address,uint)'))));
    }

    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function totalSupply() public override view returns (uint) {
        return _allTokens.length;
    }

    function _mint(address to, uint tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        // 1. Add tokens to the owner
        // 2. All tokens to our total supply - to allTokens

        _addTokensToAllTokenEnumeration(tokenId);
        _addTokenstoOwnerEnumeration(to, tokenId);
    }

    function _addTokensToAllTokenEnumeration(uint tokenId) private {
        // Why length, not length - 1? Because we are pushing the tokenId
        // later and reading the length before.
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokenstoOwnerEnumeration(address to, uint tokenId) private {
        // add address and tokenId to the _ownedTokens
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    // A function that returns token by index
    function tokenByIndex(uint index) external override view returns (uint) {
        // make sure the index is not out of bounds of the total supply
        require(index < totalSupply(), "ERC721Enumerable: Global index is out of bounds!");
        return _allTokens[index];
    }

    // A function that returns token by owner's Index
    function tokenOfOwnerByIndex(address owner, uint index) external override view returns (uint) {
        // make sure the index is not out of bounds of the owners token count
        require(index < balanceOf(owner), "ERC721Enumerable: Owner index is out of bounds!");
        return _ownedTokens[owner][index];
    }
}