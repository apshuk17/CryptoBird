// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./interfaces/IERC721Metadata.sol";
import "./ERC165.sol";

contract ERC721Metadata is IERC721Metadata, ERC165 {
    string private _name;
    string private _symbol;

    constructor(string memory named, string memory symboled) {
        _registerInterface(bytes4(keccak256(abi.encodePacked('name()'))^
        keccak256(abi.encodePacked('symbol()'))));
        
        _name = named;
        _symbol = symboled;
    }

    function name() external override view returns(string memory) {
        return _name;
    }

    function symbol() external override view returns(string memory) {
        return _symbol;
    }
}