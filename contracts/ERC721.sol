// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./ERC165.sol";
import "./interfaces/IERC721.sol";

/*
    Building out the minting function:

    a. NFT to point to an address
    b. Keep tarck of the token id's. NFT's are tokens.
    c. Keep track of token owner addresses to token id's.
    d. Keep track of how many tokens(NFT's) an owner address has.
    e. Create an event that emits a transfer log - 
    contract address, where it is being mented to, the id
**/

contract ERC721 is ERC165, IERC721 {

    // mapping from token id to owner
    mapping(uint => address) private _tokenOwner;

    // mapping from owner to the number of owned tokens
    mapping(address => uint) private _ownedTokensCount;

    // mapping from token id to approved address
    mapping(uint => address) private _tokenApprovals;

    // Register the interface or Data Fingerprints for the ERC721 contract
    // that includes balanceOf, ownerOf, transferFrom, approve
    constructor() {
        _registerInterface(bytes4(keccak256(abi.encodePacked('balanceOf(address)'))^
            keccak256(abi.encodePacked('ownerOf(uint)'))^
            keccak256(abi.encodePacked('transferFrom(address,address,uint)'))^
            keccak256(abi.encodePacked('approve(address,uint)'))));
    }


    // Check the existence of token in the _tokenOwner
    function _exists(uint tokenId) internal view returns(bool) {
        // reading the owner's address of the tokenId
        address owner = _tokenOwner[tokenId];
        // return the truthiness of the owner
        return owner != address(0);
    }

    function _mint(address to, uint tokenId) internal virtual {
        // requires that address isn't zero
        require(to != address(0), "ERC721: minting to the zero address");
        // requires that tokenId does not already exist
        require(!_exists(tokenId), "ERC721: token already minted");
        // adding or minting a new token 
        _tokenOwner[tokenId] = to;
        // Keeping track of addresses and the count of tokens they mint
        _ownedTokensCount[to] += 1;
        // emit the transfer event
        emit Transfer(address(0), to, tokenId);
    }

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) public override view returns(uint) {
        require(_owner != address(0), "ERC721: Owner query for non-existent token");
        return _ownedTokensCount[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint _tokenId) public override view returns(address) {
        require(_exists(_tokenId), "ERC721: token does not exist");
        return _tokenOwner[_tokenId];
    }

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        // require that the address receiving a token is not a zero address
        require(_to != address(0), "ERC721: Transfer to the zero address");

        // require the address transferring the token actually owns the token
        require(ownerOf(_tokenId) == _from, "ERC721: Trying to transfer a token not owned by the rightful owner!");
        // 1. Add the tokenId to the address receiving the token
        _tokenOwner[_tokenId] = _to;
        // 2. Update the balance of the address _from token
        _ownedTokensCount[_from] -= 1;
        // 3. Update the balance of the address _to
        _ownedTokensCount[_to] += 1;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint _tokenId) external override {
        require(isApprovedOrOwner(msg.sender, _tokenId), "");
        _transferFrom(_from, _to, _tokenId);
    }

    function approve(address _to, uint _tokenId) external override {
        // require that we can't approve sending tokens of the owner to owner (current caller)
        address owner = ownerOf(_tokenId);
        require(_to != owner, "ERC721 - Approval to owner");

        // require that the person approving is the owner
        require(msg.sender == owner, "ERC721 - Current caller is not the owner of the token");

        // update the map of the approval addresses
        _tokenApprovals[_tokenId] = _to;

        emit Approval(owner, _to, _tokenId);
    }

    function isApprovedOrOwner(address spender, uint tokenId) internal view returns(bool) {
        address owner = ownerOf(tokenId);
        return (spender == owner);
    }

}