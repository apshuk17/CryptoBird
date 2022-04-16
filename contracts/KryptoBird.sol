// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import './ERC721Connector.sol';

contract KryptoBird is ERC721Connector {

    // array to store our nft's
    string[] public kryptoBirdz;

    mapping(string => bool) _kryptoBirdzExists;

    function mint(string memory _kryptoBird) public {
        require(!_kryptoBirdzExists[_kryptoBird], "Error - Kryptobird already exists");
        kryptoBirdz.push(_kryptoBird);
        uint _uid = kryptoBirdz.length - 1;

        _mint(msg.sender, _uid);

        _kryptoBirdzExists[_kryptoBird] = true;
    }
    constructor() ERC721Connector('Kryptobird', 'KBIRDZ') {}
}